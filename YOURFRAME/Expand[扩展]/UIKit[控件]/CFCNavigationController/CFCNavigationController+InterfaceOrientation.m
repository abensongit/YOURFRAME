
#import "CFCNavigationController+InterfaceOrientation.h"


@implementation CFCNavigationController (InterfaceOrientation)


#pragma mark -
#pragma mark 设置是否允许自动旋转
-(BOOL)shouldAutorotate
{
    return [self.topViewController shouldAutorotate];
}

#pragma mark 设置屏幕支持的旋转方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}

#pragma mark 设置屏幕优先显示的方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

@end

