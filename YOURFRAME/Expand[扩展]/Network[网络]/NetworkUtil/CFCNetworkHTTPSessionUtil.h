

#import <Foundation/Foundation.h>
@class CFCBaseReques;


#pragma mark 默认缓存时间
UIKIT_EXTERN NSInteger const CACHE_TIME_IN_SECONDS_NONE;
UIKIT_EXTERN NSInteger const CACHE_TIME_IN_SECONDS_LONG;


/** 缓存的Block */
typedef void(^HttpRequestCache)(id responseCache);
/** 请求失败的Block */
typedef void(^HttpRequestFailed)(NSError *error);
/** 请求成功的Block */
typedef void(^HttpRequestSuccess)(id responseObject);


@interface CFCNetworkHTTPSessionUtil : NSObject

/**
 *  网络管理单例
 */
+ (instancetype)sharedHTTPSessionManager;


#pragma mark -
#pragma mark 请求地址参数工具
/**
 *  封装请求地址（默认前缀）
 *
 *  @param urlString      链接后缀字符串
 *
 *  @return 返回请求链接地址
 */
+ (NSString *)makeRequestWithURLString:(NSString *)urlString;

/**
 *  封装请求地址（自定义前缀）
 *
 *  @param baseUrlString  链接前缀字符串
 *  @param urlString      链接后缀字符串
 *
 *  @return 返回请求链接地址
 */
+ (NSString *)makeRequestWithBaseURLString:(NSString *)baseUrlString URLString:(NSString *)urlString;

/**
 *  封装请求参数
 *
 *  @return 返回请求参数
 */
+ (NSMutableDictionary *)makeRequestParamerterWithKeys:(NSArray<NSString *> *)keys Values:(NSArray *)values;


#pragma mark -
#pragma mark GET请求网络方式
/**
 *  GET请求（菊花）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 */
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView;

/**
 *  GET请求（菊花、提示）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param showMessage          加载菊花提示信息
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 */
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView;

/**
 *  GET请求（菊花、提示、异常）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param showMessage          加载菊花提示信息
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 *  @param isHideErrorMessage   是否显示提示信息
 */
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView isHideErrorMessage:(BOOL)isHideErrorMessage;

#pragma mark -
/**
 *  GET请求（缓存、菊花）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @param responseCache        缓存数据
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 */
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters responseCache:(HttpRequestCache)responseCache success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView;

/**
 *  GET请求（缓存、菊花、提示）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @param responseCache        缓存数据
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param showMessage          加载菊花提示信息
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 */
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters responseCache:(HttpRequestCache)responseCache success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView;

/**
 *  GET请求（缓存、菊花、提示、异常）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @param responseCache        缓存数据
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param showMessage          加载菊花提示信息
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 *  @param isHideErrorMessage   是否显示异常信息
 */
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters responseCache:(HttpRequestCache)responseCache success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView isHideErrorMessage:(BOOL)isHideErrorMessage;

#pragma mark -
/**
 *  GET请求（缓存、菊花、缓存时间）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @param responseCache        缓存数据
 *  @param cacheTimeInSeconds   缓存时间
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 */
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters responseCache:(HttpRequestCache)responseCache cacheTimeInSeconds:(NSInteger)cacheTimeInSeconds success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView;

/**
 *  GET请求（缓存、菊花、提示、缓存时间）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @param responseCache        缓存数据
 *  @param cacheTimeInSeconds   缓存时间
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param showMessage          加载菊花提示信息
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 */
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters responseCache:(HttpRequestCache)responseCache cacheTimeInSeconds:(NSInteger)cacheTimeInSeconds success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView;

/**
 *  GET请求（缓存、菊花、提示、异常、缓存时间）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @param responseCache        缓存数据
 *  @param cacheTimeInSeconds   缓存时间
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param showMessage          加载菊花提示信息
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 *  @param isHideErrorMessage   是否显示异常信息
 */
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters responseCache:(HttpRequestCache)responseCache cacheTimeInSeconds:(NSInteger)cacheTimeInSeconds success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView isHideErrorMessage:(BOOL)isHideErrorMessage;


#pragma mark -
#pragma mark GET请求网络方式 - 自定义表格头
/**
 *  GET请求（菊花、HeaderField）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 */
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView;

/**
 *  GET请求（菊花、提示、HeaderField）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @headerField headerField    请求头自定义
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param showMessage          加载菊花提示信息
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 */
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView;

/**
 *  GET请求（菊花、提示、异常、HeaderField）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @headerField headerField    请求头自定义
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param showMessage          加载菊花提示信息
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 *  @param isHideErrorMessage   是否显示提示信息
 */
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView isHideErrorMessage:(BOOL)isHideErrorMessage;

#pragma mark -
/**
 *  GET请求（缓存、菊花、HeaderField）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @headerField headerField    请求头自定义
 *  @param responseCache        缓存数据
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 */
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField responseCache:(HttpRequestCache)responseCache success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView;

/**
 *  GET请求（缓存、菊花、提示、HeaderField）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @headerField headerField    请求头自定义
 *  @param responseCache        缓存数据
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param showMessage          加载菊花提示信息
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 */
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField responseCache:(HttpRequestCache)responseCache success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView;

/**
 *  GET请求（缓存、菊花、提示、异常、HeaderField）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @headerField headerField    请求头自定义
 *  @param responseCache        缓存数据
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param showMessage          加载菊花提示信息
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 *  @param isHideErrorMessage   是否显示异常信息
 */
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField responseCache:(HttpRequestCache)responseCache success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView isHideErrorMessage:(BOOL)isHideErrorMessage;

#pragma mark -
/**
 *  GET请求（缓存、菊花、缓存时间、HeaderField）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @headerField headerField    请求头自定义
 *  @param responseCache        缓存数据
 *  @param cacheTimeInSeconds   缓存时间
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 */
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField responseCache:(HttpRequestCache)responseCache cacheTimeInSeconds:(NSInteger)cacheTimeInSeconds success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView;

/**
 *  GET请求（缓存、菊花、提示、缓存时间、HeaderField）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @headerField headerField    请求头自定义
 *  @param responseCache        缓存数据
 *  @param cacheTimeInSeconds   缓存时间
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param showMessage          加载菊花提示信息
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 */
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField responseCache:(HttpRequestCache)responseCache cacheTimeInSeconds:(NSInteger)cacheTimeInSeconds success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView;
/**
 *  GET请求（缓存、菊花、提示、异常、缓存时间、HeaderField）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @headerField headerField    请求头自定义
 *  @param responseCache        缓存数据
 *  @param cacheTimeInSeconds   缓存时间
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param showMessage          加载菊花提示信息
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 *  @param isHideErrorMessage   是否显示异常信息
 */
+ (CFCBaseRequest *)GET:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField responseCache:(HttpRequestCache)responseCache cacheTimeInSeconds:(NSInteger)cacheTimeInSeconds success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView isHideErrorMessage:(BOOL)isHideErrorMessage;


#pragma mark -
#pragma mark POST请求网络方式
/**
 *  POST请求（菊花）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 */
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView;

/**
 *  POST请求（菊花、提示）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param showMessage          加载菊花提示信息
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 */
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView;

/**
 *  POST请求（菊花、提示、异常）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param showMessage          加载菊花提示信息
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 *  @param isHideErrorMessage   是否显示提示信息
 */
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView isHideErrorMessage:(BOOL)isHideErrorMessage;

#pragma mark -
/**
 *  POST请求（缓存、菊花）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @param responseCache        缓存数据
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 */
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters responseCache:(HttpRequestCache)responseCache success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView;

/**
 *  POST请求（缓存、菊花、提示）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @param responseCache        缓存数据
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param showMessage          加载菊花提示信息
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 */
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters responseCache:(HttpRequestCache)responseCache success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView;

/**
 *  POST请求（缓存、菊花、提示、异常）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @param responseCache        缓存数据
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param showMessage          加载菊花提示信息
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 *  @param isHideErrorMessage   是否显示异常信息
 */
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters responseCache:(HttpRequestCache)responseCache success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView isHideErrorMessage:(BOOL)isHideErrorMessage;


#pragma mark -
/**
 *  POST请求（缓存、菊花、缓存时间）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @param responseCache        缓存数据
 *  @param cacheTimeInSeconds   缓存时间
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 */
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters responseCache:(HttpRequestCache)responseCache cacheTimeInSeconds:(NSInteger)cacheTimeInSeconds success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView;

/**
 *  POST请求（缓存、菊花、提示、缓存时间）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @param responseCache        缓存数据
 *  @param cacheTimeInSeconds   缓存时间
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param showMessage          加载菊花提示信息
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 */
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters responseCache:(HttpRequestCache)responseCache cacheTimeInSeconds:(NSInteger)cacheTimeInSeconds success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView;

/**
 *  POST请求（缓存、菊花、提示、异常、缓存时间）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @param responseCache        缓存数据
 *  @param cacheTimeInSeconds   缓存时间
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param showMessage          加载菊花提示信息
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 *  @param isHideErrorMessage   是否显示异常信息
 */
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters responseCache:(HttpRequestCache)responseCache cacheTimeInSeconds:(NSInteger)cacheTimeInSeconds success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView isHideErrorMessage:(BOOL)isHideErrorMessage;



#pragma mark -
#pragma mark POST请求网络方式 - 自定义表格头
/**
 *  POST请求（菊花）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @headerField headerField    请求头自定义
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 */
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView;

/**
 *  POST请求（菊花、提示）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @headerField headerField    请求头自定义
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param showMessage          加载菊花提示信息
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 */
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView;

/**
 *  POST请求（菊花、提示、异常）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @headerField headerField    请求头自定义
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param showMessage          加载菊花提示信息
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 *  @param isHideErrorMessage   是否显示提示信息
 */
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView isHideErrorMessage:(BOOL)isHideErrorMessage;

#pragma mark -
/**
 *  POST请求（缓存、菊花）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @headerField headerField    请求头自定义
 *  @param responseCache        缓存数据
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 */
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField responseCache:(HttpRequestCache)responseCache success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView;

/**
 *  POST请求（缓存、菊花、提示）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @headerField headerField    请求头自定义
 *  @param responseCache        缓存数据
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param showMessage          加载菊花提示信息
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 */
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField responseCache:(HttpRequestCache)responseCache success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView;

/**
 *  POST请求（缓存、菊花、提示、异常）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @headerField headerField    请求头自定义
 *  @param responseCache        缓存数据
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param showMessage          加载菊花提示信息
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 *  @param isHideErrorMessage   是否显示异常信息
 */
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField responseCache:(HttpRequestCache)responseCache success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView isHideErrorMessage:(BOOL)isHideErrorMessage;


#pragma mark -
/**
 *  POST请求（缓存、菊花、缓存时间）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @headerField headerField    请求头自定义
 *  @param responseCache        缓存数据
 *  @param cacheTimeInSeconds   缓存时间
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 */
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField responseCache:(HttpRequestCache)responseCache cacheTimeInSeconds:(NSInteger)cacheTimeInSeconds success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView;

/**
 *  POST请求（缓存、菊花、提示、缓存时间）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @headerField headerField    请求头自定义
 *  @param responseCache        缓存数据
 *  @param cacheTimeInSeconds   缓存时间
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param showMessage          加载菊花提示信息
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 */
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField responseCache:(HttpRequestCache)responseCache cacheTimeInSeconds:(NSInteger)cacheTimeInSeconds success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView;
/**
 *  POST请求（缓存、菊花、提示、异常、缓存时间、HeaderField）
 *
 *  @param url                  请求地址
 *  @param parameters           请求参数
 *  @headerField headerField    请求头自定义
 *  @param responseCache        缓存数据
 *  @param cacheTimeInSeconds   缓存时间
 *  @param success              请求成功的回调
 *  @param failure              请求失败的回调
 *  @param showMessage          加载菊花提示信息
 *  @param isShowProgressHUD    是否显示加载菊花
 *  @param showProgressView     显示加载菊花容器
 *  @param isHideErrorMessage   是否显示异常信息
 */
+ (CFCBaseRequest *)POST:(NSString *)url parameters:(NSDictionary *)parameters headerField:(NSDictionary<NSString *, NSString *> *)headerField responseCache:(HttpRequestCache)responseCache cacheTimeInSeconds:(NSInteger)cacheTimeInSeconds success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure showMessage:(NSString *)showMessage showProgressHUD:(BOOL)isShowProgressHUD showProgressView:(UIView *)showProgressView isHideErrorMessage:(BOOL)isHideErrorMessage;


@end



