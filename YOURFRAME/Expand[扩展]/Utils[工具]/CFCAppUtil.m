
#import "CFCAppUtil.h"

@implementation CFCAppUtil


#pragma mark -
#pragma mark 初始化离散网络架构配置
+ (void)applicationNetworkManagerSetting
{
    // 配置网络
    @try {
        // 设置基础域名
        YTKNetworkConfig *networkConfig = [YTKNetworkConfig sharedConfig];
        networkConfig.baseUrl = URL_API_BASE;
        networkConfig.debugLogEnabled = YES;
        
        // 设置可接受的数据类型
        YTKNetworkAgent *networkAgent = [YTKNetworkAgent sharedAgent];
        NSSet *acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                         @"text/json",
                                         @"text/javascript",
                                         @"text/plain",
                                         @"text/html",
                                         @"text/css",
                                         @"image/*",
                                         @"application/x-javascript",
                                         @"keep-alive",
                                         nil];
        NSString *keypath = @"jsonResponseSerializer.acceptableContentTypes";
        [networkAgent setValue:acceptableContentTypes forKeyPath:keypath];
    } @catch (NSException *exception) {
        CFCLog(@"%@", exception);
    } @finally {
        CFCLog(@"网络模块->初始化网络配置");
    }
}


@end
