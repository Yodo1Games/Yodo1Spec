//
//  OpenSuitPayManager.h
//
//  Created by yixian huang on 2017/7/24.
//
//

#ifndef OpenSuitPayManager_h
#define OpenSuitPayManager_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    OpenSuitPayResulType_Payment = 2001,
    OpenSuitPayResulType_RestorePayment = 2002,
    OpenSuitPayResulType_RequestProductsInfo = 2003,
    OpenSuitPayResulType_VerifyProductsInfo = 2004,
    OpenSuitPayResulType_LossOrderIdQuery = 2005,
    OpenSuitPayResulType_QuerySubscriptions = 2006,
    OpenSuitPayResulType_FetchPayPromotionVisibility = 2007,
    OpenSuitPayResulType_FetchStorePromotionOrder = 2008,
    OpenSuitPayResulType_UpdateStorePayPromotionVisibility = 2009,
    OpenSuitPayResulType_UpdateStorePromotionOrder = 2010,
    OpenSuitPayResulType_GetPromotionProduct = 2011,
    OpenSuitPayResulType_ValidatePayment = 2012,
    OpenSuitPayResulType_SendGoodsOver = 2013,
    OpenSuitPayResulType_SendGoodsOverFault = 2014,
}OpenSuitPayResulType;

typedef enum {
    PayCannel = 0,      //取消支付
    PaySuccess,         //支付成功
    PaytFail,            //支付失败
    PayValidationFail   //ops 验证失败
}PayState;

typedef enum {
    Default = 0,
    Visible,
    Hide
}PayPromotionVisibility;

typedef enum {
    NonConsumables = 0,//不可消耗
    Consumables,//可消耗
    Auto_Subscription,//自动订阅
    None_Auto_Subscription//非自动订阅
}OpenSuitProductType;

@class OpenSuitProduct;
@class OpenSuitPayObject;

typedef void (^OpenSuitPayCallback) (OpenSuitPayObject* payemntObject);
typedef void (^OpenSuitRestoreCallback)(NSArray* productIds,NSString* response);
typedef void (^OpenSuitLossOrderCallback)(NSArray* productIds,NSString* response);
typedef void (^OpenSuitFetchStorePromotionOrderCallback) (NSArray<NSString *> *  storePromotionOrder, BOOL success, NSString*  error);
typedef void (^OpenSuitFetchStorePayPromotionVisibilityCallback) (PayPromotionVisibility storePayPromotionVisibility, BOOL success, NSString*  error);
typedef void (^OpenSuitUpdateStorePromotionOrderCallback) (BOOL success, NSString*  error);
typedef void (^OpenSuitUpdateStorePayPromotionVisibilityCallback)(BOOL success, NSString*  error);
typedef void (^OpenSuitProductsInfoCallback) (NSArray<OpenSuitProduct*> *productInfo);

/**
 *@brief
 *  查询订阅信息接口
 *@param success YES查询订阅信息成功，NO查询订阅信息失败。
 *@param subscriptions 订阅信息
 *@param serverTime 当前服务器时间
 *@error 错误信息
 */
typedef void (^OpenSuitQuerySubscriptionCallback)(NSArray* subscriptions, NSTimeInterval serverTime, BOOL success,NSString* _Nullable error);

/**
 *@brief
 *   苹果支付订单验证票据回调方法
 *@param uniformProductId 产品ID
 *@param response json格式 @{@"productIdentifier":@"苹果产品id",
 *  @"transactionIdentifier":@"订单号",@"transactionReceipt":@"验证票据"}
 */
typedef void (^OpenSuitValidatePaymentBlock) (NSString *uniformProductId,NSString* response);

@interface OpenSuitPayObject : NSObject
@property (nonatomic, strong) NSString* uniformProductId;
@property (nonatomic, strong) NSString* orderId;
@property (nonatomic, strong) NSString* channelOrderid;
@property (nonatomic, assign) PayState PayState;
@property (nonatomic, strong) NSString* response;
@property (nonatomic, strong) NSError* error;
@end

@interface OpenSuitProduct : NSObject
@property (nonatomic, strong) NSString* uniformProductId;
@property (nonatomic, strong) NSString* channelProductId;
@property (nonatomic, strong) NSString* productName;
@property (nonatomic, strong) NSString* productPrice;
@property (nonatomic, strong) NSString* priceDisplay;
@property (nonatomic, strong) NSString* productDescription;
@property (nonatomic, strong) NSString* currency;
@property (nonatomic, strong) NSString* orderId;
@property (nonatomic, assign) OpenSuitProductType openSuitProductType;
///订阅时间: 每周，每月，每年,每2个月...
@property (nonatomic, strong) NSString* periodUnit;
- (instancetype)initWithDict:(NSDictionary*)dictProduct
                   productId:(NSString*)uniformProductId;
- (instancetype)initWithProduct:(OpenSuitProduct*)product;
@end

@class PayUser;

@interface OpenSuitPayManager : NSObject

+ (instancetype)shared;

@property (nonatomic,assign)__block BOOL isLogined;
@property (nonatomic,strong)__block PayUser* user;
@property (nonatomic,strong)NSMutableDictionary* superProperty;
@property (nonatomic,strong)NSMutableDictionary* itemProperty;
@property (nonatomic,strong,readonly)NSString* payAppKey;
@property (nonatomic,strong,readonly)NSString* payChannelId;

/// Apple Pay note callback
@property (nonatomic,copy)OpenSuitValidatePaymentBlock  OpenSuitValidatePaymentBlock;

/// start Open Suit Pay with AppKey and ChannelId
/// @param appKey AppKey
/// @param channelId ChannelId
- (void)startOpenSuitPayWithAppKey:(NSString *)appKey channelId:(NSString *)channelId;

/**
 *  根据channelProductId 获取uniformProductId
 */
- (NSString *)uniformProductIdWithChannelProductId:(NSString *)channelProductId;

/**
 *  创建订单号和订单，返回订单号
 */
- (void)createOrderIdWithUniformProductId:(NSString *)uniformProductId
                                    extra:(NSString*)extra
                                 callback:(void (^)(bool success,NSString * orderid,NSString* error))callback;

/**
 * 购买产品
 * extra 是字典json字符串 @{@"channelUserid":@""}
 */
- (void)paymentWithUniformProductId:(NSString *)uniformProductId
                              extra:(NSString*)extra
                           callback:(OpenSuitPayCallback)callback;

/**
 *  恢复购买
 */
- (void)restorePayment:(OpenSuitRestoreCallback)callback;

/**
 *  查询漏单
 */
- (void)queryLossOrder:(OpenSuitLossOrderCallback)callback;

/**
 *  查询订阅
 */
- (void)querySubscriptions:(BOOL)excludeOldTransactions
                  callback:(OpenSuitQuerySubscriptionCallback)callback;

/**
 *  获取产品信息
 */
- (void)productWithUniformProductId:(NSString*)uniformProductId
                           callback:(OpenSuitProductsInfoCallback)callback;

/**
 *  获取所有产品信息
 */
- (void)products:(OpenSuitProductsInfoCallback)callback;

/**
 *  获取促销订单
 */
- (void)fetchStorePromotionOrder:(OpenSuitFetchStorePromotionOrderCallback) callback;

/**
 *  获取促销活动订单可见性
 */
- (void)fetchStorePayPromotionVisibilityForProduct:(NSString*)uniformProductId
                                       callback:(OpenSuitFetchStorePayPromotionVisibilityCallback)callback;
/**
 *  更新促销活动订单
 */
- (void)updateStorePromotionOrder:(NSArray<NSString *> *)uniformProductIdArray
                         callback:(OpenSuitUpdateStorePromotionOrderCallback)callback;

/**
 *  更新促销活动可见性
 */
- (void)updateStorePayPromotionVisibility:(BOOL)visibility
                               product:(NSString*)uniformProductId
                              callback:(OpenSuitUpdateStorePayPromotionVisibilityCallback)callback;

/**
 *  准备继续购买促销
 */
- (void)readyToContinuePurchaseFromPromot:(OpenSuitPayCallback)callback;

/**
 *  取消购买
 */
- (void)cancelPromotion;

/**
 *  获取促销产品
 */
- (OpenSuitProduct*)promotionProduct;

@end

NS_ASSUME_NONNULL_END
#endif /* OpenSuitPayManager_h */
