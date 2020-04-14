//
//  Network.m
//  KlineFight
//  
//  Created by lq on 15/10/22.
//  Copyright © 2015年 Guangzhou ZhangAoBo Software Technology Co., Ltd. All rights reserved.
//
#import "Network.h"

#import "AFHTTPSessionManager.h"
#import "DeviceInfo.h"
#import "Constant.h"
#import "OpenUDID.h"



@implementation NetworkTask{
    NSURLSessionDataTask *_sessionDatatask;
}

+ (instancetype)netWorkWithSessionDataTask:(NSURLSessionDataTask*)task{
    NetworkTask *atask=[[NetworkTask alloc] init];
    atask->_sessionDatatask=task;
    return atask;
}

- (void)cancel{
    [_sessionDatatask cancel];
}

- (void)suspend{
    [_sessionDatatask suspend];
}

- (void)resume{
    [_sessionDatatask resume];
}
@end


@implementation Network{
    AFHTTPSessionManager *_manager;
    NSString *_appVersion;
    NSString *_clientType;
    BOOL      _isTest;
}

+(instancetype)shareInstance{
    static Network *network=nil;
    static dispatch_once_t singlet;
    dispatch_once(&singlet, ^{
        network=[[Network alloc] init];
    });
    return network;
}

-(instancetype)init{
    self=[super init];
    if(self){
        [self instannceManagerWithHost:KHOST];
    }
    return self;
}

-(void)instannceManagerWithHost:(NSString*)host{
   
    _manager=[[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:host]];

    //无条件的信任服务器上的证书
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    // 客户端是否信任非法证书
    securityPolicy.allowInvalidCertificates = YES;
    // 是否在证书域字段中验证域名
    securityPolicy.validatesDomainName = NO;
    _manager.securityPolicy = securityPolicy;
    
    //设置请求头
    _manager.requestSerializer = [AFJSONRequestSerializer new];
//    NSString * udid = [DeviceInfo getUUID];
    _manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil ];
    
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];


//    RI.token = udid;
    
//    NSString *neverChangeStr = [DeviceInfo getNerverChangeUUID];
    NSString* openUDID = [OpenUDID value];
    

    [_manager.requestSerializer setValue:openUDID forHTTPHeaderField:@"token"];

//
//
//    _appVersion=[[[NSBundle mainBundle] infoDictionary] safeObjectForKey:@"CFBundleShortVersionString"];
//
}
    
- (nullable NetworkTask *)GETWithParameters:(nullable id)parameters
                                    success:(nullable void (^)(NSURLSessionDataTask *task, id resultObject))success
                                    failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error, id resultObject))failure;
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters?parameters : @{}];
    //    [dic setObject:@"1" forKey:@"i_type"];
    //    [dic setObject:@"1" forKey:@"r_type"];
    return [self GET:@"/mapi/index.php" parameters:dic criticalValue:nil success:success failure:failure];
    
//    NSString *ASEStr = nil;
//    if (parameters) {
//        NSString *jsonStr = [parameters mj_JSONString];
//        ASEStr = [STEncrypt AESEncryptWithSting:jsonStr];
//    }
//     NSMutableDictionary *dic = [NSMutableDictionary dictionary];
#warning 需要改
//    [dic setObject:@"4" forKey:@"i_type"];
//    [dic setObject:@"4" forKey:@"r_type"];
//    [dic setObject:@"iOS" forKey:@"os"];
//    NSString *appVersion = [UIDevice currentDevice].systemVersion;
//    [dic setObject:appVersion forKey:@"app_version"];
//    [dic setObject:@"app" forKey:@"client_type"];
//    
//    [dic setObject:@"Apple" forKey:@"mobile_brand"];
//    [dic setObject:@"iPhone" forKey:@"mobile_model"];
//     if (ASEStr) {
//         [dic setObject:ASEStr forKey:@"requestData"];
//     }
//    return [self GET:@"/mapi/index.php" parameters:dic criticalValue:nil success:success failure:failure];
}

- (nullable NetworkTask *)POSTWithParameters:(nullable id)parameters
                                     success:(nullable void (^)(NSURLSessionDataTask *task, id resultObject))success
                                     failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error, id resultObject))failure
{
    /**
     
     数据格式 拼接成下面的样式  然后再DES加密
     {
     "params": "page_index=0&page_size=15&tag=22&text=51778&type=0"
    }
     */


    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters?parameters : @{@"params": @""}];
    
    
    return [self POST:@"/mapi/index.php" parameters:dic criticalValue:nil success:success failure:failure];

}

- (nullable NetworkTask *)GET:(NSString *)URLString
                   parameters:(nullable id)parameters
                criticalValue:(nullable NSDictionary*)criticalValue
                      success:(nullable void (^)(NSURLSessionDataTask *task, id resultObject))success
                      failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error, id resultObject))failure{
    
    [self _refreshHeaderWithCriticalValue:criticalValue];
    NSURLSessionDataTask *t=[_manager GET:[self conversionURL:URLString] parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self logDebugInfoWithOperation:task error:nil responseObject:responseObject];
        [self _handdleSuccessWithTask:task responseObject:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self logDebugInfoWithOperation:task error:error responseObject:nil];
        [self _handdleFailureWithTask:task error:error failure:failure];
    }];
    [self logDebugInfoWithRequest:t.originalRequest reqeustParams:parameters reqeustMethod:@"GET"];

    return [NetworkTask netWorkWithSessionDataTask:t];
}

- (nullable NetworkTask *)POST:(NSString *)URLString
                    parameters:(nullable id)parameters
                 criticalValue:(nullable NSDictionary*)criticalValue
                       success:(nullable void (^)(NSURLSessionDataTask *task, id resultObject))success
                       failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error,id resultObject))failure{
    [self _refreshHeaderWithCriticalValue:criticalValue];
    
    /**
     
     数据格式 拼接成下面的样式  然后再DES加密
     {
     "params": "page_index=0&page_size=15&tag=22&text=51778&type=0"
    }
     */
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters?parameters : @{}];

    NSString *DESStr = [self dealRequestDic:dic];
    //针对下载图片 不用加密解密 参数也不用拼接；
    BOOL NoEncode = [[criticalValue safeObjectForKey:@"NoEncode"] boolValue];
    
    NSDictionary * paramDict = NoEncode ? dic :  @{@"params" : DESStr};

    NSURLSessionDataTask *t=[_manager POST:[self conversionURL:URLString] parameters:paramDict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id  jsonResponse;
        id  decrypStr;
        
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSString *resStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            if (NoEncode) {//不要加密解密
                decrypStr = resStr;
                jsonResponse = decrypStr;//base64字符串

            }else{
                decrypStr = [RSAEncryptor decodeDesWithString:resStr];
                jsonResponse = [decrypStr mj_JSONObject];

            }
        }else{
            jsonResponse = responseObject;
        }
        

        [self logDebugInfoWithOperation:task error:nil responseObject:decrypStr];
        if (NoEncode) {//不用加密 就是下载u图片
            [self _downImagehanddleSuccessWithTask:task responseObject:jsonResponse success:success failure:failure];
        }else{
            [self _handdleSuccessWithTask:task responseObject:jsonResponse success:success failure:failure];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self logDebugInfoWithOperation:task error:error responseObject:nil];
        [self _handdleFailureWithTask:task error:error failure:failure];
    }];
    [self logDebugInfoWithRequest:t.originalRequest reqeustParams:parameters reqeustMethod:@"POST"];
    return [NetworkTask netWorkWithSessionDataTask:t];
}
-(NSString *)dealRequestDic:(NSMutableDictionary *)dic {

    NSArray *keyArray = [dic allKeys];
    NSArray *sortArray = [keyArray sortedArrayUsingComparator:^NSComparisonResult(id _Nonnull obj1, id _Nonnull obj2) {
        return [obj1 compare: obj2 options:NSNumericSearch];
    }];
    //对key进行遍历排序
    NSMutableArray *valueArray = [NSMutableArray array];
    for (NSString *sortString in sortArray) {
        [valueArray addObject:[dic objectForKey: sortString]];
    }
    //对排序后的key取value
    NSMutableArray *signArray = [NSMutableArray array];
    for (int i =0; i < sortArray.count; i++) {
        NSString *keyValueStr = [NSString stringWithFormat:@"%@=%@",sortArray[i],valueArray[i]];
        [signArray addObject: keyValueStr];
    }
    //输出新的数组   key=value
    NSLog(@"signArray====%@",signArray);
    NSString *sign = [signArray componentsJoinedByString:@"&"];
    NSLog(@"sign==%@",sign);
    /**
     
     数据格式 拼接成下面的样式  然后再DES加密
     {
     "params": "page_index=0&page_size=15&tag=22&text=51778&type=0"
    }
     */
    
//    if (sign.length == 0) {
//        return sign;
//    }
    NSString *DESStr = [RSAEncryptor encodeDesWithString:sign];
//    NSString *DESStr = [DES3Util encryptUseDES:sign];
    
    
    return DESStr;
}
#define BUNDLE_USER_PATH [[NSBundle mainBundle] pathForResource:@"UserData" ofType:@"plist"]

- (BOOL)saveUserInfoInDocument:(NSDictionary *)dic{
    BOOL isSuccess;
    NSString *document_path= BUNDLE_USER_PATH ;
    NSURL *fileUrl = [NSURL fileURLWithPath:document_path];
    isSuccess = [dic writeToURL:fileUrl atomically:YES];
    return isSuccess;
}
/**
 URL添加国际化
 */
-(NSString*)conversionURL:(NSString*)url{
    NSArray *languages = [[NSUserDefaults standardUserDefaults] valueForKey:@"AppleLanguages"];
    NSString *currentLanguage = languages.firstObject;
    if ([currentLanguage hasPrefix:@"zh-TW"] || [currentLanguage hasPrefix:@"zh-HK"] || [currentLanguage hasPrefix:@"zh-Hant"]) {//繁体中文
        currentLanguage = @"zh_HK";
    }else if ([currentLanguage hasPrefix:@"zh-Hans"]){
        currentLanguage = @"zh_CN";
    }else if ([currentLanguage hasPrefix:@"en"]){
        currentLanguage = @"en";
    }else {
        currentLanguage = @"id";
    }
//   return [NSString stringWithFormat:@"%@%@",currentLanguage,url];
    //不用语言 懒得改
    return [NSString stringWithFormat:@"%@",url];

}

-(void)setAccessToken:(NSString *)accessToken{
    if(accessToken){
        _accessToken=accessToken;
        [_manager.requestSerializer setValue:_accessToken forHTTPHeaderField:@"token"];
//        [[NSUserDefaults standardUserDefaults] setObject:[STEncrypt AESEncryptWithSting:accessToken] forKey:@"APP_ACCESS_TOKEN"];
    }else{
        _accessToken=nil;
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"APP_ACCESS_TOKEN"];
        [_manager.requestSerializer setValue:@"" forHTTPHeaderField:@"token"];
    }
}

#pragma mark -Pravite
/**
 *  刷新请求头
 *
 *  @param criticalValue 放到加密的内容（防止篡改）
 */
-(void)_refreshHeaderWithCriticalValue:(NSDictionary*)criticalValue
{

    //修改网络请求超时时间
    NSString *timeoutIntervalKey = [criticalValue safeObjectForKey:@"timeoutInterval"];
    if (timeoutIntervalKey.length > 0) {
        NSInteger a = timeoutIntervalKey.integerValue;
        _manager.requestSerializer.timeoutInterval = timeoutIntervalKey.integerValue;
    }else{
        _manager.requestSerializer.timeoutInterval = 60;

    }
}

/**
 *  处理成功请求``
 */
-(void)_handdleSuccessWithTask:(NSURLSessionDataTask*)task
                responseObject:(id)responseObject
                       success:(nullable void (^)(NSURLSessionDataTask *task, id resultObject))success
                       failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error, id resultObject))failure{
    if (![responseObject isKindOfClass:[NSDictionary class]]) {
        failure(task,[NSError errorWithMsg:NSLocalizedString(@"服务器在开小差，请稍后再试。", nil) domain:@"Server Error" code:505],responseObject);
    }else{
        


        
        
        if (!SAFE_VALUE_FOR_KEY(responseObject, @"status")) {
            success(task,responseObject);
        } else {
//            if([SAFE_VALUE_FOR_KEY(responseObject, @"status") intValue]!=1){
            if([SAFE_VALUE_FOR_KEY(responseObject, @"status") intValue] == 0){

                //针对 后台禁用用户 所以除开初始化判断登录状态 其他也需要
                NSString *errorMsgString=SAFE_VALUE_FOR_KEY(responseObject, @"msg");
                
                if ([errorMsgString containsString:lqLocalized(@"先登录", nil)] ||[errorMsgString containsString:lqLocalized(@"未登录", nil)] ) {
                    RI.is_logined = NO;

                }else if ([errorMsgString containsString:lqLocalized(@"如非本人操作", nil)]){
                    RI.is_logined = NO;
                    
                    //发送通知 该账户在其他设备登录
//                    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_ReLorigin object:nil userInfo:@{@"msg":errorMsgString}];

                }
                failure(task,[NSError errorWithMsg:errorMsgString domain:@"Request Error" code:[SAFE_VALUE_FOR_KEY(responseObject, @"status") intValue]],responseObject);
            }else{
                success(task,responseObject);
            }
        }
        
    }
 
}

/**
 *  处理成功请求`` 区分上面  特别针对 51778这个项目里请求图片时 返回的数据不是NSDictionary
 */
-(void)_downImagehanddleSuccessWithTask:(NSURLSessionDataTask*)task
                responseObject:(id)responseObject
                       success:(nullable void (^)(NSURLSessionDataTask *task, id resultObject))success
                       failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error, id resultObject))failure{

    if (!SAFE_VALUE_FOR_KEY(responseObject, @"status")) {
        success(task,responseObject);
    } else {
//            if([SAFE_VALUE_FOR_KEY(responseObject, @"status") intValue]!=1){
        if([SAFE_VALUE_FOR_KEY(responseObject, @"status") intValue] == 0){

            //针对 后台禁用用户 所以除开初始化判断登录状态 其他也需要
            NSString *errorMsgString=SAFE_VALUE_FOR_KEY(responseObject, @"msg");
            
            if ([errorMsgString containsString:lqLocalized(@"先登录", nil)] ||[errorMsgString containsString:lqLocalized(@"未登录", nil)] ) {
                RI.is_logined = NO;

            }else if ([errorMsgString containsString:lqLocalized(@"如非本人操作", nil)]){
                RI.is_logined = NO;
                
                //发送通知 该账户在其他设备登录
//                [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_ReLorigin object:nil userInfo:@{@"msg":errorMsgString}];

            }
            failure(task,[NSError errorWithMsg:errorMsgString domain:@"Request Error" code:[SAFE_VALUE_FOR_KEY(responseObject, @"status") intValue]],responseObject);
        }else{
            success(task,responseObject);
        }
    }
    


        
        

 
}


/**
 *  处理失败请求
 */
-(void)_handdleFailureWithTask:(NSURLSessionDataTask*)task
                         error:(NSError*)error
                       failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error ,id resultObject))failure{
    NSString *errorMsgString=nil;

    NSData *errorData=SAFE_VALUE_FOR_KEY(error.userInfo, AFNetworkingOperationFailingURLResponseDataErrorKey);
    NSInteger errorCode=-99999;
    if([errorData isKindOfClass:[NSData class]]){
        id errorMsg=[NSJSONSerialization JSONObjectWithData:SAFE_VALUE_FOR_KEY(error.userInfo, AFNetworkingOperationFailingURLResponseDataErrorKey) options:NSJSONReadingAllowFragments error:&error];

        if([errorMsg isKindOfClass:[NSDictionary class]]){
            errorMsgString=SAFE_VALUE_FOR_KEY(errorMsg, @"msg");

            errorCode=[SAFE_VALUE_FOR_KEY(errorMsg, @"code") integerValue];
        }else if ([errorMsg isKindOfClass:[NSString class]]){
            errorMsgString=errorMsg;
        }
    }else{
         errorMsgString=[error localizedDescription];
//        errorMsgString=NSLocalizedString(@"服务器出走～～", nil);
        if (errorMsgString.length > 0) {
            
        NSInteger alength = [errorMsgString length];
        
//        for (int i = 0; i<alength; i++) {
            int i = 0;
            char commitChar = [errorMsgString  characterAtIndex:i];
            NSString *temp = [errorMsgString substringWithRange:NSMakeRange(i,1)];
            const char *u8Temp = [temp UTF8String];
            if (3==strlen(u8Temp)){
                
                LQLog(NSLocalizedString(@"字符串中含有中文", nil));
            }else if((commitChar>64)&&(commitChar<91)){
                if ([errorMsgString containsString:@"offline"]) {//针对 网络连接失败
                    failure(task,[NSError errorWithMsg:NSLocalizedString(@"当前网络不可用！", nil) domain:error.domain code:errorCode==-99999?error.code:errorCode],nil);
                    return;
                }else{
                    errorMsgString = NSLocalizedString(@"服务器出走中～～请稍等", nil);
                    
                }
                LQLog(NSLocalizedString(@"字符串中含有大写英文字母", nil));
            }else if((commitChar>96)&&(commitChar<123)){
                
                if ([errorMsgString isEqualToString:@"cancelled"]) {//针对 被取消的网络请求
                     failure(task,[NSError errorWithMsg:NSLocalizedString(@"任务被取消", nil) domain:error.domain code:errorCode==-99999?error.code:errorCode],nil);
                    return;
                }else{
                    errorMsgString = NSLocalizedString(@"服务器出走中～～请稍等", nil);
                    
                    LQLog(NSLocalizedString(@"字符串中含有小写英文字母", nil));
                }
                
            }else if((commitChar>47)&&(commitChar<58)){
                
                LQLog(NSLocalizedString(@"字符串中含有数字", nil));
            }else{
                errorMsgString = NSLocalizedString(@"服务器出走中～～请稍等", nil);

                LQLog(NSLocalizedString(@"字符串中含有非法字符", nil));
            }
        }
//        }
        if ([errorMsgString containsString:@"格式不正确"]) {
            errorMsgString = lqStrings(@"未能读取数据，请稍后再试");
        }

    }
    if([errorMsgString length]==0){
        errorMsgString=NSLocalizedString(@"未知错误", nil);
    }
   
    failure(task,[NSError errorWithMsg:errorMsgString domain:error.domain code:errorCode==-99999?error.code:errorCode],nil);
}

-(void)setCookie:(NSString*)key
           value:(NSString*)value{

    
    NSString *cookiestring=nil;
    for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        if ([cookie.name isEqualToString:key]) {
            continue;
        }
        if (cookiestring) {
            cookiestring=[NSString stringWithFormat:@"%@;%@=%@",cookiestring,cookie.name,cookie.value];
        }else{
            cookiestring=[NSString stringWithFormat:@"%@=%@",cookie.name,cookie.value];
        }
    }
    if (cookiestring) {
        cookiestring=[NSString stringWithFormat:@"%@;%@=%@",cookiestring,key,value];
    }else{
        cookiestring=[NSString stringWithFormat:@"%@=%@",key,value];
    }
    [_manager.requestSerializer setValue:cookiestring forHTTPHeaderField:@"Cookie"];
}


-(void)setAuthorization:(NSString *)authorization{
    [_manager.requestSerializer setValue:authorization forHTTPHeaderField:@"Authorization"];

}


- (void)logDebugInfoWithOperation:(NSURLSessionDataTask *)task error:(NSError *)error responseObject:(id)responseObject{
    //打印信息
#ifdef DEBUG
    BOOL shoulLQLogError = error ? YES : NO;

    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n==============================================================\n=                        API Response                        =\n==============================================================\n\n"];
    NSHTTPURLResponse *response = (NSHTTPURLResponse *) task.response;

    //    LQLog(@"statusCode:%ld",response.statusCode);
    [logString appendFormat:@"Status:\t%ld\t(%@)\n\n", response.statusCode, [NSHTTPURLResponse localizedStringForStatusCode:response.statusCode]];

    id reponseObject = responseObject;
    //    if (task.response) {
    //        reponseObject = [NSJSONSerialization JSONObjectWithData:operation.responseObject options:NSJSONReadingMutableContainers error:NULL];
    //    }
    [logString appendFormat:@"Content:\n%@\n\n", reponseObject ? reponseObject : @"\t\t\t\t\tN/A"];
    if (shoulLQLogError) {
        [logString appendFormat:@"Error Domain:\t\t\t\t\t\t\t%@\n", error.domain];
        [logString appendFormat:@"Error Domain Code:\t\t\t\t\t\t%ld\n", (long)error.code];
        [logString appendFormat:@"Error Localized Description:\t\t\t%@\n", error.localizedDescription];
        [logString appendFormat:@"Error Localized Failure Reason:\t\t\t%@\n", error.localizedFailureReason];
        [logString appendFormat:@"Error Localized Recovery Suggestion:\t%@\n\n", error.localizedRecoverySuggestion];
    }

    [logString appendString:@"\n---------------  Related Request Content  --------------\n"];

    [logString appendFormat:@"\n\nHTTP URL:\n\t%@", task.originalRequest.URL];
    [logString appendFormat:@"\n\nHTTP Header:\n%@", task.originalRequest.allHTTPHeaderFields ? task.originalRequest.allHTTPHeaderFields : @"\t\t\t\t\tN/A"];
    NSString *bodyString = [[NSString alloc] initWithData:task.originalRequest.HTTPBody encoding:NSUTF8StringEncoding];
//    //解密一下
//    if ([bodyString containsString:@"{\"params\""]) {
//        NSString *str = [bodyString componentsSeparatedByString:@"\"params\":\""].lastObject;
//        str = [str substringToIndex:str.length - 3];
//        bodyString = [RSAEncryptor decodeDesWithString:str];
//    }
    [logString appendFormat:@"\n\nHTTP Body:\n\t%@", bodyString ? bodyString : @"\t\t\t\t\tN/A"];

    [logString appendFormat:@"\n\n==============================================================\n=                        Response End                        =\n==============================================================\n\n\n\n"];

    LQLog(@"%@", logString);
#endif
    
}
-(void)logDebugInfoWithRequest:(NSURLRequest *)request reqeustParams:(NSDictionary *)params reqeustMethod:(NSString *)requestMethod{
    //打印信息

//#ifdef DEBUG
//    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n**************************************************************\n*                       Request Start                        *\n**************************************************************\n\n"];
//
//    [logString appendFormat:@"Method:\t\t\t\t%@\n", requestMethod];
//    [logString appendFormat:@"Params:\t\t\n%@", params];
//
//    [logString appendFormat:@"\n\nHTTP URL:\n\t%@", request.URL];
//    [logString appendFormat:@"\n\nHTTP Header:\n%@", request.allHTTPHeaderFields ? request.allHTTPHeaderFields : @"\t\t\t\t\tN/A"];
//    NSString *bodyString = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
//    [logString appendFormat:@"\n\nHTTP Body:\n\t%@", bodyString ? bodyString : @"\t\t\t\t\tN/A"];
//
//    [logString appendFormat:@"\n\n**************************************************************\n*                         Request End                        *\n**************************************************************\n\n\n\n"];
//    LQLog(@"%@", logString);
//#endif
}

@end
