//
//  OpenSuitPayment.m
//  OpenSuitPayment
//
//  Created by yixian huang on 2017/7/24.
//

#import "OpenSuitPayment.h"
#import "OpenSuitCommons+PayParameters.h"
#import "OpenSuitCommons+Cache.h"
#import "OpenSuitCommons+Network.h"

#import "OpenSuitPayManager.h"
#import "Yodo1Model.h"

@implementation PayUser

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        _playerid = [decoder decodeObjectForKey:@"playerid"];
        _nickname = [decoder decodeObjectForKey:@"nickname"];
        _ucuid = [decoder decodeObjectForKey:@"ucuid"];
        _yid = [decoder decodeObjectForKey:@"yid"];
        _uid = [decoder decodeObjectForKey:@"uid"];
        _token = [decoder decodeObjectForKey:@"token"];
        _isOLRealName = [decoder decodeIntForKey:@"isOLRealName"];
        _isRealName = [decoder decodeIntForKey:@"isRealName"];
        _isnewuser = [decoder decodeIntForKey:@"isnewuser"];
        _isnewyaccount = [decoder decodeIntForKey:@"isnewyaccount"];
        _extra = [decoder decodeObjectForKey:@"extra"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    if (self.playerid) {
        [coder encodeObject:self.playerid forKey:@"playerid"];
    }
    if (self.nickname) {
        [coder encodeObject:self.nickname forKey:@"nickname"];
    }
    if (self.ucuid) {
        [coder encodeObject:self.ucuid forKey:@"ucuid"];
    }
    [coder encodeObject:self.yid forKey:@"yid"];
    [coder encodeObject:self.uid forKey:@"uid"];
    [coder encodeObject:self.token forKey:@"token"];
    [coder encodeInt:self.isOLRealName forKey:@"isOLRealName"];
    [coder encodeInt:self.isRealName forKey:@"isRealName"];
    [coder encodeInt:self.isnewuser forKey:@"isnewuser"];
    [coder encodeInt:self.isnewyaccount forKey:@"isnewyaccount"];
    if (self.extra) {
        [coder encodeObject:self.extra forKey:@"extra"];
    }
}

+ (BOOL)supportsSecureCoding {
    return YES;
}
@end

@implementation PayProductInfo
@end

@implementation PaySubscriptionInfo

- (id)initWithUniformProductId:(NSString*)m_uniformProductId
              channelProductId:(NSString*)m_channelProductId
                       expires:(NSTimeInterval)m_expiresTime
                  purchaseDate:(NSTimeInterval)m_purchaseDateMs {
    self = [super init];
    if (self) {
        self.uniformProductId = m_uniformProductId == nil ? @"ERROR_PRODUCT_NOT_FOUND":m_uniformProductId;
        self.channelProductId = m_channelProductId;
        self.expiresTime = m_expiresTime;
        self.purchase_date_ms = m_purchaseDateMs;
    }
    return self;
}
@end

@interface OpenSuitPayment () {
    
}

@end

@implementation OpenSuitPayment

+ (instancetype)shared {
    static OpenSuitPayment *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[OpenSuitPayment alloc] init];
        [_sharedInstance willInit];
    });
    return _sharedInstance;
}

- (void)willInit {
    if (_itemInfo == nil) {
        _itemInfo = [[PayProductInfo alloc]init];
        _itemInfo.deviceid = OpenSuitCommons.keychainDeviceId;
        _itemInfo.extra = @"";
        _itemInfo.is_sandbox = @"false";
        _itemInfo.statusCode = @"1";
        _itemInfo.statusMsg = @"";
        _itemInfo.exclude_old_transactions = @"false";
    }
}

- (NSString *)regionCode {
    if (_regionCode == nil) {
        _regionCode = @"";
    }
    return _regionCode;
}

- (NSString*)publishType {
    NSDictionary* _config = [OpenSuitCommons bundlePlistWithPath:@"Yodo1Ads.bundle/config"];
    NSString* _publishType = @"";
    if (_config && [[_config allKeys]containsObject:@"PublishType"]) {
        _publishType = (NSString*)[_config objectForKey:@"PublishType"];
    }
    return _publishType;
}

- (NSString*)publishVersion {
    NSDictionary* _config = [OpenSuitCommons bundlePlistWithPath:@"Yodo1Ads.bundle/config"];
    NSString* _publishVersion = @"";
    if (_config && [[_config allKeys]containsObject:@"PublishVersion"]) {
        _publishVersion = (NSString*)[_config objectForKey:@"PublishVersion"];
    }
    return _publishVersion;
}

- (void)deviceLoginWithPlayerId:(NSString *)playerId
                       callback:(void(^)(PayUser* _Nullable user, NSError* _Nullable  error))callback {
    NSString* deviceId = OpenSuitCommons.keychainDeviceId;
    if (playerId && [playerId length] > 0) {
        deviceId = playerId;
    }
    NSString* sign = [OpenSuitCommons signMd5String:[NSString stringWithFormat:@"yodo1.com%@%@",deviceId,OpenSuitPayManager.shared.payAppKey]];
    NSDictionary* data = @{
        OpenSuitCommons.gameAppKey:OpenSuitPayManager.shared.payAppKey ,OpenSuitCommons.channelCode:OpenSuitPayManager.shared.payChannelId,OpenSuitCommons.deviceId:deviceId,OpenSuitCommons.regionCode:self.regionCode };
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:data forKey:OpenSuitCommons.data];
    [parameters setObject:sign forKey:OpenSuitCommons.sign];
    OpenSuitLog(@"%@",[OpenSuitCommons stringWithJSONObject:parameters error:nil]);
    OpenSuitCommons.shared.requestURL = OpenSuitCommons.ucapDomain;
    
    [OpenSuitCommons.shared requestPost:OpenSuitCommons.deviceLoginURL
                                 params:parameters
                            contentType:@"text/plain; charset=utf-8"
                           successBlock:^(NSDictionary * _Nonnull responseObject) {
        NSDictionary* response = [OpenSuitCommons JSONObjectWithObject:responseObject];
        int errorCode = -1;
        NSString* error = @"";
        if ([[response allKeys]containsObject:OpenSuitCommons.errorCode]) {
            errorCode = [[response objectForKey:OpenSuitCommons.errorCode]intValue];
        }
        if ([[response allKeys]containsObject:OpenSuitCommons.error]) {
            error = [response objectForKey:OpenSuitCommons.error];
        }
        if ([[response allKeys]containsObject:OpenSuitCommons.data]) {
            NSDictionary* m_data = (NSDictionary*)[response objectForKey:OpenSuitCommons.data];
            PayUser* user = [PayUser yodo1_modelWithDictionary:m_data];
            if (callback) {
                callback(user,nil);
            }
        }else{
            if (callback) {
                callback(nil,[NSError errorWithDomain:@"com.yodo1.ucenter" code:errorCode userInfo:@{NSLocalizedDescriptionKey:error}]);
            }
        }
    } failBlock:^(NSError * _Nonnull error) {
        OpenSuitLog(@"%@",error.localizedDescription);
        if (callback) {
            callback(nil,error);
        }
    }];
}

- (void)generateOrderId:(void (^)(NSString * _Nullable, NSError * _Nullable))callback {
    
    OpenSuitCommons.shared.requestURL = OpenSuitCommons.paymentDomain;
    NSString* timestamp = OpenSuitCommons.nowTimeTimestamp;
    NSString* sign = [OpenSuitCommons signMd5String:[NSString stringWithFormat:@"payment%@",timestamp]];
    NSDictionary* data = @{
        OpenSuitCommons.timeStamp:timestamp
    };
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:data forKey:OpenSuitCommons.data];
    [parameters setObject:sign forKey:OpenSuitCommons.sign];
    
    OpenSuitLog(@"%@",[OpenSuitCommons stringWithJSONObject:parameters error:nil]);
    [OpenSuitCommons.shared requestPost:OpenSuitCommons.generateOrderIdURL
                                 params:parameters
                            contentType:@"text/plain; charset=utf-8"
                           successBlock:^(NSDictionary * _Nonnull responseObject) {
        NSDictionary* response = [OpenSuitCommons JSONObjectWithObject:responseObject];
        int errorCode = -1;
        NSString* error = @"";
        NSString* orderId = @"";
        if ([[response allKeys]containsObject:OpenSuitCommons.errorCode]) {
            errorCode = [[response objectForKey:OpenSuitCommons.errorCode]intValue];
        }
        if ([[response allKeys]containsObject:OpenSuitCommons.error]) {
            error = [response objectForKey:OpenSuitCommons.error];
        }
        if ([[response allKeys]containsObject:OpenSuitCommons.data]) {
            NSDictionary* m_data = (NSDictionary*)[response objectForKey:OpenSuitCommons.data];
            if ([[m_data allKeys]containsObject:@"orderId"]) {
                orderId = (NSString *)[m_data objectForKey:@"orderId"];
            }
            if (callback) {
                callback(orderId,nil);
            }
        }else{
            if (callback) {
                callback(nil,[NSError errorWithDomain:@"com.yodo1.ucenter" code:errorCode userInfo:@{NSLocalizedDescriptionKey:error}]);
            }
        }
    } failBlock:^(NSError * _Nonnull error) {
        OpenSuitLog(@"%@",error.localizedDescription);
        if (callback) {
            callback(nil,error);
        }
    }];
}

/**
 *  假如error_code:0 error值代表剩余可
 *  花费金额不为0，则是具体返回信息
 */
- (void)createOrder:(NSDictionary*) parameter
           callback:(void (^)(int, NSString * _Nonnull))callback {
    
    OpenSuitCommons.shared.requestURL = OpenSuitCommons.paymentDomain;
    NSString* orderId = [parameter objectForKey:@"orderId"];
    NSString* sign = [OpenSuitCommons signMd5String:[NSString stringWithFormat:@"payment%@",orderId]];
    
    NSDictionary* productInfo = [parameter objectForKey:@"product"];
    
    NSString* itemCode = [parameter objectForKey:@"itemCode"];
    NSString* orderMoney = [parameter objectForKey:@"orderMoney"];
    NSString* uid = [parameter objectForKey:@"uid"];
    NSString* yid = [parameter objectForKey:@"yid"];
    NSString* ucuid = [parameter objectForKey:@"ucuid"];
    NSString* playerId = [parameter objectForKey:@"playerId"];
    NSString* gameName = [parameter objectForKey:@"gameName"];
    NSString* gameType = [parameter objectForKey:@"gameType"];
    NSString* gameVersion = [parameter objectForKey:@"gameVersion"];
    NSString* gameExtra = [parameter objectForKey:@"gameExtra"];
    NSString* channelVersion = [parameter objectForKey:@"channelVersion"];
    
    NSString* extra = [parameter objectForKey:@"extra"];
    NSDictionary* extraDic = (NSDictionary *)[OpenSuitCommons JSONObjectWithString:extra error:nil];
    NSString* channelUserid = @"";
    if (extraDic && [[extraDic allKeys]containsObject:@"channelUserid"]) {
        channelUserid = [extraDic objectForKey:@"channelUserid"];
    }
    
    NSDictionary* deviceInfo = @{
        @"platform":UIDevice.currentDevice.systemName,
        @"originalSystemVersion":UIDevice.currentDevice.systemVersion,
        @"osVersion":UIDevice.currentDevice.systemVersion,
        @"deviceType":UIDevice.currentDevice.model,
        @"manufacturer":@"Apple",
        @"wifi":OpenSuitCommons.networkType,
        @"carrier":OpenSuitCommons.networkOperatorName,
    };
    NSDictionary* data = @{
        @"game_appkey":OpenSuitPayManager.shared.payAppKey,
        @"channel_code":OpenSuitPayManager.shared.payChannelId,
        @"region_code":self.regionCode,
        @"sdkType":[self publishType],
        @"sdkVersion":[self publishVersion],
        @"pr_channel_code":@"AppStore",
        @"orderid":orderId,
        @"item_code":itemCode,
        @"uid":uid,
        @"ucuid":ucuid,
        @"yid":yid,
        @"playerId":playerId,
        @"channel_version":channelVersion,
        @"order_money":orderMoney,
        @"gameName":gameName,
        @"game_version":gameVersion,
        @"game_type":gameType,
        @"game_extra":gameExtra,
        @"extra":extra,
        @"deviceid":OpenSuitCommons.keychainDeviceId,
        @"gameBundleId":OpenSuitCommons.appBid,
        @"paymentChannelVersion":[self publishVersion],
        @"deviceInfo":deviceInfo,
        @"productInfo":productInfo,
        @"channelUserid":channelUserid
    };
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:data forKey:OpenSuitCommons.data];
    [parameters setObject:sign forKey:OpenSuitCommons.sign];
    
    OpenSuitLog(@"%@",[OpenSuitCommons stringWithJSONObject:parameters error:nil]);
    [OpenSuitCommons.shared requestPost:OpenSuitCommons.createOrderURL
                                 params:parameters
                            contentType:@"text/plain; charset=utf-8"
                           successBlock:^(NSDictionary * _Nonnull responseObject) {
        NSDictionary* response = [OpenSuitCommons JSONObjectWithObject:responseObject];
        int errorCode = -1;
        NSString* error = @"";
        if ([[response allKeys]containsObject:OpenSuitCommons.errorCode]) {
            errorCode = [[response objectForKey:OpenSuitCommons.errorCode]intValue];
        }
        if ([[response allKeys]containsObject:OpenSuitCommons.error]) {
            error = [response objectForKey:OpenSuitCommons.error];
        }
        if (callback) {
            callback(errorCode,error);
        }
    } failBlock:^(NSError * _Nonnull error) {
        OpenSuitLog(@"%@",error.localizedDescription);
        if (callback) {
            callback((int)error.code,error.localizedDescription);
        }
    }];
}

- (NSError *)errorWithMsg:(NSString *)msg errorCode:(int)errorCode {
    return [NSError errorWithDomain:@"com.yodo1.payment"
                               code:errorCode
                           userInfo:@{NSLocalizedDescriptionKey:msg? :@""}];
}

- (void)verifyAppStoreIAPOrder:(PayProductInfo *)itemInfo callback:(nonnull void (^)(BOOL, NSString * _Nonnull, NSError * _Nonnull))callback {
    if (!itemInfo) {
        callback(false,@"",[self errorWithMsg:@"order Ids is empty!" errorCode:-1]);
        return;
    }
    OpenSuitCommons.shared.requestURL = OpenSuitCommons.paymentDomain;
    NSString* sign = [OpenSuitCommons signMd5String:[NSString stringWithFormat:@"payment%@",itemInfo.orderId]];
    NSDictionary* data = @{
        OpenSuitCommons.gameAppKey:OpenSuitPayManager.shared.payAppKey? :@"",
        OpenSuitCommons.channelCode:OpenSuitPayManager.shared.payChannelId? :@"",
        OpenSuitCommons.regionCode:self.regionCode? :@"",
        OpenSuitCommons.orderId:itemInfo.orderId? :@"",
        @"channelOrderid":itemInfo.channelOrderid? :@"",
        @"exclude_old_transactions":itemInfo.exclude_old_transactions? :@"false",
        @"product_type":[NSNumber numberWithInt:itemInfo.product_type],
        @"item_code":itemInfo.item_code? :@"",
        @"uid":itemInfo.uid? :@"",
        @"ucuid":itemInfo.ucuid? :@"",
        @"deviceid":itemInfo.deviceid? :@"",
        @"trx_receipt":itemInfo.trx_receipt? :@"",
        @"is_sandbox":itemInfo.is_sandbox? :@"",
        @"extra":itemInfo.extra? :@"",
    };
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:data forKey:OpenSuitCommons.data];
    [parameters setObject:sign forKey:OpenSuitCommons.sign];
    
    OpenSuitLog(@"%@",[OpenSuitCommons stringWithJSONObject:parameters error:nil]);
    
    [OpenSuitCommons.shared requestPost:OpenSuitCommons.verifyAppStoreIAPURL
                                 params:parameters
                            contentType:@"text/plain; charset=utf-8"
                           successBlock:^(NSDictionary * _Nonnull responseObject) {
        OpenSuitLog(@"%@",responseObject);
        NSDictionary* response = [OpenSuitCommons JSONObjectWithObject:responseObject];
        int errorCode = -1;
        NSString* error = @"";
        if ([[response allKeys]containsObject:OpenSuitCommons.errorCode]) {
            errorCode = [[response objectForKey:OpenSuitCommons.errorCode]intValue];
        }
        if ([[response allKeys]containsObject:OpenSuitCommons.error]) {
            error = [response objectForKey:OpenSuitCommons.error];
        }
        callback(errorCode == 0?true:false,[OpenSuitCommons stringWithJSONObject:response error:nil],[self errorWithMsg:error errorCode:errorCode]);
    } failBlock:^(NSError * _Nonnull error) {
        OpenSuitLog(@"%@",error);
        callback(false,@"",error);
    }];
}

- (void)querySubscriptions:(PayProductInfo *)itemInfo callback:(nonnull void (^)(BOOL, NSString * _Nullable, NSError * _Nullable))callback {
    OpenSuitCommons.shared.requestURL = OpenSuitCommons.paymentDomain;
    if (!itemInfo.trx_receipt) {
        NSError* error = [NSError errorWithDomain:@"com.yodo1.querySubscriptions"
                                             code:-1
                                         userInfo:@{NSLocalizedDescriptionKey:@"receipt is nil!"}];
        callback(false,itemInfo.orderId,error);
        return;
    }
    NSString* eightReceipt = [itemInfo.trx_receipt substringToIndex:8];
    NSString* sign = [OpenSuitCommons signMd5String:[NSString stringWithFormat:@"payment%@",eightReceipt]];
    NSDictionary* data = @{
        OpenSuitCommons.gameAppKey:OpenSuitPayManager.shared.payAppKey,
        OpenSuitCommons.channelCode:OpenSuitPayManager.shared.payChannelId,
        OpenSuitCommons.regionCode:self.regionCode,
        @"trx_receipt":itemInfo.trx_receipt,
        @"exclude_old_transactions":itemInfo.exclude_old_transactions
    };
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:data forKey:OpenSuitCommons.data];
    [parameters setObject:sign forKey:OpenSuitCommons.sign];
    
    OpenSuitLog(@"%@",[OpenSuitCommons stringWithJSONObject:parameters error:nil]);
    [OpenSuitCommons.shared requestPost:OpenSuitCommons.querySubscriptionsURL
                                 params:parameters
                            contentType:@"text/plain; charset=utf-8"
                           successBlock:^(NSDictionary * _Nonnull responseObject) {
        OpenSuitLog(@"%@",responseObject);
        NSDictionary* response = [OpenSuitCommons JSONObjectWithObject:responseObject];
        int errorCode = -1;
        NSString* errorMsg = @"";
        if ([[response allKeys]containsObject:OpenSuitCommons.errorCode]) {
            errorCode = [[response objectForKey:OpenSuitCommons.errorCode]intValue];
        }
        if ([[response allKeys]containsObject:OpenSuitCommons.error]) {
            errorMsg = [response objectForKey:OpenSuitCommons.error];
        }
        if (errorCode == 0) {
            NSString* responseString = [OpenSuitCommons stringWithJSONObject:response error:nil];
            callback(true,responseString,nil);
        } else {
            NSError* error = [NSError errorWithDomain:@"com.yodo1.querySubscriptions"
                                                 code:errorCode
                                             userInfo:@{NSLocalizedDescriptionKey:errorMsg}];
            callback(false,itemInfo.orderId,error);
        }
    } failBlock:^(NSError * _Nonnull error) {
        OpenSuitLog(@"%@",error);
        callback(false,nil,error);
    }];
}

- (void)sendGoodsOver:(NSString *)orderIds callback:(void (^)(BOOL, NSString * _Nonnull))callback {
    if (!orderIds || orderIds.length < 1) {
        callback(false,@"order Ids is empty!");
        return;
    }
    OpenSuitCommons.shared.requestURL = OpenSuitCommons.paymentDomain;
    NSString* sign = [OpenSuitCommons signMd5String:[NSString stringWithFormat:@"yodo1%@",orderIds]];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:orderIds forKey:@"orderids"];
    [parameters setObject:sign forKey:OpenSuitCommons.sign];
    
    OpenSuitLog(@"%@",[OpenSuitCommons stringWithJSONObject:parameters error:nil]);
    [OpenSuitCommons.shared requestGET:OpenSuitCommons.sendGoodsOverURL
                                params:parameters
                           contentType:@"text/plain; charset=utf-8"
                          successBlock:^(NSDictionary * _Nonnull responseObject) {
        NSDictionary* response = [OpenSuitCommons JSONObjectWithObject:responseObject];
        int errorCode = -1;
        NSString* error = @"";
        if ([[response allKeys]containsObject:OpenSuitCommons.errorCode]) {
            errorCode = [[response objectForKey:OpenSuitCommons.errorCode]intValue];
        }
        if ([[response allKeys]containsObject:OpenSuitCommons.error]) {
            error = [response objectForKey:OpenSuitCommons.error];
        }
        if (errorCode == 0) {
            callback(true,@"");
        } else {
            callback(false,error);
        }
    } failBlock:^(NSError * _Nonnull error) {
        OpenSuitLog(@"%@",error);
        callback(false,error.localizedDescription);
    }];
}

- (void)sendGoodsOverForFault:(NSString *)orderIds
                     callback:(void (^)(BOOL success,NSString* error))callback {
    if (!orderIds || orderIds.length < 1) {
        callback(false,@"order Ids is empty!");
        return;
    }
    NSString* sign = [OpenSuitCommons signMd5String:[NSString stringWithFormat:@"yodo1%@",orderIds]];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:orderIds forKey:@"orderids"];
    [parameters setObject:sign forKey:OpenSuitCommons.sign];
    
    OpenSuitLog(@"%@",[OpenSuitCommons stringWithJSONObject:parameters error:nil]);
    [OpenSuitCommons.shared requestGET:OpenSuitCommons.sendGoodsOverFaultURL
                                params:parameters
                           contentType:@"text/plain; charset=utf-8"
                          successBlock:^(NSDictionary * _Nonnull responseObject) {
        NSDictionary* response = [OpenSuitCommons JSONObjectWithObject:responseObject];
        int errorCode = -1;
        NSString* error = @"";
        if ([[response allKeys]containsObject:OpenSuitCommons.errorCode]) {
            errorCode = [[response objectForKey:OpenSuitCommons.errorCode]intValue];
        }
        if ([[response allKeys]containsObject:OpenSuitCommons.error]) {
            error = [response objectForKey:OpenSuitCommons.error];
        }
        if (errorCode == 0) {
            callback(true,@"");
        } else {
            callback(false,error);
        }
    } failBlock:^(NSError * _Nonnull error) {
        OpenSuitLog(@"%@",error);
        callback(false,error.localizedDescription);
    }];
}

- (void)clientCallback:(PayProductInfo *)itemInfo callbakc:(void (^)(BOOL, NSString * _Nonnull))callback {
    if (!itemInfo) {
        callback(false,@"item info is empty!");
        return;
    }
    OpenSuitCommons.shared.requestURL = OpenSuitCommons.paymentDomain;
    NSString* sign = [OpenSuitCommons signMd5String:[NSString stringWithFormat:@"yodo1%@",itemInfo.orderId]];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:itemInfo.orderId forKey:@"orderid"];
    [parameters setObject:itemInfo.extra forKey:@"extra"];
    [parameters setObject:sign forKey:OpenSuitCommons.sign];
    
    OpenSuitLog(@"%@",[OpenSuitCommons stringWithJSONObject:parameters error:nil]);
    [OpenSuitCommons.shared requestGET:OpenSuitCommons.clientCallbackURL
                                params:parameters
                           contentType:@"text/plain; charset=utf-8"
                          successBlock:^(NSDictionary * _Nonnull responseObject) {
        NSDictionary* response = [OpenSuitCommons JSONObjectWithObject:responseObject];
        int errorCode = -1;
        NSString* error = @"";
        if ([[response allKeys]containsObject:OpenSuitCommons.errorCode]) {
            errorCode = [[response objectForKey:OpenSuitCommons.errorCode]intValue];
        }
        if ([[response allKeys]containsObject:OpenSuitCommons.error]) {
            error = [response objectForKey:OpenSuitCommons.error];
        }
        if (errorCode == 0) {
            callback(true,error);
        } else {
            callback(false,error);
        }
    } failBlock:^(NSError * _Nonnull error) {
        OpenSuitLog(@"%@",error);
        callback(false,error.localizedDescription);
    }];
}

- (void)reportOrderStatus:(PayProductInfo *)itemInfo callbakc:(void (^)(BOOL, NSString * _Nonnull))callback {
    if (!itemInfo) {
        callback(false,@"item info is empty!");
        return;
    }
    OpenSuitCommons.shared.requestURL = OpenSuitCommons.paymentDomain;
    NSString* sign = [OpenSuitCommons signMd5String:[NSString stringWithFormat:@"payment%@",itemInfo.orderId]];
    NSDictionary* data = @{
        @"orderId":itemInfo.orderId,
        @"channelCode":itemInfo.channelCode? :@"AppStore",
        @"channelOrderid":itemInfo.channelOrderid,
        @"statusCode":itemInfo.statusCode,
        @"statusMsg":itemInfo.statusMsg? :@""
    };
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:data forKey:OpenSuitCommons.data];
    [parameters setObject:sign forKey:OpenSuitCommons.sign];
    
    OpenSuitLog(@"%@",[OpenSuitCommons stringWithJSONObject:parameters error:nil]);
    [OpenSuitCommons.shared requestPost:OpenSuitCommons.reportOrderStatusURL
                                 params:parameters
                            contentType:@"text/plain; charset=utf-8"
                           successBlock:^(NSDictionary * _Nonnull responseObject) {
        NSDictionary* response = [OpenSuitCommons JSONObjectWithObject:responseObject];
        int errorCode = -1;
        NSString* error = @"";
        if ([[response allKeys]containsObject:OpenSuitCommons.errorCode]) {
            errorCode = [[response objectForKey:OpenSuitCommons.errorCode]intValue];
        }
        if ([[response allKeys]containsObject:OpenSuitCommons.error]) {
            error = [response objectForKey:OpenSuitCommons.error];
        }
        if (errorCode == 0) {
            callback(true,error);
        } else {
            callback(false,error);
        }
    } failBlock:^(NSError * _Nonnull error) {
        OpenSuitLog(@"%@",error);
        callback(false,error.localizedDescription);
    }];
}

- (void)clientNotifyForSyncUnityStatus:(NSArray *)orderIds
                              callback:(nonnull void (^)(BOOL, NSArray * _Nonnull, NSArray * _Nonnull, NSString * _Nonnull))callback {
    if (!orderIds || [orderIds count] < 1) {
        callback(false,@[],@[],@"order Ids is empty!");
        return;
    }
    OpenSuitCommons.shared.requestURL = OpenSuitCommons.paymentDomain;
    NSString* timestamp = [OpenSuitCommons nowTimeTimestamp];
    NSString* sign = [OpenSuitCommons signMd5String:[NSString stringWithFormat:@"payment%@",timestamp]];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject:orderIds forKey:@"orderIds"];
    [data setObject:timestamp forKey:@"timestamp"];
    [parameters setObject:data forKey:@"data"];
    [parameters setObject:sign forKey:OpenSuitCommons.sign];
    
    
    OpenSuitLog(@"%@",[OpenSuitCommons stringWithJSONObject:parameters error:nil]);
    [OpenSuitCommons.shared requestPost:OpenSuitCommons.clientNotifyForSyncUnityStatusURL
                                 params:parameters
                            contentType:@"text/plain; charset=utf-8"
                           successBlock:^(NSDictionary * _Nonnull responseObject) {
        NSDictionary* response = [OpenSuitCommons JSONObjectWithObject:responseObject];
        int errorCode = -1;
        NSString* error = @"";
        
        if ([[response allKeys]containsObject:OpenSuitCommons.errorCode]) {
            errorCode = [[response objectForKey:OpenSuitCommons.errorCode]intValue];
        }
        if ([[response allKeys]containsObject:OpenSuitCommons.error]) {
            error = [response objectForKey:OpenSuitCommons.error];
        }
        NSMutableArray* notExistOrders = [NSMutableArray array];
        NSMutableArray* notPayOrders = [NSMutableArray array];
        if ([[response allKeys]containsObject:@"data"]) {
            NSDictionary* data = [response objectForKey:@"data"];
            if (data && [[data allKeys]containsObject:@"notExistOrders"]) {
                NSArray* notExist = [data objectForKey:@"notExistOrders"];
                [notExistOrders setArray:notExist];
            }
            if (data && [[data allKeys]containsObject:@"notPayOrders"]) {
                NSArray* notPay = [data objectForKey:@"notPayOrders"];
                [notPayOrders setArray:notPay];
            }
        }
        if (errorCode == 0) {
            callback(true,notExistOrders,notPayOrders,@"");
        } else {
            callback(false,notExistOrders,notPayOrders,error);
        }
    } failBlock:^(NSError * _Nonnull error) {
        OpenSuitLog(@"%@",error);
        callback(false,@[],@[],error.localizedDescription);
    }];
}

- (void)offlineMissorders:(PayProductInfo *)itemInfo
                 callback:(nonnull void (^)(BOOL success, NSArray * _Nonnull missorders,NSString* _Nonnull error))callback {
    if (!itemInfo.uid) {
        callback(false,@[],@"uid  is nil!");
        return;
    }
    
    OpenSuitCommons.shared.requestURL = OpenSuitCommons.paymentDomain;
    NSString* sign = [OpenSuitCommons signMd5String:[NSString stringWithFormat:@"payment%@",itemInfo.uid]];
    NSDictionary* data = @{
        @"uid":itemInfo.uid,
        @"gameAppkey":OpenSuitPayManager.shared.payAppKey,
        @"channelCode":OpenSuitPayManager.shared.payChannelId,
        @"regionCode":OpenSuitPayment.shared.regionCode
    };
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:data forKey:OpenSuitCommons.data];
    [parameters setObject:sign forKey:OpenSuitCommons.sign];
    
    OpenSuitLog(@"%@",[OpenSuitCommons stringWithJSONObject:parameters error:nil]);
    [OpenSuitCommons.shared requestPost:OpenSuitCommons.offlineMissordersURL
                                 params:parameters
                            contentType:@"text/plain; charset=utf-8"
                           successBlock:^(NSDictionary * _Nonnull responseObject) {
        NSDictionary* response = [OpenSuitCommons JSONObjectWithObject:responseObject];
        int errorCode = -1;
        NSString* error = @"";
        if ([[response allKeys]containsObject:OpenSuitCommons.errorCode]) {
            errorCode = [[response objectForKey:OpenSuitCommons.errorCode]intValue];
        }
        if ([[response allKeys]containsObject:OpenSuitCommons.error]) {
            error = [response objectForKey:OpenSuitCommons.error];
        }
        NSMutableArray* orders = [NSMutableArray array];
        if ([[response allKeys]containsObject:@"data"]) {
            NSArray* data = [response objectForKey:@"data"];
            if ([data count] > 0) {
                [orders setArray:data];
            }
        }
        
        if (errorCode == 0) {
            callback(true,orders,error);
        } else {
            callback(false,orders,error);
        }
    } failBlock:^(NSError * _Nonnull error) {
        OpenSuitLog(@"%@",error);
        callback(false,@[],error.localizedDescription);
    }];
}

@end
