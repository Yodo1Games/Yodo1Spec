//
//  OpenSuitPayStoreUserDefaultsPersistence.m
//  OpenSuitPayStore
//
//  Created by Hermes on 10/16/13.
//  Copyright (c) 2013 Robot Media. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "OpenSuitPayStoreUserDefaultsPersistence.h"
#import "OpenSuitPayStoreTransaction.h"
#import "OpenSuitPayment.h"
#import "OpenSuitCommons+PayParameters.h"
#import "OpenSuitCommons+Cache.h"
#import "OpenSuitPayManager.h"

NSString* const OpenSuitPayStoreTransactionsUserDefaultsKey = @"OpenSuitPayStoreTransactions";

@implementation OpenSuitPayStoreUserDefaultsPersistence

#pragma mark - OpenSuitPayStoreTransactionPersistor

- (void)persistTransaction:(SKPaymentTransaction*)paymentTransaction
{
    NSUserDefaults *defaults = [self userDefaults];
    NSDictionary *purchases = [defaults objectForKey:OpenSuitPayStoreTransactionsUserDefaultsKey] ? : @{};
    
    SKPayment *payment = paymentTransaction.payment;
    NSString *productIdentifier = payment.productIdentifier;

    NSArray *transactions = purchases[productIdentifier] ? : @[];
    NSMutableArray *updatedTransactions = [NSMutableArray arrayWithArray:transactions];
    
    __block OpenSuitPayStoreTransaction *transaction = [[OpenSuitPayStoreTransaction alloc] initWithPaymentTransaction:paymentTransaction];
    
    NSString* oldOrderIdStr = [OpenSuitCommons keychainWithService:productIdentifier];
    NSArray* oldOrderId = (NSArray *)[OpenSuitCommons JSONObjectWithString:oldOrderIdStr error:nil];
    NSMutableArray* newOrderId = [NSMutableArray array];
    if (oldOrderId) {
        [newOrderId setArray:oldOrderId];
    }
    for (NSString* oderid in oldOrderId) {
        if ([oderid isEqualToString:OpenSuitPayment.shared.itemInfo.orderId]) {
            transaction.orderId = oderid;
            [newOrderId removeObject:oderid];
            break;
        }
        transaction.orderId = oderid;
        [newOrderId removeObject:oderid];
        break;
    }
    NSString* orderidJson = [OpenSuitCommons stringWithJSONObject:newOrderId error:nil];
    [OpenSuitCommons saveKeychainWithService:productIdentifier str:orderidJson];
    __weak typeof(self) weakSelf = self;
    if (!transaction.orderId) { //杀死进程/重新安装应用
        NSString* uniformProductId = [OpenSuitPayManager.shared uniformProductIdWithChannelProductId:productIdentifier];
        [OpenSuitPayManager.shared createOrderIdWithUniformProductId:uniformProductId
                                                            extra:@""
                                                           callback:^(bool success, NSString * _Nonnull orderid, NSString * _Nonnull error) {
            if (success) {
                transaction.orderId = orderid;
                NSData *data = [weakSelf dataWithTransaction:transaction];
                [updatedTransactions addObject:data];
                [weakSelf setTransactions:updatedTransactions forProductIdentifier:productIdentifier];
            }else{
                OpenSuitPayStoreLog(@"创建订单失败 --> error:%@",error);
            }
        }];
    } else {
    NSData *data = [self dataWithTransaction:transaction];
    [updatedTransactions addObject:data];
    [self setTransactions:updatedTransactions forProductIdentifier:productIdentifier];
}
}

#pragma mark - Public

- (void)removeTransactions
{
    NSUserDefaults *defaults = [self userDefaults];
    [defaults removeObjectForKey:OpenSuitPayStoreTransactionsUserDefaultsKey];
    [defaults synchronize];
}

- (BOOL)consumeProductOfIdentifier:(NSString*)productIdentifier
{
    NSUserDefaults *defaults = [self userDefaults];
    NSDictionary *purchases = [defaults objectForKey:OpenSuitPayStoreTransactionsUserDefaultsKey] ? : @{};
    NSArray *transactions = purchases[productIdentifier] ? : @[];
    for (NSData *data in transactions)
    {
        OpenSuitPayStoreTransaction *transaction = [self transactionWithData:data];
        if (!transaction.consumed)
        {
            transaction.consumed = YES;
            NSData *updatedData = [self dataWithTransaction:transaction];
            NSMutableArray *updatedTransactions = [NSMutableArray arrayWithArray:transactions];
            NSInteger index = [updatedTransactions indexOfObject:data];
            updatedTransactions[index] = updatedData;
            [self setTransactions:updatedTransactions forProductIdentifier:productIdentifier];
            return YES;
        }
    }
    return NO;
}

- (BOOL)consumeProductOfOrderId:(NSString *)orderId {
    NSSet* productIdentifiers = [self purchasedProductIdentifiers];
    for (NSString* productIdentifier in productIdentifiers.allObjects) {
        NSArray* transactions = [self transactionsForProductOfIdentifier:productIdentifier];
        for (OpenSuitPayStoreTransaction* transaction in transactions) {
            if ([transaction.orderId isEqual:orderId]) {
                [self consumeProductOfIdentifier:productIdentifier];
                return YES;
            }
        }
    }
    return NO;
}

- (BOOL)rechargedProuctOfIdentifier:(NSString *)productIdentifier {
    NSUserDefaults *defaults = [self userDefaults];
    NSDictionary *purchases = [defaults objectForKey:OpenSuitPayStoreTransactionsUserDefaultsKey] ? : @{};
    NSArray *transactions = purchases[productIdentifier] ? : @[];
    for (NSData *data in transactions)
    {
        OpenSuitPayStoreTransaction *transaction = [self transactionWithData:data];
        if (!transaction.recharged)
        {
            transaction.recharged = YES;
            NSData *updatedData = [self dataWithTransaction:transaction];
            NSMutableArray *updatedTransactions = [NSMutableArray arrayWithArray:transactions];
            NSInteger index = [updatedTransactions indexOfObject:data];
            updatedTransactions[index] = updatedData;
            [self setTransactions:updatedTransactions forProductIdentifier:productIdentifier];
            return YES;
        }
    }
    return NO;
}

- (NSInteger)countProductOfdentifier:(NSString*)productIdentifier
{
    NSArray *transactions = [self transactionsForProductOfIdentifier:productIdentifier];
    NSInteger count = 0;
    for (OpenSuitPayStoreTransaction *transaction in transactions)
    {
        if (!transaction.consumed) { count++; }
    }
    return count;
}

- (BOOL)isPurchasedProductOfIdentifier:(NSString*)productIdentifier
{
    NSArray *transactions = [self transactionsForProductOfIdentifier:productIdentifier];
    return transactions.count > 0;
}

- (NSSet*)purchasedProductIdentifiers
{
    NSUserDefaults *defaults = [self userDefaults];
    NSDictionary *purchases = [defaults objectForKey:OpenSuitPayStoreTransactionsUserDefaultsKey];
    NSSet *productIdentifiers = [NSSet setWithArray:purchases.allKeys];
    return productIdentifiers;
}

- (NSArray*)transactionsForProductOfIdentifier:(NSString*)productIdentifier
{
    NSUserDefaults *defaults = [self userDefaults];
    NSDictionary *purchases = [defaults objectForKey:OpenSuitPayStoreTransactionsUserDefaultsKey];
    NSArray *obfuscatedTransactions = purchases[productIdentifier] ? : @[];
    NSMutableArray *transactions = [NSMutableArray arrayWithCapacity:obfuscatedTransactions.count];
    for (NSData *data in obfuscatedTransactions)
    {
        OpenSuitPayStoreTransaction *transaction = [self transactionWithData:data];
        [transactions addObject:transaction];
    }
    return transactions;
}

- (NSUserDefaults *)userDefaults
{
    return [NSUserDefaults standardUserDefaults];
}

#pragma mark - Obfuscation

- (NSData*)dataWithTransaction:(OpenSuitPayStoreTransaction*)transaction
{
    NSData *data = nil;
    NSError *error = nil;
    if (@available(iOS 11.0, *)) {
        data = [NSKeyedArchiver archivedDataWithRootObject:transaction requiringSecureCoding:YES error:&error];
        if (error){
            OpenSuitPayStoreLog(@"保存数据error:%@",error);
        }
    } else {
        data = [NSKeyedArchiver archivedDataWithRootObject:transaction];
    }
    return data;
}

- (OpenSuitPayStoreTransaction*)transactionWithData:(NSData*)data
{
    NSError *error = nil;
    OpenSuitPayStoreTransaction* transaction = nil;
    NSSet* sets = [NSSet setWithArray:@[NSArray.class,
                                        NSDictionary.class,
                                        OpenSuitPayStoreTransaction.class,
                                        NSString.class,
                                        NSNumber.class,
                                        NSDate.class]];
    if (@available(iOS 11.0, *)) {
        transaction = [NSKeyedUnarchiver unarchivedObjectOfClasses:sets fromData:data error:&error];
        if (error) {
            OpenSuitPayStoreLog(@"load数据error:%@",error);
        }
    } else {
        transaction = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return transaction;
}

#pragma mark - Private

- (void)setTransactions:(NSArray*)transactions forProductIdentifier:(NSString*)productIdentifier
{
    NSUserDefaults *defaults = [self userDefaults];
    NSDictionary *purchases = [defaults objectForKey:OpenSuitPayStoreTransactionsUserDefaultsKey] ? : @{};
    NSMutableDictionary *updatedPurchases = [NSMutableDictionary dictionaryWithDictionary:purchases];
    updatedPurchases[productIdentifier] = transactions;
    [defaults setObject:updatedPurchases forKey:OpenSuitPayStoreTransactionsUserDefaultsKey];
    [defaults synchronize];
}

@end
