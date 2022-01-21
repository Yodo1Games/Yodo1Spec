//
//  OpenSuitCommons+Network.m
//  OpenSuitCommons+Network
//
//  Created by yixian huang on 2017/7/24.
//

#import "OpenSuitCommons+Network.h"

@implementation OpenSuitCommons(Network)

- (void)requestHTTPMethod:(NSString *)httpMenthod
             relativePath:(NSString *)relativePath
              contentType:(NSString * _Nullable)contentType
                   params:(NSDictionary *)params
             successBlock:(Yd1ResponseSuccessBlock)successBlock
                failBlock:(Yd1ResponseFailBlock)failBlock
{
    NSMutableString *urlString = [NSMutableString stringWithString:self.requestURL];
    [urlString appendString:relativePath];
    if ([httpMenthod isEqualToString:@"GET"]) {
        [urlString appendString:@"?"];
        [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [urlString appendFormat:@"&%@=%@",key, obj];
        }];
    }
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    request.HTTPMethod = httpMenthod;
    
    if ([httpMenthod isEqualToString:@"POST"]){
        request.HTTPBody = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    }
    if (!contentType) {
        contentType = @"application/json; charset=utf-8";
    }
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                if (successBlock) {
                    NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                    successBlock(responseObject);
                }
            } else {
                if (failBlock) {
                    failBlock(error);
                }
            }
        });
    }];
    [dataTask resume];
}

- (void)requestPost:(NSString *)relativePath
             params:(NSDictionary *)params
        contentType:(NSString * _Nullable)contentType
       successBlock:(Yd1ResponseSuccessBlock)successBlock
          failBlock:(Yd1ResponseFailBlock)failBlock
{
    [self requestHTTPMethod:@"POST"
               relativePath:relativePath
                contentType:contentType
                     params:params
               successBlock:^(NSDictionary * _Nonnull responseObject) {
        
        if (successBlock) {
            return successBlock(responseObject);
        }
    } failBlock:^(NSError * _Nonnull error) {
        if (failBlock) {
            return failBlock(error);
        }
    }];
}

- (void)requestGET:(NSString *)relativePath
            params:(NSDictionary *)params
       contentType:(NSString *)contentType
      successBlock:(Yd1ResponseSuccessBlock)successBlock
         failBlock:(Yd1ResponseFailBlock)failBlock {
    [self requestHTTPMethod:@"GET"
               relativePath:relativePath
                contentType:contentType
                     params:params
               successBlock:^(NSDictionary * _Nonnull responseObject) {
        
        if (successBlock) {
            return successBlock(responseObject);
        }
    } failBlock:^(NSError * _Nonnull error) {
        if (failBlock) {
            return failBlock(error);
        }
    }];
}

@end
