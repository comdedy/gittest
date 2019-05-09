//
//  GSHttpManager.m
//  GSHttpManagerDemo
//
//  Created by 关宇琼 on 16/6/8.
//  Copyright © 2016年 GuanSir. All rights reserved.
//

#import "GSHttpManager.h"


#define gs_completeURL(base, component) [NSString stringWithFormat:@"%@%@",(base),(component)]


/**
 *  获取类的名字变作字符串
 */

#define gs_GetClass_Name(vc)      [NSString stringWithUTF8String:object_getClassName(vc)]

#define gs_Error_Network              @"网络不给力"

@interface GSHttpManager () {
    
    NSInteger reachabilityStatus;
    
    AFHTTPSessionManager *httpManager;
    
    NSTimeInterval timeoutInterval;
    
}

@end


@implementation GSHttpManager


+ (instancetype)currentManager {
    
    return [self sharedHttpManager];
    
}

+ (instancetype)sharedHttpManager {
    
    static id instance;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        instance = [[[self class] alloc] init];
        
    });
    
    return instance;
    
}

- (instancetype)init
{
    
    httpManager = [AFHTTPSessionManager manager];
    
    httpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    timeoutInterval = 86400;
    
    return self;
    
}

- (void)httpManagerGSNetworkReachabilityManage {
    
    [gs_ReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        reachabilityStatus = status;
        
        switch (status) {
                
            case AFNetworkReachabilityStatusNotReachable: {
                
                NSLog(@"无网络");
                
                break;
                
            }
                
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                
                NSLog(@"WiFi网络");
                
                break;
                
            }
                
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                
                NSLog(@"无线网络");
                
                break;
                
            }
                
            default:
                
                NSLog(@"不明网络");
                
                break;
                
        }
        
    }];

}

/**
 *  POST
 *
 *  @param param          入参
 *  @param urlStr         请求地址
 *  @param isCache          是否缓存
 *  @param viewController 当前的vc
 *  @param success        成功返回值
 *  @param fail           失败返回值
 */

- (void)httpManagerPostParameter:(NSDictionary *)param toHttpUrlStr:(NSString *)urlStr isCacheorNot:(BOOL)isCache  targetViewController:(UIViewController *)viewController andUrlFunctionName:(NSString *)urlName success:(void(^)(id result))success orFail:(void(^)(NSError *error))fail {
    
    switch (reachabilityStatus) {
            
        case 0: {
            
            if (![gs_CurrentFileManager objectForKey:gs_completeURL(gs_GetClass_Name(viewController), urlName)]) {
                
                NSError *er = [[NSError alloc] initWithDomain:@"暂无缓存可用" code:10001 userInfo:nil];
                
                fail(er);
//                [YJProgressHUD showError:@"网络连接失败,请检查网络"];
                return;
                
            }
            
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:(NSData *)[gs_CurrentFileManager objectForKey:gs_completeURL(gs_GetClass_Name(viewController), urlName)] options:NSJSONReadingMutableLeaves|NSJSONReadingMutableContainers error:nil];
            
            success(jsonDic);
        }
            break;
            
        default: {
            
            [httpManager POST:urlStr parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if (task.state == NSURLSessionTaskStateCompleted) {
                    
                    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves|NSJSONReadingMutableContainers error:nil];
                        
                    if (isCache) {
                        
                        [gs_CurrentFileManager setObject:responseObject forKey:gs_completeURL(gs_GetClass_Name(viewController), urlName) withTimeoutInterval:timeoutInterval];
                        
                    }
                    
                    success(jsonDic);
                    
                } else {
                    
                    NSError *error = [[NSError alloc] initWithDomain:gs_Error_Network code:0 userInfo:nil];
                    
                    fail(error);
                    
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                fail(error);
                NSLog(@"error-----%@",error);
            }];
            
        }
            break;
    }
}


- (void)httpManagerGetFromHttpUrlStr:(NSString *)urlStr withParameter:(NSDictionary *)param isCacheorNot:(BOOL)isCache  targetViewController:(UIViewController *)viewController andUrlFunctionName:(NSString *)urlName success:(void(^)(id result))success orFail:(void(^)(NSError *error))fail {
    
    switch (reachabilityStatus) {
            
        case 0: {
            
            if (![gs_CurrentFileManager objectForKey:gs_completeURL(gs_GetClass_Name(viewController), urlName)]) {
                
                NSError *er = [[NSError alloc] initWithDomain:@"暂无缓存可用" code:10001 userInfo:nil];
                
                fail(er);
                
                return;
                
            }
            
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:(NSData *)[gs_CurrentFileManager objectForKey:gs_completeURL(gs_GetClass_Name(viewController), urlName)] options:NSJSONReadingMutableLeaves|NSJSONReadingMutableContainers error:nil];
            
            success(jsonDic);
            
        }
            break;
            
        default: {
            
            [httpManager GET:urlStr parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if (task.state == NSURLSessionTaskStateCompleted) {
                    
                    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves|NSJSONReadingMutableContainers error:nil];
                    
                    if (isCache) {
                        
                        [gs_CurrentFileManager setObject:responseObject forKey:gs_completeURL(gs_GetClass_Name(viewController), urlName) withTimeoutInterval:timeoutInterval];
                        
                    }
                    
                    success(jsonDic);
                    
                } else {
                    
                    NSError *error = [[NSError alloc] initWithDomain:gs_Error_Network code:0 userInfo:nil];
                    
                    fail(error);
                    
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                fail(error);
                
            }];
            
        }
            break;
    }

}

/**
 *  AFN 3.0 上传
 *      有两种方式
 *          upLoad1 和 upLoad2
 */

//第一种方法是通过工程中的文件进行上传
- (void)postWithUrl:(NSString *)url body:(NSDictionary *)body success:(void(^)(NSDictionary *response))success failure:(void(^)(NSError *error))failure{
    
    //1。创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPRequestSerializer *requestSerializer =  [AFJSONRequestSerializer serializer];
    manager.requestSerializer = requestSerializer;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //2.上传文件
    //    NSDictionary *dict = @{@"FileBase64":@"",@"FolderType":@"",@"FileExt":@""};
    
    //    NSString *urlString = @"http://218.108.63.142:8001/YQNCWSWeb/UploadHandler.ashx";
    [manager POST:url parameters:body constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //        //上传文件参数
        //        UIImage *iamge = [UIImage imageNamed:@"1122.png"];
        //        NSData *data = UIImagePNGRepresentation(iamge);
        //        //这个就是参数
        //        [formData appendPartWithFileData:data name:@"file" fileName:@"1122.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印下上传进度
        //        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSString * str  =[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves|NSJSONReadingMutableContainers error:nil];
        
        //请求成功
//        NSLog(@"请求成功：%@",jsonDic);
        success(jsonDic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        //请求失败
//        NSLog(@"请求失败：%@",error);
    }];
    
}


@end
