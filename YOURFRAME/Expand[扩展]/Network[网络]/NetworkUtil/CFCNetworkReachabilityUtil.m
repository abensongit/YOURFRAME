
#import "CFCNetworkReachabilityUtil.h"

#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworkReachabilityManager.h>
#else
#import "AFNetworkReachabilityManager.h"
#endif

#pragma mark 监听网络状态变动的广播通知频段
NSString * const CFC_NOTIFICATION_NETWORKING_REACHABILITY_STATUS_FREQUENCY = @"CFCNetworkReachabilityUtilNetWorkingStatusFrequency";
#pragma mark 监听网络状态变动的广播通知内容 - 字典KEY
NSString * const CFC_NOTIFICATION_NETWORKING_REACHABILITY_STATUS_KEY = @"CFCNetworkReachabilityUtilNetWorkingStatusKey";


@interface CFCNetworkReachabilityUtil ()

@property (nonatomic, strong) AFNetworkReachabilityManager *manager;

@property (nonatomic, assign) CFCNetworkStatus networktatus;

@end


@implementation CFCNetworkReachabilityUtil

#pragma mark - 网络管理单例
+ (void)load
{
    // 开启网络监听
    [[self class] currentNetworktatus];
}

#pragma mark - 网络管理单例
+ (instancetype)sharedNetworkUtilsWithCurrentReachabilityStatusBlock:(CFCCurrentReachabilityStatusBlock)currentReachabilityStatusBlock
{
    static CFCNetworkReachabilityUtil *_singetonInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if (nil == _singetonInstance) {
            // 网络请求管理单例
            _singetonInstance = [[super allocWithZone:NULL] init];
            // 网络请求Session
            _singetonInstance.manager = [AFNetworkReachabilityManager sharedManager];
            [_singetonInstance.manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
                switch (status) {
                    case AFNetworkReachabilityStatusUnknown: {
                        // 打印日志
                        CFCLog(@"未识别的网络");
                        !currentReachabilityStatusBlock?:currentReachabilityStatusBlock(CFCNetworkStatusUnknown);
                        // 网络状态
                        _singetonInstance.networktatus = CFCNetworkStatusUnknown;
                        // 发送通知
                        NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter];
                        [notificationCenter postNotificationName:CFC_NOTIFICATION_NETWORKING_REACHABILITY_STATUS_FREQUENCY
                                                          object:self
                                                        userInfo:@{CFC_NOTIFICATION_NETWORKING_REACHABILITY_STATUS_KEY:@(CFCNetworkStatusUnknown)}];
                        break;
                    }
                    case AFNetworkReachabilityStatusNotReachable: {
                        // 打印日志
                        CFCLog(@"不可达的网络(未连接)");
                        !currentReachabilityStatusBlock?:currentReachabilityStatusBlock(CFCNetworkStatusNotReachable);
                        // 网络状态
                        _singetonInstance.networktatus = CFCNetworkStatusNotReachable;
                        // 发送通知
                        NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter];
                        [notificationCenter postNotificationName:CFC_NOTIFICATION_NETWORKING_REACHABILITY_STATUS_FREQUENCY
                                                          object:self
                                                        userInfo:@{CFC_NOTIFICATION_NETWORKING_REACHABILITY_STATUS_KEY:@(CFCNetworkStatusNotReachable)}];
                        break;
                    }
                    case AFNetworkReachabilityStatusReachableViaWWAN: {
                        // 打印日志
                        CFCLog(@"2G,3G,4G...的网络");
                        !currentReachabilityStatusBlock?:currentReachabilityStatusBlock(CFCNetworkStatusReachableViaWWAN);
                        // 网络状态
                        _singetonInstance.networktatus = CFCNetworkStatusReachableViaWWAN;
                        // 发送通知
                        NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter];
                        [notificationCenter postNotificationName:CFC_NOTIFICATION_NETWORKING_REACHABILITY_STATUS_FREQUENCY
                                                          object:self
                                                        userInfo:@{CFC_NOTIFICATION_NETWORKING_REACHABILITY_STATUS_KEY:@(CFCNetworkStatusReachableViaWWAN)}];
                        break;
                    }
                    case AFNetworkReachabilityStatusReachableViaWiFi: {
                        // 打印日志
                        CFCLog(@"WIFI的网络");
                        !currentReachabilityStatusBlock?:currentReachabilityStatusBlock(CFCNetworkStatusReachableViaWiFi);
                        // 网络状态
                        _singetonInstance.networktatus = CFCNetworkStatusReachableViaWiFi;
                        // 发送通知
                        NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter];
                        [notificationCenter postNotificationName:CFC_NOTIFICATION_NETWORKING_REACHABILITY_STATUS_FREQUENCY
                                                          object:self
                                                        userInfo:@{CFC_NOTIFICATION_NETWORKING_REACHABILITY_STATUS_KEY:@(CFCNetworkStatusReachableViaWiFi)}];
                        break;
                    }
                    default: {
                        break;
                    }
                }
            }];
            [_singetonInstance.manager startMonitoring];
        }
    });
    return _singetonInstance;
}


+ (CFCNetworkStatus)currentNetworktatus
{
    return [CFCNetworkReachabilityUtil sharedNetworkUtilsWithCurrentReachabilityStatusBlock:nil].networktatus;
}

+ (BOOL)isNetworkAvailable
{
    switch ([CFCNetworkReachabilityUtil currentNetworktatus]) {
        case CFCNetworkStatusUnknown:
        case CFCNetworkStatusNotReachable: {
            return NO;
        }
        case CFCNetworkStatusReachableViaWWAN:
        case CFCNetworkStatusReachableViaWiFi: {
            return YES;
        }
    }
    return NO;
}


@end



