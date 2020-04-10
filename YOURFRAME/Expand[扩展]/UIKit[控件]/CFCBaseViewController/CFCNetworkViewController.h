
#import "CFCNavBarViewController.h"
@class CFCNetworkViewController;

@protocol CFCNetworkViewControllerProtocol <NSObject>
@optional
- (void)currentNetworkReachabilityStatus:(CFCNetworkStatus)currentNetworkStatus inViewController:(CFCNetworkViewController *)inViewController;
@end

@interface CFCNetworkViewController : CFCNavBarViewController <CFCNetworkViewControllerProtocol>

#pragma mark 监听网络变化后执行 - 有网络
- (void)viewDidLoadWithNetworkingStatus;

#pragma mark 监听网络变化后执行 - 无网络
- (void)viewDidLoadWithNoNetworkingStatus;

@end

