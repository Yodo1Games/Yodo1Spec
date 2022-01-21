//
//  OpenSuitCommons+Network.h
//
//  Created by yixian huang on 2017/7/24.
//
//

#ifndef Yd1NetworkTool_h
#define Yd1NetworkTool_h

#import "OpenSuitCommons.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^Yd1ResponseSuccessBlock)(NSDictionary *responseObject);

typedef void(^Yd1ResponseFailBlock)(NSError *error);

@interface OpenSuitCommons(Network)

/// JSON格式网络接口请求方法
/// @param relativePath 接口名称
/// @param params 请求参数
/// @param successBlock 请求成功回调
/// @param failBlock 请求失败回调
- (void)requestPost:(NSString *)relativePath
             params:(NSDictionary *)params
        contentType:(NSString * _Nullable)contentType
       successBlock:(Yd1ResponseSuccessBlock)successBlock
          failBlock:(Yd1ResponseFailBlock)failBlock;


/// JSON格式网络接口请求方法
/// @param relativePath 接口名称
/// @param params 请求参数
/// @param contentType contentType
/// @param successBlock 请求成功回调
/// @param failBlock 请求失败回调
- (void)requestGET:(NSString *)relativePath
            params:(NSDictionary *)params
       contentType:(NSString * _Nullable)contentType
      successBlock:(Yd1ResponseSuccessBlock)successBlock
         failBlock:(Yd1ResponseFailBlock)failBlock;

@end

NS_ASSUME_NONNULL_END
#endif /* Yd1NetworkTool_h */
