//
//  AnalyticsAdapterThinking.m
//
//  Created by hyx on 14-10-14.
//  Copyright (c) 2014年 yodo1. All rights reserved.
//

#import "AnalyticsAdapterThinking.h"
#import "ThinkingAnalyticsSDK.h"
#import "Yodo1AnalyticsManager.h"
#import "Yodo1Registry.h"
#import "Yodo1Commons.h"
#import "Yodo1KeyInfo.h"
#import "Yd1OnlineParameter.h"
#import "Yodo1Tool+Commons.h"

NSString* const YODO1_ANALYTICS_TA_APPKEY       = @"ThinkingAppId";
NSString* const YODO1_ANALYTICS_TA_SERVERURL    = @"ThinkingServerUrl";

@implementation AnalyticsAdapterThinking
{
    double _currencyAmount;//现金金额
    double _virtualCurrencyAmount;//虚拟币金额
    NSString* _iapId;//物品id
}

+ (AnalyticsType)analyticsType
{
    return AnalyticsTypeThinking;
}

+ (void)load
{
    [[Yodo1Registry sharedRegistry] registerClass:self withRegistryType:@"analyticsType"];
}

- (id)initWithAnalytics:(AnalyticsInitConfig *)initConfig
{
    self = [super init];
    if (self) {
        NSLog(@"[ Yodo1 ]: Thinking is init!");
#ifdef DEBUG
        [ThinkingAnalyticsSDK setLogLevel:TDLoggingLevelDebug];
#endif
    }
    return self;
}

- (void)eventWithAnalyticsEventName:(NSString *)eventName
                          eventData:(NSDictionary *)eventData
{
    if (eventData) {
        [ThinkingAnalyticsSDK.sharedInstance track:eventName properties:eventData];
    }
}

#pragma mark- DplusMobClick

- (void)track:(NSString *)eventName
{
    [ThinkingAnalyticsSDK.sharedInstance track:eventName];
}

- (void)track:(NSString *)eventName property:(NSDictionary *) property
{
    [ThinkingAnalyticsSDK.sharedInstance track:eventName properties:property];
}

- (void)registerSuperProperty:(NSDictionary *)property
{
    [ThinkingAnalyticsSDK.sharedInstance setSuperProperties:property];
}

- (void)unregisterSuperProperty:(NSString *)propertyName
{
    [ThinkingAnalyticsSDK.sharedInstance unsetSuperProperty:propertyName];
}

- (NSString *)getSuperProperty:(NSString *)propertyName
{
    return @"";
}

- (NSDictionary *)getSuperProperties
{
    return [ThinkingAnalyticsSDK.sharedInstance currentSuperProperties];
}

- (void)clearSuperProperties
{
    [ThinkingAnalyticsSDK.sharedInstance clearSuperProperties];
    
}

- (void)dealloc
{
    
}

@end
