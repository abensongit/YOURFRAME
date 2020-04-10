
#import <Foundation/Foundation.h>

// 统一的控制是否显示动画的变量，默认YES
extern BOOL HUDAnimated;

@interface CFCProgressAlertUtil : NSObject

#pragma -mark show hudView

// show white loading circle
+ (MBProgressHUD*)showWhiteLoadingToView:(UIView*)view;

// show gray loading circle
+ (MBProgressHUD*)showGrayLoadingToView:(UIView*)view;

// show white loading && message
+ (MBProgressHUD*)showWhiteLoadingWithMessage:(NSString*)message toView:(UIView*)view;

// show gray loading && message
+ (MBProgressHUD*)showGaryLoadingWithMessage:(NSString*)message toView:(UIView*)view;

// hide Indicator
+ (BOOL)hideHUDForView:(UIView *)view;

#pragma -mark show hudView and hide

// show message and hide after delay timeInterval
+ (MBProgressHUD*)showMessage:(NSString*)message toView:(UIView*)view;

// show to window and after delay timeInterval
+ (MBProgressHUD*)showMessageToWindow:(NSString*)message;

// show and hide after delay timeInterval
+ (MBProgressHUD*)showWarningWithMessage:(NSString*)message toView:(UIView*)view;

// show and hide after delay timeInterval
+ (MBProgressHUD*)showSuccessWithMessage:(NSString*)message toView:(UIView*)view;

// show and hide after delay timeInterval
+ (MBProgressHUD*)showFailWithMessage:(NSString*)message toView:(UIView*)view;

@end

