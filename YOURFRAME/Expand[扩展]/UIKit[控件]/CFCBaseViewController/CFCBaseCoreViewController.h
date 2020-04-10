
#import "CFCNetworkViewController.h"


@protocol CFCBaseCoreViewControllerInterfaceOrientationProtocol <NSObject>
@required
#pragma mark 设置是否允许自动旋转
-(BOOL)shouldAutorotate;
#pragma mark 设置当前屏幕的旋转方向
- (UIInterfaceOrientation)preferredInterfaceOrientation;
#pragma mark 设置屏幕支持的旋转方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations;
#pragma mark 设置屏幕优先显示的方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation;
#pragma mark 设置设备控制器旋转方向
- (void)preferredDeviceInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
@end


@interface CFCBaseCoreViewController : CFCNetworkViewController <CFCBaseCoreViewControllerInterfaceOrientationProtocol>

@end

