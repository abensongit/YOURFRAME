
#import "CFCBaseCoreViewController.h"
#import "UIColor+Extension.h"
#import "CFCSysCoreMacro.h"

@interface CFCBaseCoreViewController ()

@end

@implementation CFCBaseCoreViewController

#pragma mark -
#pragma mark 视图生命周期（创建视图）
- (void)loadView
{
    [super loadView];
    
    // 设置控制器旋转方向
    [self preferredDeviceInterfaceOrientation:[self preferredInterfaceOrientation]];
}

#pragma mark 视图生命周期（加载视图）
- (void)viewDidLoad
{
    [super viewDidLoad];

    // 设置默认背景颜色
    [self.view setBackgroundColor:COLOR_SYSTEM_MAIN_UI_BACKGROUND_DEFAULT];
}


#pragma mark -
#pragma mark 设置是否允许自动旋转
-(BOOL)shouldAutorotate
{
    // 控制器是否自动旋转
    return YES;
}

#pragma mark 设置当前屏幕的旋转方向
- (UIInterfaceOrientation)preferredInterfaceOrientation
{
    return UIInterfaceOrientationPortrait;
}

#pragma mark 设置屏幕支持的旋转方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    // 注意：
    // UIDeviceOrientation    设备方向
    // UIInterfaceOrientation 屏幕视图方向
    
    // 竖屏时设备方向和屏幕方向是一致的
    // 横屏时设备方向和屏幕方向相反。如手机右转（Home键在右侧）时，屏幕方向是左转的。

    /*
     typedef NS_ENUM(NSInteger, UIDeviceOrientation) {
     UIDeviceOrientationUnknown,
     UIDeviceOrientationPortrait,            // Home按钮在下
     UIDeviceOrientationPortraitUpsideDown,  // Home按钮在上
     UIDeviceOrientationLandscapeLeft,       // Home按钮右
     UIDeviceOrientationLandscapeRight,      // Home按钮左
     UIDeviceOrientationFaceUp,              // 手机平躺，屏幕朝上
     UIDeviceOrientationFaceDown             // 手机平躺，屏幕朝下
     };
    */
     
    UIInterfaceOrientation interfaceOrientation =  [self preferredInterfaceOrientation];
    switch (interfaceOrientation) {
        case UIInterfaceOrientationUnknown: { // 未知
            return UIInterfaceOrientationMaskPortrait;
        }
        case UIInterfaceOrientationPortrait: { // Home按钮在下
            return UIInterfaceOrientationMaskPortrait;
        }
        case UIInterfaceOrientationPortraitUpsideDown: { // Home按钮在上
            return UIInterfaceOrientationMaskPortraitUpsideDown;
        }
        case UIInterfaceOrientationLandscapeLeft: { // Home按钮右
            return UIInterfaceOrientationMaskLandscapeLeft;
        }
        case UIInterfaceOrientationLandscapeRight: { // Home按钮左
            return UIInterfaceOrientationMaskLandscapeRight;
        }
        default: {
            return UIInterfaceOrientationMaskPortrait;
        }
    }
}

#pragma mark 设置屏幕优先显示的方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self preferredInterfaceOrientation];
}

#pragma mark 设置设备控制器旋转方向
- (void)preferredDeviceInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // 设置竖屏
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = interfaceOrientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
        
        // 竖屏刷新
        [UIViewController attemptRotationToDeviceOrientation];
    }
}


@end


