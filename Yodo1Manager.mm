//
//  Yodo1Manager.m
//  localization_sdk_sample
//
//  Created by shon wang on 13-8-13.
//  Copyright (c) 2013年 游道易. All rights reserved.
//

#import "Yodo1Manager.h"
#import "Yodo1Commons.h"
#import "Yodo1KeyInfo.h"
#import "Yodo1UnityTool.h"
#import "Yd1OnlineParameter.h"
#import "Yodo1Tool+Storage.h"
#import <Bugly/Bugly.h>

#import "Yodo1Ads.h"

#ifdef YODO1_ANALYTICS
#import "Yodo1AnalyticsManager.h"
#endif

#ifdef YODO1_SNS
#import "SNSManager.h"
#endif

#ifdef YODO1_MORE_GAME
#import "MoreGameManager.h"
#endif

#ifdef YODO1_UCCENTER
#import "Yd1UCenterManager.h"
#endif

#ifdef YODO1_SOOMLA
#import "IronSourceAdQuality.h"
#endif

#ifdef ANTI_ADDICTION
#import "Yodo1RealNameManager.h"
#endif

#import "Yodo1Model.h"

NSString* const kFacebookAppId      = @"FacebookAppId";
NSString* const kYodo1ChannelId     = @"AppStore";

NSString* const kSoomlaAppKey       = @"SoomlaAppKey";

@implementation SDKConfig

@end

static SDKConfig* kYodo1Config = nil;
static BOOL isInitialized = false;
static NSString* __kAppKey = @"";

@interface Yodo1Manager ()

@end

@implementation Yodo1Manager

+ (void)initSDKWithConfig:(SDKConfig*)sdkConfig {
    
    NSAssert(sdkConfig.appKey != nil, @"appKey is not set!");
    if (isInitialized) {
        NSLog(@"[Yodo1 SDK] has already been initialized!");
        return;
    }
    __kAppKey = sdkConfig.appKey;
    isInitialized = true;
    
#ifndef YODO1_ADS
    [Yd1OnlineParameter.shared initWithAppKey:__kAppKey channelId:@"AppStore"];
#endif
    
#ifdef YODO1_SOOMLA
    NSString *adQualityAppKey = [[Yodo1KeyInfo shareInstance]configInfoForKey:kSoomlaAppKey];
    ISAdQualityConfig *adQualityConfig = [ISAdQualityConfig config];
    adQualityConfig.userId = Yodo1Tool.shared.keychainDeviceId;
#ifdef DEBUG
    adQualityConfig.logLevel = IS_AD_QUALITY_LOG_LEVEL_INFO;
#endif
    [[IronSourceAdQuality getInstance] initializeWithAppKey:adQualityAppKey
                                                  andConfig:adQualityConfig];
#endif
    
    kYodo1Config = sdkConfig;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onlineParameterPaNotifi:)
                                                 name:kYodo1OnlineConfigFinishedNotification
                                               object:nil];

#ifdef YODO1_SNS
    //初始化sns
    NSMutableDictionary* snsPlugn = [NSMutableDictionary dictionary];
    NSString* qqAppId = [[Yodo1KeyInfo shareInstance]configInfoForKey:kYodo1QQAppId];
    NSString* qqUniversalLink = [[Yodo1KeyInfo shareInstance]configInfoForKey:kYodo1QQUniversalLink];
    NSString* wechatAppId = [[Yodo1KeyInfo shareInstance]configInfoForKey:kYodo1WechatAppId];
    NSString* wechatUniversalLink = [[Yodo1KeyInfo shareInstance]configInfoForKey:kYodo1WechatUniversalLink];
    NSString* sinaAppKey = [[Yodo1KeyInfo shareInstance]configInfoForKey:kYodo1SinaWeiboAppKey];
    NSString* sinaUniversalLink = [[Yodo1KeyInfo shareInstance]configInfoForKey:kYodo1SinaWeiboUniversalLink];
    NSString* twitterConsumerKey = [[Yodo1KeyInfo shareInstance]configInfoForKey:kYodo1TwitterConsumerKey];
    NSString* twitterConsumerSecret = [[Yodo1KeyInfo shareInstance]configInfoForKey:kYodo1TwitterConsumerSecret];
    if (qqAppId) {
        [snsPlugn setObject:qqAppId forKey:kYodo1QQAppId];
    }
    if (qqUniversalLink) {
        [snsPlugn setObject:qqUniversalLink forKey:kYodo1QQUniversalLink];
    }
    if (wechatAppId) {
        [snsPlugn setObject:wechatAppId forKey:kYodo1WechatAppId];
    }
    if (wechatUniversalLink) {
        [snsPlugn setObject:wechatUniversalLink forKey:kYodo1WechatUniversalLink];
    }
    if (sinaAppKey) {
        [snsPlugn setObject:sinaAppKey forKey:kYodo1SinaWeiboAppKey];
    }
    if (sinaUniversalLink) {
        [snsPlugn setObject:sinaAppKey forKey:kYodo1SinaWeiboUniversalLink];
    }
    if (twitterConsumerKey && twitterConsumerSecret) {
        [snsPlugn setObject:twitterConsumerKey forKey:kYodo1TwitterConsumerKey];
        [snsPlugn setObject:twitterConsumerSecret forKey:kYodo1TwitterConsumerSecret];
    }
    [[SNSManager sharedInstance] initSNSPlugn:snsPlugn];
    
#endif
    
}

+ (NSDictionary*)config {
    NSBundle *bundle = [[NSBundle alloc] initWithPath:[[NSBundle mainBundle]
                                                       pathForResource:@"Yodo1Ads"
                                                       ofType:@"bundle"]];
    if (bundle) {
        NSString *configPath = [bundle pathForResource:@"config" ofType:@"plist"];
        if (configPath) {
            NSDictionary *config =[NSDictionary dictionaryWithContentsOfFile:configPath];
            return config;
        }
    }
    return nil;
}

+ (NSString*)publishType {
    NSDictionary* _config = [Yodo1Manager config];
    NSString* _publishType = @"";
    if (_config && [[_config allKeys]containsObject:@"PublishType"]) {
        _publishType = (NSString*)[_config objectForKey:@"PublishType"];
    }
    return _publishType;
}
    
+ (NSString*)publishVersion {
    NSDictionary* _config = [Yodo1Manager config];
    NSString* _publishVersion = @"";
    if (_config && [[_config allKeys]containsObject:@"PublishVersion"]) {
        _publishVersion = (NSString*)[_config objectForKey:@"PublishVersion"];
    }
    return _publishVersion;
}


+ (void)onlineParameterPaNotifi:(NSNotification *)notif {
    
    [self performSelector:@selector(analyticInit) withObject:self afterDelay:1.0f];

#ifdef ANTI_ADDICTION
    [Yodo1RealNameManager.shared realNameConfig];
#endif
    
#ifndef YODO1_ADS
    NSString* buglyAppId = [Yd1OnlineParameter.shared stringConfigWithKey:@"BuglyAnalytic_AppId" defaultValue:@""];
    if (buglyAppId.length > 0 && [Yodo1Ads isUserConsent] && ![Yodo1Ads isTagForUnderAgeOfConsent]) {
        BuglyConfig* buglyConfig = [[BuglyConfig alloc]init];
#ifdef DEBUG
        buglyConfig.debugMode = YES;
#endif
        buglyConfig.channel = @"appstore";
        
        [Bugly startWithAppId:buglyAppId config:buglyConfig];
        
        NSString* sdkInfo = [NSString stringWithFormat:@"%@,%@",[Yodo1Manager publishType],[Yodo1Manager publishVersion]];
        
        [Bugly setUserIdentifier:Bugly.buglyDeviceId];
        [Bugly setUserValue:@"appstore" forKey:@"ChannelCode"];
        [Bugly setUserValue:__kAppKey forKey:@"GameKey"];
        [Bugly setUserValue:[Yodo1Commons idfaString] forKey:@"DeviceID"];
        [Bugly setUserValue:sdkInfo forKey:@"SdkInfo"];
        [Bugly setUserValue:[Yodo1Commons idfaString] forKey:@"IDFA"];
        [Bugly setUserValue:[Yodo1Commons idfvString] forKey:@"IDFV"];
        [Bugly setUserValue:[Yodo1Commons territory] forKey:@"CountryCode"];
    }
#endif
}

- (void)analyticInit
{
#ifdef YODO1_ANALYTICS
    AnalyticsInitConfig * config = [[AnalyticsInitConfig alloc]init];
    config.gaCustomDimensions01 = kYodo1Config.gaCustomDimensions01;
    config.gaCustomDimensions02 = kYodo1Config.gaCustomDimensions02;
    config.gaCustomDimensions03 = kYodo1Config.gaCustomDimensions03;
    config.gaResourceCurrencies = kYodo1Config.gaResourceCurrencies;
    config.gaResourceItemTypes = kYodo1Config.gaResourceItemTypes;
    config.appsflyerCustomUserId = kYodo1Config.appsflyerCustomUserId;
    [[Yodo1AnalyticsManager sharedInstance]initializeAnalyticsWithConfig:config];
#endif
}

- (void)dealloc {
#ifdef YODO1_ANALYTICS
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:kYodo1OnlineConfigFinishedNotification
                                                 object:nil];
    kYodo1Config = nil;
#endif
}

+ (void)handleOpenURL:(NSURL*)url sourceApplication:(NSString*)sourceApplication {
#ifdef YODO1_SNS
    if ([SNSManager sharedInstance].isYodo1Shared) {
        [[SNSManager sharedInstance] application:nil openURL:url options:nil];
    }
#endif

}


#ifdef __cplusplus

extern "C" {

    void UnityInitSDKWithConfig(const char* sdkConfigJson) {
        NSString* _sdkConfigJson = Yodo1CreateNSString(sdkConfigJson);
        SDKConfig* yySDKConfig = [SDKConfig yodo1_modelWithJSON:_sdkConfigJson];
        [Yodo1Manager initSDKWithConfig:yySDKConfig];
        
    }

    char* UnityStringParams(const char* key,const char* defaultValue) {
        NSString* _defaultValue = Yodo1CreateNSString(defaultValue);
         NSString* _key = Yodo1CreateNSString(key);
        NSString* param = [Yd1OnlineParameter.shared stringConfigWithKey:_key defaultValue:_defaultValue];
        return Yodo1MakeStringCopy([param cStringUsingEncoding:NSUTF8StringEncoding]);
    }
    
    bool UnityBoolParams(const char* key,bool defaultValue) {
        bool param = [Yd1OnlineParameter.shared boolConfigWithKey:Yodo1CreateNSString(key) defaultValue:defaultValue];
        return param;
    }
    
    bool UnitySwitchMoreGame() {
    #ifdef YODO1_MORE_GAME
        return [[MoreGameManager sharedInstance]switchYodo1GMG];
    #else
        return NO;
    #endif
    }
    
    void UnityShowMoreGame() {
    #ifdef YODO1_MORE_GAME
        [[MoreGameManager sharedInstance] present];
    #endif
    }

    char* UnityGetDeviceId() {
        const char* deviceId = Yd1OpsTools.keychainDeviceId.UTF8String;
        return Yodo1MakeStringCopy(deviceId);
    }

    char* UnityUserId(){
        const char* userId = Yd1OpsTools.keychainUUID.UTF8String;
        return Yodo1MakeStringCopy(userId);
    }
}

#endif

@end
