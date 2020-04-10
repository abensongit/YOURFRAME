

#import <Foundation/Foundation.h>

#define CFC_REQUEST_KEY_DATA          @"data"
#define CFC_REQUEST_KEY_MESS          @"message"
#define CFC_REQUEST_KEY_STATUS        @"status"

#define CFC_TERMINAL_IOS              @"1"
#define CFC_TERMINAL_ANDROID          @"2"
#define CFC_PARAMS_NULL               @""
#define CFC_PARAMS_ZERO               @"0"
#define CFC_PARAMS_MAKE(PARAM)        [CFCNetworkParamsUtil makeRequestParameters:PARAM]
#define CFC_PARAMS_NONNULL(PARAM)     [CFCNetworkParamsUtil makeStringWithNoWhitespaceAndNewline:PARAM]

@interface CFCNetworkParamsUtil : NSObject

#pragma mark -
#pragma mark 参数空白字符串处理
+ (NSString *)makeStringWithNoWhitespaceAndNewline:(NSString *)value;
#pragma mark 公共请求参数的处理
+ (NSMutableDictionary *)makeRequestParameters:(NSMutableDictionary *)params;

#pragma mark -
#pragma mark 首页 - 获取主页数据
+ (NSMutableDictionary *)getHomeMainRefreshParameters;

#pragma mark 首页 - 获取最新开奖
+ (NSMutableDictionary *)getLastestCurrentDrawParameters;

#pragma mark 首页 - 开奖记录
+ (NSMutableDictionary *)getDrawResultRecordParameters:(NSString *)year;


@end

