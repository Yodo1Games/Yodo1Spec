//
//  Yodo1AntiAddictionBehaviour.m
//  yodo1-anti-Addiction-ios
//
//  Created by ZhouYuzhen on 2020/10/3.
//

#import "Yodo1AntiAddictionBehaviour.h"

@implementation Yodo1AntiAddictionBehaviour

+ (NSString *)createSql {
    NSMutableString *createSql = [[NSMutableString alloc]init];
    [createSql appendString:@" CREATE TABLE IF NOT EXISTS "];
    [createSql appendString:BEHAVIOUR_TABLE];
    [createSql appendString:@" ( "];
    
    [createSql appendFormat:@" %@ VARCHAR, ", @"uid"];
    [createSql appendFormat:@" %@ VARCHAR, ", @"yid"];
    [createSql appendFormat:@" %@ VARCHAR, ", @"sessionId"];
    [createSql appendFormat:@" %@ VARCHAR, ", @"deviceId"];
    [createSql appendFormat:@" %@ VARCHAR, ", @"happenTimestamp"];
    [createSql appendFormat:@" %@ INTEGER, ", @"behaviorType"];
    [createSql appendFormat:@" %@ INTEGER ", @"userType"];
    
    [createSql appendFormat:@" ); "];
    
    return createSql;
}

- (BOOL)isEqual:(id)object {
    BOOL isEqual = [super isEqual:object];
    if (!isEqual && [object isKindOfClass:[Yodo1AntiAddictionBehaviour class]]) {
        Yodo1AntiAddictionBehaviour *user = object;
        if (self.sessionId && user.sessionId) {
            isEqual = [self.sessionId isEqualToString:user.sessionId];
        }
    }
    return isEqual;
}

@end
