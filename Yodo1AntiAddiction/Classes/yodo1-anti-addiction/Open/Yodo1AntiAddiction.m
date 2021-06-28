//
//  Yodo1AntiAddiction.m
//  yodo1-anti-Addiction-ios
//
//  Created by ZhouYuzhen on 2020/10/2.
//

#import "Yodo1AntiAddiction.h"
#import "Yodo1AntiAddictionHelper.h"

@implementation Yodo1AntiAddictionEvent

@end

@implementation Yodo1AntiAddictionProductReceipt

@end

@interface Yodo1AntiAddiction () {
    BOOL lockBehavior;
}

@end

@implementation Yodo1AntiAddiction

+ (Yodo1AntiAddiction *)shared {
    static Yodo1AntiAddiction *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Yodo1AntiAddiction alloc] init];
    });
    return sharedInstance;
}

- (void)init:(NSString *)appKey delegate:(id<Yodo1AntiAddictionDelegate>)delegate {
    [self init:appKey channel:Yodo1AntiAddictionChannel regionCode:@"" delegate:delegate];
}

- (void)init:(NSString *)appKey regionCode:(NSString *)regionCode delegate: (id<Yodo1AntiAddictionDelegate>)delegate {
    [self init:appKey channel:Yodo1AntiAddictionChannel regionCode:regionCode delegate:delegate];
}

- (void)init:(NSString *)appKey channel:(NSString *)channel regionCode:(NSString *)regionCode delegate:(id<Yodo1AntiAddictionDelegate>)delegate {
    [[Yodo1AntiAddictionHelper shared] init:appKey channel:channel regionCode:regionCode delegate:delegate];
}

- (void)startTimer {
    [[Yodo1AntiAddictionHelper shared] startTimer];
}

- (void)stopTimer {
    [[Yodo1AntiAddictionHelper shared] stopTimer];
}

- (BOOL)isTimer {
    return [[Yodo1AntiAddictionHelper shared] isTimer];
}

- (BOOL)isGuestUser {
    return [[Yodo1AntiAddictionHelper shared] isGuestUser];
}

- (void)verifyCertificationInfo:(NSString *)accountId success:(Yodo1AntiAddictionSuccessful)success failure:(Yodo1AntiAddictionFailure)failure {
    [[Yodo1AntiAddictionHelper shared] verifyCertificationInfo:accountId success:success failure:failure];
}

///是否已限制消费
- (void)verifyPurchase:(NSInteger)money success:(Yodo1AntiAddictionSuccessful)success failure:(Yodo1AntiAddictionFailure)failure {
    [[Yodo1AntiAddictionHelper shared] verifyPurchase:money success:success failure:failure];
}

- (void)reportProductReceipt:(Yodo1AntiAddictionProductReceipt *)receipt success:(Yodo1AntiAddictionSuccessful)success failure:(Yodo1AntiAddictionFailure)failure {
    [[Yodo1AntiAddictionHelper shared] reportProductReceipts:@[receipt] success:success failure:failure];
}

- (void)online:(OnBehaviourResult)callback {
    if (!lockBehavior) {
        lockBehavior = YES;
        [Yodo1AntiAddictionHelper.shared online:^(BOOL result, NSString * _Nonnull content) {
            self->lockBehavior = NO;
            if (result) {
                Yodo1AntiAddictionHelper.shared.enterGameFlag = YES;
                callback(result,@"");
            } else {
                callback(result,@"网络连接已断开，请稍候重试");
            }
        }];
    }
}

- (void)offline:(OnBehaviourResult)callback {
    if (!lockBehavior) {
        lockBehavior = YES;
        __weak typeof(self) weakSelf = self;
        [Yodo1AntiAddictionHelper.shared offline:^(BOOL result, NSString * _Nonnull content) {
            self->lockBehavior = NO;
            if (result) {
                Yodo1AntiAddictionHelper.shared.enterGameFlag = NO;
                [weakSelf stopTimer];//停止计时
                callback(YES,@"");
            } else {
                callback(NO,@"网络连接已断开，请稍候重试");
            }
        }];
    }
}

@end

