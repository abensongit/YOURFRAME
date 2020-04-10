
#import "CFCBaseRequest.h"
#import "YTKBaseRequest+AnimatingAccessory.h"

@implementation CFCBaseRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        _method = CFCRequestMethodPOST;
        [self initialize];
    }
    return self;
}

- (instancetype)initWithRequestUrl:(NSString *)url
{
    return [self initWithRequestUrl:url parameters:@{}];
}

- (instancetype)initWithRequestUrl:(NSString *)url parameters:(NSDictionary *)parameters
{
    return [self initWithRequestUrl:url parameters:parameters method:CFCRequestMethodPOST];
}

- (instancetype)initWithRequestUrl:(NSString *)url parameters:(NSDictionary *)parameters method:(CFCRequestMethod)method
{
  return [self initWithRequestUrl:url parameters:parameters method:method headerField:nil];
}

- (instancetype)initWithRequestUrl:(NSString *)url parameters:(NSDictionary *)parameters method:(CFCRequestMethod)method headerField:(NSDictionary<NSString *, NSString *> *)headerField
{
  self = [self init];
  if (self) {
    _url = url;
    _parameters = parameters;
    _method = method;
    _headerField = headerField;
  }
  return self;
}

- (void)initialize
{
    _timeout = 30.0f; // 请求超时时间
    _cacheVersion = 0; // 缓存版本号
    _cacheTimeInSeconds = 0; // 缓存保存时间
    _isHideErrorMessage = NO;
    _headerField = nil;
    self.animatingText = nil;
}

#pragma mark - 请求的URL
- (NSString *)requestUrl
{
    return _url;
}

#pragma mark - 请求入参
- (nullable id)requestArgument
{
    return _parameters;
}

#pragma mark - 请求方式，默认为POST请求
- (YTKRequestMethod)requestMethod
{
    switch (_method) {
        case CFCRequestMethodGET: {
            return YTKRequestMethodGET;
        }
        case CFCRequestMethodPOST: {
            return YTKRequestMethodPOST;
        }
        case CFCRequestMethodHEAD: {
            return YTKRequestMethodHEAD;
        }
        case CFCRequestMethodPUT: {
            return YTKRequestMethodPUT;
        }
        case CFCRequestMethodDELETE: {
            return YTKRequestMethodDELETE;
        }
        case CFCRequestMethodPATCH: {
            return YTKRequestMethodPATCH;
        }
        default: {
            return YTKRequestMethodPOST;
        }
    }
}

#pragma mark - 请求寄存器，默认为HTTP
- (YTKRequestSerializerType)requestSerializerType
{
    return YTKRequestSerializerTypeHTTP;
}

#pragma mark - 响应寄存器，默认JSON响应数据 详见 `responseObject`.
- (YTKResponseSerializerType)responseSerializerType
{
    return YTKResponseSerializerTypeJSON;
}

#pragma mark - 缓存的版本号
- (long long)cacheVersion
{
    return _cacheVersion;
}

#pragma mark - 缓存保存时间
- (NSInteger)cacheTimeInSeconds
{
    return _cacheTimeInSeconds;
}

#pragma mark - 请求超时时间
- (NSTimeInterval)requestTimeoutInterval
{
    return _timeout;
}

#pragma mark - 请求成功回调之前的处理 - 保存缓存操作
- (void)requestCompletePreprocessor
{
    // 回调之前的操作->保存缓存操作
    [super requestCompletePreprocessor];
    
    // JSON 转 Model
}

#pragma mark - 请求成功回调之前的处理 - 自定义操作
- (void)requestCompleteFilter
{
    // 回调之前的操作->真正回调前的操作
    [super requestCompleteFilter];
    
}

#pragma mark - 请求失败回调之前的处理 - 自定义操作
- (void)requestFailedPreprocessor
{
    // 注意：子类继承，必须调用 [super requestFailedPreprocessor];
    [super requestFailedPreprocessor];
    
    // 可以在此方法内处理 token 失效的情况，所有http请求统一走此方法，即会统一调用。
    // 如果部分服务端的失败以成功的方式返回给客户端，那么可以重写下面方法，不过这个时候如果程序中有用到代理的话代理也要重写
    // - (void)setCompletionBlockWithSuccess:(nullable YTKRequestCompletionBlock)success
    //                               failure:(nullable YTKRequestCompletionBlock)failure
    
    NSError * error = self.error;
    if ([error.domain isEqualToString:YTKRequestValidationErrorDomain]) {
        // 猿题库处理过的错误
        
    } else {
        // 系统级别的domain错误，无网络等[NSURLErrorDomain]，根据error的code去定义显示的信息，保证显示的内容可以便捷的控制
    }
}

#pragma mark - 请求失败回调之前的处理 - 自定义操作
- (void)requestFailedFilter
{
    [super requestFailedFilter];
    
    if (![self isHideErrorMessage]) {
        UIWindow * window = [[UIApplication sharedApplication] keyWindow];
        UIViewController * controller = [self findBestViewController:window.rootViewController];
        [CFCProgressAlertUtil showFailWithMessage:self.error.localizedDescription toView:controller.view];
    }
}

#pragma mark - 自定义请求的 HeaderField
- (NSDictionary<NSString *, NSString *> *)requestHeaderFieldValueDictionary
{
    return self.headerField;
}

#pragma mark - Private Method
- (UIViewController*) findBestViewController:(UIViewController*)viewController
{
    if (viewController.presentedViewController) {
        // Return Presented View Controller
        return [self findBestViewController:viewController.presentedViewController];
    } else if ([viewController isKindOfClass:[UISplitViewController class]]) {
        // Return Right Hand Side
        UISplitViewController *splitViewController = (UISplitViewController*)viewController;
        if (splitViewController.viewControllers.count > 0) {
            return [self findBestViewController:splitViewController.viewControllers.lastObject];
        } else {
            return viewController;
        }
    } else if ([viewController isKindOfClass:[UINavigationController class]]) {
        // Return Top View
        UINavigationController *navigationController = (UINavigationController*)viewController;
        if (navigationController.viewControllers.count > 0) {
            return [self findBestViewController:navigationController.topViewController];
        } else {
            return viewController;
        }
    } else if ([viewController isKindOfClass:[UITabBarController class]]) {
        // Return Visible View
        UITabBarController* tabBarController = (UITabBarController*) viewController;
        if (tabBarController.viewControllers.count > 0) {
            return [self findBestViewController:tabBarController.selectedViewController];
        } else {
            return viewController;
        }
    } else {
        // Unknown View Controller type, Return Last Child View Controller
        return viewController;
    }
}

@end

