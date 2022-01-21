//
//  Yodo1Tool+Storage.h
//  Yodo1UCManager
//
//  Created by yixian huang on 2020/5/5.
//  Copyright © 2020 yixian huang. All rights reserved.
//

#import "Yodo1YYCache.h"
#import "OpenSuitCommons.h"

NS_ASSUME_NONNULL_BEGIN

@interface OpenSuitCommons(Cache)

/// cache
+ (Yodo1YYCache*)cached;

/// keychain save string
/// @param service service
/// @param str string
+ (void)saveKeychainWithService:(NSString *)service str:(NSString *)str;

/// keychain service
/// @param service service
+ (NSString *)keychainWithService:(NSString *)service;

/// keychain UUID
+ (NSString *)keychainUUID;

/// keychain of device id
+ (NSString *)keychainDeviceId;

@end

NS_ASSUME_NONNULL_END
