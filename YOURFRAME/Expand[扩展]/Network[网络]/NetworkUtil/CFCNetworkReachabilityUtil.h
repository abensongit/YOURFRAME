

#import <UIKit/UIKit.h>


#pragma mark -
#pragma mark 网络可达状态
typedef NS_ENUM(NSUInteger, CFCNetworkStatus) {
    /** 未知网络 */
    CFCNetworkStatusUnknown,
    /** 不可达的网络(未连接) */
    CFCNetworkStatusNotReachable,
    /** 手机网络2G,3G,4G */
    CFCNetworkStatusReachableViaWWAN,
    /** WIFI网络 */
    CFCNetworkStatusReachableViaWiFi
};


#pragma mark -
#pragma mark 监听网络状态变动的广播通知频段
UIKIT_EXTERN NSString * const CFC_NOTIFICATION_NETWORKING_REACHABILITY_STATUS_FREQUENCY;
#pragma mark 监听网络状态变动的广播通知内容 - 字典KEY
UIKIT_EXTERN NSString * const CFC_NOTIFICATION_NETWORKING_REACHABILITY_STATUS_KEY;


#pragma mark -
#pragma mark 网络状态监听的广播通知频段
typedef void(^CFCCurrentReachabilityStatusBlock)(CFCNetworkStatus networkStatus);


@interface CFCNetworkReachabilityUtil : NSObject

+ (instancetype)sharedNetworkUtilsWithCurrentReachabilityStatusBlock:(CFCCurrentReachabilityStatusBlock)currentReachabilityStatusBlock;

+ (CFCNetworkStatus)currentNetworktatus;

+ (BOOL)isNetworkAvailable;

@end

