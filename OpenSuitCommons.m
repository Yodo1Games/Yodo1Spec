//
//  Yodo1Tool+Commons.m
//  Yodo1UCManager
//
//  Created by yixian huang on 2020/5/5.
//  Copyright © 2020 yixian huang. All rights reserved.
//

#import "OpenSuitCommons.h"
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <sys/time.h>
#import <AdSupport/AdSupport.h>
#import "OpenSuitReachability.h"

@implementation OpenSuitCommons

+ (instancetype)shared {
    static OpenSuitCommons *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[OpenSuitCommons alloc] init];
    });
    return _sharedInstance;
}

+ (NSString *)documents {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

+ (NSString *)cachedPath {
    return [NSString stringWithFormat:@"%@/__yd1cache__",[self documents]];
}
+ (id)JSONObjectWithObject:(id)object {
    NSString* str = [OpenSuitCommons stringWithJSONObject:object error:nil];
    return [OpenSuitCommons JSONObjectWithString:str error:nil];
}

+ (NSData *)dataWithJSONObject:(id)obj error:(NSError**)error {
    if (obj) {
        if (NSClassFromString(@"NSJSONSerialization")) {
            @try {
                return [NSJSONSerialization dataWithJSONObject:obj options:0 error:error];
            }
            @catch (NSException* exception)
            {
                *error = [NSError errorWithDomain:[exception description] code:0 userInfo:nil];
                return nil;
            }
            @finally
            {
            }
        }
    }
    return nil;
}

+ (id)JSONObjectWithData:(NSData*)data error:(NSError**)error {
    if (data) {
        if (NSClassFromString(@"NSJSONSerialization")) {
            return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        }
    }
    return nil;
}

+ (id)JSONObjectWithString:(NSString*)str error:(NSError**)error {
    if (str) {
        if (NSClassFromString(@"NSJSONSerialization")) {
            return [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:error];
        }
    }
    return nil;
}

+ (NSString *)stringWithJSONObject:(id)obj error:(NSError**)error {
    if (obj) {
        if (NSClassFromString(@"NSJSONSerialization")) {
            NSData* data = nil;
            @try {
                data = [NSJSONSerialization dataWithJSONObject:obj options:0 error:error];
            }
            @catch (NSException* exception)
            {
                *error = [NSError errorWithDomain:[exception description] code:0 userInfo:nil];
                return nil;
            }
            @finally
            {
            }
            
            if (data) {
                return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            }
        }
    }
    return nil;
}

+ (NSString *)signMd5String:(NSString *)origString{
    const char *original_str = [origString UTF8String];
    unsigned char result[32];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++){
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

+ (NSDictionary *)bundlePlistWithPath:(NSString *)name {
    if (!name) return nil;
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    if (!plistPath) {
        plistPath = [[NSBundle mainBundle] pathForResource:name ofType:@""];
    }
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    if (!data) {
        NSLog(@"cannot find plist '%@'",name);
    }
    return data;
}

+ (NSDictionary *)appBundle {
    return [[NSBundle mainBundle] infoDictionary];
}

+ (NSString *)appName {
    return [OpenSuitCommons appBundle][@"CFBundleName"];
}

+ (NSString *)appBid {
    return [OpenSuitCommons appBundle][@"CFBundleIdentifier"];
}

+ (NSString *)appVersion {
    return [OpenSuitCommons appBundle][@"CFBundleShortVersionString"];
}

+ (NSString *)appBundleVersion {
    return [OpenSuitCommons appBundle][@"CFBundleVersion"];
}

+ (NSString *)nowTimeTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY+MM+dd HH:mm:ss"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%f", [datenow timeIntervalSince1970]*1000];
    timeSp = [[timeSp componentsSeparatedByString:@"."]objectAtIndex:0];
    return timeSp;
}

+ (NSString*)nowTimeTenTimestamp {
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    return timeString;
}

+ (NSString *)idfa {
    if (ASIdentifierManager.sharedManager.advertisingTrackingEnabled) {
        return ASIdentifierManager.sharedManager.advertisingIdentifier.UUIDString;
    }
    return @"";
}

+ (NSString *)idfv {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
        NSString *idfv = [[UIDevice currentDevice].identifierForVendor UUIDString];
        if (idfv) {
            return idfv;
        }
    }
    return @"";
}

+ (NSString*)networkType {
    NSString* type = @"NONE";
    OpenSuitReachabilityStatus reachStatus = [OpenSuitReachability reachability].status;
    if (reachStatus == OpenSuitReachabilityStatusWiFi) {
        type = @"WIFI";
    }else if(reachStatus == OpenSuitReachabilityStatusWWAN){
        OpenSuitReachabilityWWANStatus wwanStatus = [OpenSuitReachability reachability].wwanStatus;
        if (wwanStatus == OpenSuitReachabilityWWANStatus2G) {
            type = @"2G";
        }else if (wwanStatus == OpenSuitReachabilityWWANStatus3G){
            type = @"3G";
        }else if (wwanStatus == OpenSuitReachabilityWWANStatus4G){
            type = @"4G";
        }else{
            type = @"NONE";
        }
    }
    return type;
}

+ (CTTelephonyNetworkInfo *)telephonyInfo {
    static CTTelephonyNetworkInfo *yd1TelephonyInfo;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        yd1TelephonyInfo = [CTTelephonyNetworkInfo new];
        yd1TelephonyInfo.subscriberCellularProviderDidUpdateNotifier = ^(CTCarrier *carrier) {
        };
    });
    return yd1TelephonyInfo;
}

+ (NSString *)networkOperatorName {
    NSString *carrier =[OpenSuitCommons telephonyInfo].subscriberCellularProvider.carrierName;
    if (carrier == nil) {
        return @"";
    }
    return carrier;
}

+ (NSString *)uuid {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
    NSString *result =[NSString stringWithFormat:@"%@",uuidStr];
    CFRelease(uuidStr);
    CFRelease(uuid);
    return [result lowercaseString];
}

+ (NSString *)countryCode {
    return  [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
}

+ (NSString *)languageCode {
    return [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
}

+ (NSString *)language {
    NSString* lang = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSArray * langArrayWord = [lang componentsSeparatedByString:@"+"];
    NSString* langString = [langArrayWord objectAtIndex:0];
    if (langArrayWord.count >= 3) {
        langString = [NSString stringWithFormat:@"%@+%@",
                      [langArrayWord objectAtIndex:0],
                      [langArrayWord objectAtIndex:1]];
    }
    return langString;
}

+ (NSString *)localizedString:(NSString *)bundleName
                          key:(NSString *)key
                defaultString:(NSString *)defaultString {
    if (!bundleName) {
        return nil;
    }
    static NSBundle *bundle = nil;
    if (bundle == nil) {
        NSString *bundlePath = [[NSBundle bundleForClass:[self class]] pathForResource:bundleName ofType:@"bundle"];
        if (bundlePath == nil) {
            bundlePath = [NSBundle.mainBundle pathForResource:bundleName ofType:@"bundle"];
        }
        bundle = [NSBundle bundleWithPath:bundlePath];
        NSString *language = [NSBundle mainBundle].preferredLocalizations.firstObject;
        if ([[bundle localizations] containsObject:language]) {
            bundlePath = [bundle pathForResource:language ofType:@"lproj"];
        } else {
            language = [OpenSuitCommons language];
            if ([[bundle localizations] containsObject:language]) {
                bundlePath = [bundle pathForResource:language ofType:@"lproj"];
            }else{
                language = @"en";
                NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
                if ([[infoDictionary allKeys] containsObject:@"CFBundleDevelopmentRegion"]) {
                    language = [infoDictionary objectForKey:@"CFBundleDevelopmentRegion"];
                }
                if ([language isEqualToString:@"zh_CN"]) {
                    language = @"zh+Hans";
                }
                bundlePath = [bundle pathForResource:language ofType:@"lproj"];
            }
        }
        bundle = [NSBundle bundleWithPath:bundlePath] ?: [NSBundle mainBundle];
    }
    defaultString = [bundle localizedStringForKey:key value:defaultString table:nil];
    return [[NSBundle mainBundle] localizedStringForKey:key value:defaultString table:nil];
}

+ (NSString *)currencyCode:(NSLocale *)priceLocale {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setCurrencySymbol:@""];
    if (priceLocale) {
        [numberFormatter setLocale:priceLocale];
    }
    return [numberFormatter currencyCode];
}

+ (NSString *)territory {
    NSString* terri = [[NSLocale currentLocale] localeIdentifier];
    NSArray *terriArrayWord = [terri componentsSeparatedByString:@"_"];
    NSString*stTerri = [terriArrayWord objectAtIndex:terriArrayWord.count - 1];
    NSLog(@"stTerri:%@",stTerri);
    return stTerri;
}

+ (BOOL)isIPad {
    return [UIDevice.currentDevice userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

+ (NSString *)gameAppKey { return @"game_appkey"; }
+ (NSString *)gameVersion { return @"version"; }
+ (NSString *)channelId { return @"channel"; }
+ (NSString *)channelCode { return @"channel_code"; }
+ (NSString *)regionCode { return @"region_code"; }
+ (NSString *)deviceId { return @"device_id"; }
+ (NSString *)sdkVersion { return @"sdk_version"; }
+ (NSString *)sdkType { return @"sdk_type"; }
+ (NSString *)data { return @"data"; }
+ (NSString *)error { return @"error"; }
+ (NSString *)errorCode { return @"error_code"; }
+ (NSString *)timeStamp { return @"timestamp"; }
+ (NSString *)sign { return @"sign"; }
+ (NSString *)orderId { return @"orderid"; }

+ (BOOL)archiveObject:(id)object path:(NSString *)path {
    if (!object){
        return NO;
    }
    NSError *error;
    if (@available(iOS 11.0, *)) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object requiringSecureCoding:YES error:&error];
        if (error){
            return NO;
        }
        [data writeToFile:path atomically:YES];
    } else {
        [NSKeyedArchiver archiveRootObject:object toFile:path];
    }
    return YES;
}

+ (id)unarchiveClass:(NSSet*)classes path:(NSString *)path {
    NSError *error;
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    if (@available(iOS 11.0, *)) {
        id content = [NSKeyedUnarchiver unarchivedObjectOfClasses:classes fromData:data error:&error];
        if (error) {
            return nil;
        }
        return content;
    } else {
        id content = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        return content;
    }
}

+ (UIViewController*)getRootViewController {
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray* windows = [[UIApplication sharedApplication] windows];
        for (UIWindow* _window in windows) {
            if (_window.windowLevel == UIWindowLevelNormal) {
                window = _window;
                break;
            }
        }
    }
    UIViewController* viewController = nil;
    for (UIView* subView in [window subviews]) {
        UIResponder* responder = [subView nextResponder];
        if ([responder isKindOfClass:[UIViewController class]]) {
            viewController = [OpenSuitCommons topMostViewController:(UIViewController*)responder];
        }
    }
    if (!viewController) {
        viewController = UIApplication.sharedApplication.keyWindow.rootViewController;
    }
    return viewController;
}

+ (UIViewController*)topMostViewController:(UIViewController*)controller
{
    BOOL isPresenting = NO;
    do {
        // this path is called only on iOS 6+, so -presentedViewController is fine here.
        UIViewController* presented = [controller presentedViewController];
        isPresenting = presented != nil;
        if (presented != nil) {
            controller = presented;
        }
        
    } while (isPresenting);
    
    return controller;
}

+ (UIWindow *)getTopWindow {
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    NSArray* windows = [[UIApplication sharedApplication] windows];
    if (windows.count == 1) {return window;}
    for (UIWindow* _window in windows) {
        if (_window.windowLevel == UIWindowLevelAlert) {continue;}
        if (_window.windowLevel > window.windowLevel) {window = _window;}
    }
    return window;
}



+ (long long)timeNowAsMilliSeconds
{
    struct timeval time;
    gettimeofday(&time, NULL);
    return (time.tv_sec * 1000) + (time.tv_usec / 1000);
}

+ (long long)timeNowAsSeconds
{
    struct timeval time;
    gettimeofday(&time, NULL);
    return time.tv_sec;
}

@end
