

#import "CFCNetworkHTTPSessionUtil.h"
#import "YTKBaseRequest+AnimatingAccessory.h"
#import "CFCBaseRequest.h"


#pragma mark 默认缓存时间
NSInteger const CACHE_TIME_IN_SECONDS_NONE = 0.0;
NSInteger const CACHE_TIME_IN_SECONDS_LONG = 60*60*24*365;


@interface CFCNetworkHTTPSessionUtil ()

@end

@implementation CFCNetworkHTTPSessionUtil


#pragma mark -
#pragma mark 网络管理单例
+ (instancetype)sharedHTTPSessionManager
{
    static CFCNetworkHTTPSessionUtil *_singetonInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if (nil == _singetonInstance) {
            // 网络请求管理单例
            _singetonInstance = [[super allocWithZone:NULL] init];
        }
    });
    return _singetonInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [[self class] sharedHTTPSessionManager];
}

- (id)copyWithZone:(struct _NSZone *)zone
{
    return [[self class] sharedHTTPSessionManager];
}


#pragma mark -
#pragma mark 封装请求地址（默认前缀）
+ (NSString *)makeRequestWithURLString:(NSString *)urlString
{
    return [CFCNetworkHTTPSessionUtil makeRequestWithBaseURLString:URL_API_BASE URLString:urlString];
}

#pragma mark 封装请求地址（自定义前缀）
+ (NSString *)makeRequestWithBaseURLString:(NSString *)baseUrlString URLString:(NSString *)urlString
{
    return [NSString stringWithFormat:@"%@%@", [CFCSysUtil stringByTrimmingWhitespaceAndNewline:baseUrlString],
            [CFCSysUtil stringByTrimmingWhitespaceAndNewline:urlString]];
}

#pragma mark 封装请求参数
+ (NSMutableDictionary *)makeRequestParamerterWithKeys:(NSArray<NSString *> *)keys Values:(NSArray *)values
{
    NSMutableDictionary *paramerter = [NSMutableDictionary dictionary];
    [keys enumerateObjectsUsingBlock:^(id  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        [paramerter setObject:values[idx] forKey:key];
    }];
    return paramerter;
}


#pragma mark -
#pragma mark GET请求（菊花）
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView
{
    return [[self class] GET:url parameters:parameters success:success failure:failure showMessage:nil showProgressHUD:isShowProgressHUD showProgressView:showProgressView];
}

#pragma mark GET请求（菊花、提示）
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView
{
    return [[self class] GET:url parameters:parameters success:success failure:failure showMessage:showMessage showProgressHUD:isShowProgressHUD showProgressView:showProgressView isHideErrorMessage:NO];
}

#pragma mark GET请求（菊花、提示、异常）
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView isHideErrorMessage:(BOOL)isHideErrorMessage
{
    return [[self class] GET:url parameters:parameters responseCache:nil success:success failure:failure showMessage:showMessage showProgressHUD:isShowProgressHUD showProgressView:showProgressView isHideErrorMessage:isHideErrorMessage];
}


#pragma mark -
#pragma mark GET请求（缓存、菊花）
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters responseCache:(HttpRequestCache)responseCache success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView
{
    return [[self class] GET:url parameters:parameters responseCache:responseCache success:success failure:failure showMessage:nil showProgressHUD:isShowProgressHUD showProgressView:showProgressView];
}

#pragma mark GET请求（缓存、菊花、提示）
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters responseCache:(HttpRequestCache)responseCache success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView
{
    return [[self class] GET:url parameters:parameters responseCache:responseCache success:success failure:failure showMessage:showMessage showProgressHUD:isShowProgressHUD showProgressView:showProgressView isHideErrorMessage:NO];
}

#pragma mark GET请求（缓存、菊花、提示、异常）
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters responseCache:(HttpRequestCache)responseCache success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView isHideErrorMessage:(BOOL)isHideErrorMessage
{
    return [[self class] GET:url parameters:parameters responseCache:responseCache cacheTimeInSeconds:CACHE_TIME_IN_SECONDS_NONE success:success failure:failure showMessage:showMessage showProgressHUD:isShowProgressHUD showProgressView:showProgressView isHideErrorMessage:isHideErrorMessage];
}


#pragma mark -
#pragma mark GET请求（缓存、菊花、缓存时间）
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters responseCache:(HttpRequestCache)responseCache cacheTimeInSeconds:(NSInteger)cacheTimeInSeconds success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView
{
    return [[self class] GET:url parameters:parameters responseCache:responseCache cacheTimeInSeconds:cacheTimeInSeconds success:success failure:failure showMessage:nil showProgressHUD:isShowProgressHUD showProgressView:showProgressView];
}

#pragma mark GET请求（缓存、菊花、提示、缓存时间）
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters responseCache:(HttpRequestCache)responseCache cacheTimeInSeconds:(NSInteger)cacheTimeInSeconds success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView
{
    return [[self class] GET:url parameters:parameters responseCache:responseCache cacheTimeInSeconds:cacheTimeInSeconds success:success failure:failure showMessage:showMessage showProgressHUD:isShowProgressHUD showProgressView:showProgressView isHideErrorMessage:NO];
}

#pragma mark GET请求（缓存、菊花、提示、异常、缓存时间）
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters responseCache:(HttpRequestCache)responseCache cacheTimeInSeconds:(NSInteger)cacheTimeInSeconds success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView isHideErrorMessage:(BOOL)isHideErrorMessage
{
  return [[self class] GET:url parameters:parameters headerField:nil responseCache:responseCache cacheTimeInSeconds:cacheTimeInSeconds success:success failure:failure showMessage:showMessage showProgressHUD:isShowProgressHUD showProgressView:showProgressView isHideErrorMessage:isHideErrorMessage];
}


#pragma mark -
#pragma mark GET请求（菊花、HeaderField）
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView
{
  return [[self class] GET:url parameters:parameters headerField:headerField success:success failure:failure showMessage:nil showProgressHUD:isShowProgressHUD showProgressView:showProgressView];
}

#pragma mark GET请求（菊花、提示、HeaderField）
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView
{
  return [[self class] GET:url parameters:parameters headerField:headerField success:success failure:failure showMessage:showMessage showProgressHUD:isShowProgressHUD showProgressView:showProgressView isHideErrorMessage:NO];
}

#pragma mark GET请求（菊花、提示、异常、HeaderField）
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView isHideErrorMessage:(BOOL)isHideErrorMessage
{
  return [[self class] GET:url parameters:parameters headerField:headerField responseCache:nil success:success failure:failure showMessage:showMessage showProgressHUD:isShowProgressHUD showProgressView:showProgressView isHideErrorMessage:isHideErrorMessage];
}


#pragma mark -
#pragma mark GET请求（缓存、菊花、HeaderField）
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField responseCache:(HttpRequestCache)responseCache success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView
{
  return [[self class] GET:url parameters:parameters headerField:headerField responseCache:responseCache success:success failure:failure showMessage:nil showProgressHUD:isShowProgressHUD showProgressView:showProgressView];
}

#pragma mark GET请求（缓存、菊花、提示、HeaderField）
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField responseCache:(HttpRequestCache)responseCache success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView
{
  return [[self class] GET:url parameters:parameters headerField:headerField responseCache:responseCache success:success failure:failure showMessage:showMessage showProgressHUD:isShowProgressHUD showProgressView:showProgressView isHideErrorMessage:NO];
}

#pragma mark GET请求（缓存、菊花、提示、异常、HeaderField）
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField responseCache:(HttpRequestCache)responseCache success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView isHideErrorMessage:(BOOL)isHideErrorMessage
{
  return [[self class] GET:url parameters:parameters headerField:headerField responseCache:responseCache cacheTimeInSeconds:CACHE_TIME_IN_SECONDS_NONE success:success failure:failure showMessage:showMessage showProgressHUD:isShowProgressHUD showProgressView:showProgressView isHideErrorMessage:isHideErrorMessage];
}


#pragma mark -
#pragma mark GET请求（缓存、菊花、缓存时间、HeaderField）
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField responseCache:(HttpRequestCache)responseCache cacheTimeInSeconds:(NSInteger)cacheTimeInSeconds success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView
{
  return [[self class] GET:url parameters:parameters headerField:headerField responseCache:responseCache cacheTimeInSeconds:cacheTimeInSeconds success:success failure:failure showMessage:nil showProgressHUD:isShowProgressHUD showProgressView:showProgressView];
}

#pragma mark GET请求（缓存、菊花、提示、缓存时间、HeaderField）
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField responseCache:(HttpRequestCache)responseCache cacheTimeInSeconds:(NSInteger)cacheTimeInSeconds success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView
{
  return [[self class] GET:url parameters:parameters headerField:headerField responseCache:responseCache cacheTimeInSeconds:cacheTimeInSeconds success:success failure:failure showMessage:showMessage showProgressHUD:isShowProgressHUD showProgressView:showProgressView isHideErrorMessage:NO];
}

#pragma mark GET请求（缓存、菊花、提示、异常、缓存时间、HeaderField）
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField responseCache:(HttpRequestCache)responseCache cacheTimeInSeconds:(NSInteger)cacheTimeInSeconds success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView isHideErrorMessage:(BOOL)isHideErrorMessage
{
  return [[self class] requestWithUrl:url parameters:parameters method:CFCRequestMethodGET headerField:headerField responseCache:responseCache cacheTimeInSeconds:cacheTimeInSeconds success:success failure:failure showMessage:showMessage showProgressHUD:isShowProgressHUD showProgressView:showProgressView isHideErrorMessage:isHideErrorMessage];
}


#pragma mark -
#pragma mark POST请求（菊花）
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView
{
    return [[self class] POST:url parameters:parameters success:success failure:failure showMessage:nil showProgressHUD:isShowProgressHUD showProgressView:showProgressView];
}

#pragma mark POST请求（菊花、提示）
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView
{
    return [[self class] POST:url parameters:parameters success:success failure:failure showMessage:showMessage showProgressHUD:isShowProgressHUD showProgressView:showProgressView isHideErrorMessage:NO];
}

#pragma mark POST请求（菊花、提示、异常）
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView isHideErrorMessage:(BOOL)isHideErrorMessage
{
    return [[self class] POST:url parameters:parameters responseCache:nil success:success failure:failure showMessage:showMessage showProgressHUD:isShowProgressHUD showProgressView:showProgressView isHideErrorMessage:isHideErrorMessage];
}


#pragma mark -
#pragma mark POST请求（缓存、菊花）
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters responseCache:(HttpRequestCache)responseCache success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView
{
    return [[self class] POST:url parameters:parameters responseCache:responseCache success:success failure:failure showMessage:nil showProgressHUD:isShowProgressHUD showProgressView:showProgressView];
}

#pragma mark POST请求（缓存、菊花、提示）
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters responseCache:(HttpRequestCache)responseCache success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView
{
    return [[self class] POST:url parameters:parameters responseCache:responseCache success:success failure:failure showMessage:showMessage showProgressHUD:isShowProgressHUD showProgressView:showProgressView isHideErrorMessage:NO];
}

#pragma mark POST请求（缓存、菊花、提示、异常）
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters responseCache:(HttpRequestCache)responseCache success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView isHideErrorMessage:(BOOL)isHideErrorMessage
{
    return [[self class] POST:url parameters:parameters responseCache:responseCache cacheTimeInSeconds:CACHE_TIME_IN_SECONDS_NONE success:success failure:failure showMessage:showMessage showProgressHUD:isShowProgressHUD showProgressView:showProgressView isHideErrorMessage:isHideErrorMessage];
}


#pragma mark -
#pragma mark POST请求（缓存、菊花、缓存时间）
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters responseCache:(HttpRequestCache)responseCache cacheTimeInSeconds:(NSInteger)cacheTimeInSeconds success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView
{
     return [[self class] POST:url parameters:parameters responseCache:responseCache cacheTimeInSeconds:cacheTimeInSeconds success:success failure:failure showMessage:nil showProgressHUD:isShowProgressHUD showProgressView:showProgressView];
}

#pragma mark POST请求（缓存、菊花、提示、缓存时间）
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters responseCache:(HttpRequestCache)responseCache cacheTimeInSeconds:(NSInteger)cacheTimeInSeconds success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView
{
    return [[self class] POST:url parameters:parameters responseCache:responseCache cacheTimeInSeconds:cacheTimeInSeconds success:success failure:failure showMessage:showMessage showProgressHUD:isShowProgressHUD showProgressView:showProgressView isHideErrorMessage:NO];
}

#pragma mark POST请求（缓存、菊花、提示、异常、缓存时间）
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters responseCache:(HttpRequestCache)responseCache cacheTimeInSeconds:(NSInteger)cacheTimeInSeconds success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView isHideErrorMessage:(BOOL)isHideErrorMessage
{
  return [[self class] POST:url parameters:parameters headerField:nil responseCache:responseCache cacheTimeInSeconds:cacheTimeInSeconds success:success failure:failure showMessage:showMessage showProgressHUD:isShowProgressHUD showProgressView:showProgressView isHideErrorMessage:isHideErrorMessage];
}



#pragma mark -
#pragma mark POST请求（菊花、HeaderField）
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView
{
  return [[self class] POST:url parameters:parameters headerField:headerField success:success failure:failure showMessage:nil showProgressHUD:isShowProgressHUD showProgressView:showProgressView];
}

#pragma mark POST请求（菊花、提示、HeaderField）
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView
{
  return [[self class] POST:url parameters:parameters headerField:headerField success:success failure:failure showMessage:showMessage showProgressHUD:isShowProgressHUD showProgressView:showProgressView isHideErrorMessage:NO];
}

#pragma mark POST请求（菊花、提示、异常、HeaderField）
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView isHideErrorMessage:(BOOL)isHideErrorMessage
{
  return [[self class] POST:url parameters:parameters headerField:headerField responseCache:nil success:success failure:failure showMessage:showMessage showProgressHUD:isShowProgressHUD showProgressView:showProgressView isHideErrorMessage:isHideErrorMessage];
}


#pragma mark -
#pragma mark POST请求（缓存、菊花、HeaderField）
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField responseCache:(HttpRequestCache)responseCache success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView
{
  return [[self class] POST:url parameters:parameters headerField:headerField responseCache:responseCache success:success failure:failure showMessage:nil showProgressHUD:isShowProgressHUD showProgressView:showProgressView];
}

#pragma mark POST请求（缓存、菊花、提示、HeaderField）
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField responseCache:(HttpRequestCache)responseCache success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView
{
  return [[self class] POST:url parameters:parameters headerField:headerField responseCache:responseCache success:success failure:failure showMessage:showMessage showProgressHUD:isShowProgressHUD showProgressView:showProgressView isHideErrorMessage:NO];
}

#pragma mark POST请求（缓存、菊花、提示、异常、HeaderField）
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField responseCache:(HttpRequestCache)responseCache success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView isHideErrorMessage:(BOOL)isHideErrorMessage
{
  return [[self class] POST:url parameters:parameters headerField:headerField responseCache:responseCache cacheTimeInSeconds:CACHE_TIME_IN_SECONDS_NONE success:success failure:failure showMessage:showMessage showProgressHUD:isShowProgressHUD showProgressView:showProgressView isHideErrorMessage:isHideErrorMessage];
}


#pragma mark -
#pragma mark POST请求（缓存、菊花、缓存时间、HeaderField）
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField responseCache:(HttpRequestCache)responseCache cacheTimeInSeconds:(NSInteger)cacheTimeInSeconds success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView
{
  return [[self class] POST:url parameters:parameters headerField:headerField responseCache:responseCache cacheTimeInSeconds:cacheTimeInSeconds success:success failure:failure showMessage:nil showProgressHUD:isShowProgressHUD showProgressView:showProgressView];
}

#pragma mark POST请求（缓存、菊花、提示、缓存时间、HeaderField）
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField responseCache:(HttpRequestCache)responseCache cacheTimeInSeconds:(NSInteger)cacheTimeInSeconds success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView
{
  return [[self class] POST:url parameters:parameters headerField:headerField responseCache:responseCache cacheTimeInSeconds:cacheTimeInSeconds success:success failure:failure showMessage:showMessage showProgressHUD:isShowProgressHUD showProgressView:showProgressView isHideErrorMessage:NO];
}

#pragma mark POST请求（缓存、菊花、提示、异常、缓存时间、HeaderField）
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField responseCache:(HttpRequestCache)responseCache cacheTimeInSeconds:(NSInteger)cacheTimeInSeconds success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView isHideErrorMessage:(BOOL)isHideErrorMessage
{
  return [[self class] requestWithUrl:url parameters:parameters method:CFCRequestMethodPOST headerField:headerField responseCache:responseCache cacheTimeInSeconds:cacheTimeInSeconds success:success failure:failure showMessage:showMessage showProgressHUD:isShowProgressHUD showProgressView:showProgressView isHideErrorMessage:isHideErrorMessage];
}


#pragma mark -
#pragma mark 公共请求方法
+ (CFCBaseRequest *)requestWithUrl:(NSString *)url parameters:(NSDictionary *)parameters method:(CFCRequestMethod)method headerField:(NSDictionary<NSString *, NSString *> *)headerField responseCache:(HttpRequestCache)responseCache cacheTimeInSeconds:(NSInteger)cacheTimeInSeconds success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView isHideErrorMessage:(BOOL)isHideErrorMessage
{
    // 设置联网指示器的可见性
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // 网络请求类
    CFCBaseRequest *requestSession = [[CFCBaseRequest alloc] init];
    requestSession.url = url;
    requestSession.parameters = parameters;
    requestSession.method = method;
    requestSession.isHideErrorMessage = isHideErrorMessage;
    requestSession.cacheTimeInSeconds = cacheTimeInSeconds;
    requestSession.animatingView = isShowProgressHUD ? ( showMessage.length > 0 ? showProgressView : nil ) : nil;
    requestSession.animatingText = isShowProgressHUD ? ( showMessage.length > 0 ? showMessage : @"" ) : nil;
    requestSession.headerField = headerField.count > 0 ? headerField : nil;
    
    // 获取缓存数据
    __block NSString *keyOfCache = [url urlStringByAppendParameters:parameters];
    id responseJSONObject = [CFCNetworkingCacheUtil getResponseCacheForKey:keyOfCache];
    if (responseCache && [requestSession loadCacheWithError:nil]) {
        responseCache ? responseCache(requestSession.responseJSONObject) : nil;
    } else if (responseCache && responseJSONObject) {
        responseCache(responseJSONObject);
    }
    
    // 请求最新数据
    [requestSession startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        // 设置联网指示器的可见性
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        // 请求数据成功后操作处理
        success ? success(request.responseJSONObject) : nil;
        
        // 缓存数据
        [CFCNetworkingCacheUtil saveResponseCache:request.responseJSONObject forKey:[url urlStringByAppendParameters:parameters]];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        // 设置联网指示器的可见性
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        // 请求数据失败后操作处理
        failure ? failure(request.error): nil;
        
        CFCLog(@"ERROR = [ %@ ]", request.error);
        
    }];
  
    return requestSession;
}


@end

