
#if __has_include(<YTKNetwork/YTKNetwork.h>)
#import <YTKNetwork/YTKRequest.h>
#else
#import "YTKRequest.h"
#endif

// 请求方式
typedef NS_ENUM(NSInteger, CFCRequestMethod) {
    CFCRequestMethodGET = 0,
    CFCRequestMethodPOST,
    CFCRequestMethodHEAD,
    CFCRequestMethodPUT,
    CFCRequestMethodDELETE,
    CFCRequestMethodPATCH,
};

@interface CFCBaseRequest : YTKRequest

@property (nonatomic, copy) NSString *url; // 请求地址
@property (nonatomic, copy) NSDictionary *parameters; // 请求参数
@property (nonatomic, assign) CFCRequestMethod method; // 请求类型
@property (nonatomic, assign) BOOL isHideErrorMessage; // 提示信息
@property (nonatomic, assign) NSTimeInterval timeout; // 请求超时
@property (nonatomic, assign) long long cacheVersion; // 缓存版本号
@property (nonatomic, assign) NSInteger cacheTimeInSeconds; // 缓存保存时间
@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *headerField; // 自定义请求头

- (instancetype)initWithRequestUrl:(NSString *)url;
- (instancetype)initWithRequestUrl:(NSString *)url parameters:(NSDictionary *)parameters;
- (instancetype)initWithRequestUrl:(NSString *)url parameters:(NSDictionary *)parameters method:(CFCRequestMethod)method;
- (instancetype)initWithRequestUrl:(NSString *)url parameters:(NSDictionary *)parameters method:(CFCRequestMethod)method headerField:(NSDictionary<NSString *, NSString *> *)headerField;

@end
