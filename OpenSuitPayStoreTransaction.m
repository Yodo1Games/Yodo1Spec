//
//  OpenSuitPayStoreTransaction.m
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

#import "OpenSuitPayStoreTransaction.h"

NSString* const OpenSuitPayStoreCoderConsumedKey = @"consumed";
NSString* const OpenSuitPayStoreCoderRechargedKey = @"recharged";
NSString* const OpenSuitPayStoreCoderProductIdentifierKey = @"productIdentifier";
NSString* const OpenSuitPayStoreCoderTransactionDateKey = @"transactionDate";
NSString* const OpenSuitPayStoreCoderTransactionIdentifierKey = @"transactionIdentifier";
NSString* const OpenSuitPayStoreCoderOrderIdKey = @"orderIdKey";

@implementation OpenSuitPayStoreTransaction

- (instancetype)initWithPaymentTransaction:(SKPaymentTransaction*)paymentTransaction
{
    if (self = [super init])
    {
        _productIdentifier = paymentTransaction.payment.productIdentifier;
        _transactionDate = paymentTransaction.transactionDate;
        _transactionIdentifier = paymentTransaction.transactionIdentifier;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        _consumed = [decoder decodeBoolForKey:OpenSuitPayStoreCoderConsumedKey];
        _recharged = [decoder decodeBoolForKey:OpenSuitPayStoreCoderRechargedKey];
        _productIdentifier = [decoder decodeObjectForKey:OpenSuitPayStoreCoderProductIdentifierKey];
        _transactionDate = [decoder decodeObjectForKey:OpenSuitPayStoreCoderTransactionDateKey];
        _transactionIdentifier = [decoder decodeObjectForKey:OpenSuitPayStoreCoderTransactionIdentifierKey];
        _orderId = [decoder decodeObjectForKey:OpenSuitPayStoreCoderOrderIdKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeBool:self.recharged forKey:OpenSuitPayStoreCoderRechargedKey];
    [coder encodeBool:self.consumed forKey:OpenSuitPayStoreCoderConsumedKey];
    [coder encodeObject:self.productIdentifier forKey:OpenSuitPayStoreCoderProductIdentifierKey];
    [coder encodeObject:self.transactionDate forKey:OpenSuitPayStoreCoderTransactionDateKey];
    if (self.transactionIdentifier != nil) {
        [coder encodeObject:self.transactionIdentifier forKey:OpenSuitPayStoreCoderTransactionIdentifierKey];
    }
    if (self.orderId != nil) {
        [coder encodeObject:self.orderId forKey:OpenSuitPayStoreCoderOrderIdKey];
    }
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
