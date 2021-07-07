//
//  Yodo1AntiAddictionBehaviour.h
//  yodo1-anti-Addiction-ios
//
//  Created by ZhouYuzhen on 2020/10/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define BEHAVIOUR_TABLE  NSStringFromClass([Yodo1AntiAddictionBehaviour class])

@interface Yodo1AntiAddictionBehaviour : NSObject

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *yid;
@property (nonatomic, copy) NSString *sessionId;
@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, assign) NSTimeInterval happenTimestamp;
@property (nonatomic, assign) NSInteger behaviorType;//1:上线 ，0:下线
@property (nonatomic, assign) NSInteger userType;

+ (NSString *)createSql;

@end

NS_ASSUME_NONNULL_END
