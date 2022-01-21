//
//  Yodo1Tool+Commons.h
//  Yodo1UCManager
//
//  Created by yixian huang on 2020/5/5.
//  Copyright © 2020 yixian huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#if DEBUG
#define OpenSuitLog(...) NSLog(@"[ OpenSuit ]: %@", [NSString stringWithFormat:__VA_ARGS__]);
#else
#define OpenSuitLog(...)
#endif

NS_ASSUME_NONNULL_BEGIN

@class CTTelephonyNetworkInfo;

@interface OpenSuitCommons: NSObject

@property (nonatomic, copy) NSString *requestURL;

+ (instancetype)shared;

+ (NSString *)documents;
+ (NSString *)cachedPath;
+ (id)JSONObjectWithObject:(id)object;
+ (NSData *)dataWithJSONObject:(id)obj error:(NSError**)error;
+ (id)JSONObjectWithData:(NSData*)data error:(NSError**)error;
+ (id)JSONObjectWithString:(NSString*)str error:(NSError**)error;
+ (NSString *)stringWithJSONObject:(id)obj error:(NSError**)error;
+ (NSString *)signMd5String:(NSString *)origString;
+ (NSDictionary *)bundlePlistWithPath:(NSString *)name;
+ (NSString *)appName;
+ (NSString *)appBid;
+ (NSString *)appVersion;
+ (NSString *)appBundleVersion;
+ (NSDictionary *)appBundle;
///十三位数时间戳
+ (NSString *)nowTimeTimestamp;
///十位数时间戳
+ (NSString *)nowTimeTenTimestamp;
+ (NSString *)idfa;
+ (NSString *)idfv;
+ (NSString *)networkType;
+ (CTTelephonyNetworkInfo *)telephonyInfo;
+ (NSString *)networkOperatorName;
+ (NSString *)uuid;
+ (NSString *)countryCode;
+ (NSString *)languageCode;
+ (NSString *)language;
+ (NSString *)localizedString:(NSString *)bundleName
                          key:(NSString *)key
                defaultString:(NSString *)defaultString;
+ (NSString *)currencyCode:(NSLocale *)priceLocale;
+ (NSString *)territory;
+ (BOOL)isIPad;
+ (NSString *)gameAppKey;
+ (NSString *)gameVersion;
+ (NSString *)channelId;
+ (NSString *)channelCode;
+ (NSString *)regionCode;
+ (NSString *)deviceId;
+ (NSString *)sdkVersion;
+ (NSString *)sdkType;
+ (NSString *)data;
+ (NSString *)error;
+ (NSString *)errorCode;
+ (NSString *)timeStamp;
+ (NSString *)sign;
+ (NSString *)orderId;

+ (BOOL)archiveObject:(id)object path:(NSString *)path;
+ (id)unarchiveClass:(NSSet*)classes path:(NSString *)path;

/// 获取RootViewController
+ (UIViewController*)getRootViewController;

/// 获取传入UIViewController的上一级的UIViewController
/// @param controller UIViewController
+ (UIViewController*)topMostViewController:(UIViewController*)controller;

+ (UIWindow *)getTopWindow;

+ (long long)timeNowAsMilliSeconds;

+ (long long)timeNowAsSeconds;

@end

NS_ASSUME_NONNULL_END
