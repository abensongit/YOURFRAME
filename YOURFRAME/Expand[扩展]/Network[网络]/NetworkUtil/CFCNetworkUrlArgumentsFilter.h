//
// 说明：YTKUrlFilterProtocol 接口用于实现对网络请求 URL 或参数的重写，例如可以统一为网络请求加上一些参数，或者修改一些路径。
//      通过以上 YTKUrlArgumentsFilter 类，我们就可以用以下代码方便地为网络请求增加统一的参数，如增加当前客户端的版本号：
//
//      NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//      YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
//      YTKUrlArgumentsFilter *urlFilter = [YTKUrlArgumentsFilter filterWithArguments:@{ @"version" : version }];
//      [config addUrlFilter:urlFilter];


#import <Foundation/Foundation.h>

#if __has_include(<YTKNetwork/YTKNetwork.h>)
#import <YTKNetwork/YTKNetwork.h>
#else
#import "YTKNetwork.h"
#endif

@interface CFCNetworkUrlArgumentsFilter : NSObject <YTKUrlFilterProtocol>

+ (instancetype)filterWithArguments:(NSDictionary<NSString *, NSString *> *)arguments;

@end
