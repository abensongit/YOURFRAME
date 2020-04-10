

#import "CFCProgressAlertUtil.h"

BOOL HUDAnimated = NO;

NSTimeInterval delay = 2;

@implementation CFCProgressAlertUtil

// show white loading circle
+ (MBProgressHUD*)showWhiteLoadingToView:(UIView*)view
{
    return [self showWhiteLoadingWithMessage:@"" toView:view];
}

// show gray loading circle
+ (MBProgressHUD*)showGrayLoadingToView:(UIView*)view
{
    return [self showGaryLoadingWithMessage:@"" toView:view];
}

// show white loading && message
+ (MBProgressHUD*)showWhiteLoadingWithMessage:(NSString*)message toView:(UIView*)view
{
    MBProgressHUD * hud = [MBProgressHUD HUDForView:view];
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:HUDAnimated];
    }
    hud.detailsLabel.text = message;
    [self showAnimatedWithImage:[UIImage imageNamed:@"NEXProgressAlertUtil.bundle/loading_white"] toHUD:hud];
    //hud
    [self customHUDAppearance:hud];
    return hud;
}

// show gray loading && message
+ (MBProgressHUD*)showGaryLoadingWithMessage:(NSString*)message toView:(UIView*)view
{
    MBProgressHUD * hud = [MBProgressHUD HUDForView:view];
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:HUDAnimated];
    }
    hud.detailsLabel.text = message;
    [self showAnimatedWithImage:[UIImage imageNamed:@"NEXProgressAlertUtil.bundle/loading_gray"] toHUD:hud];
    
    [self customPageHUDAppearance:hud];
    
    return hud;
}

+ (BOOL)hideHUDForView:(UIView *)view
{
    return [MBProgressHUD hideHUDForView:view animated:HUDAnimated];
}

+ (MBProgressHUD*)showMessage:(NSString*)message toView:(UIView*)view
{
    MBProgressHUD * hud = [self showMessage:message withImage:nil toView:view];
    return hud;
}

+ (MBProgressHUD*)showMessageToWindow:(NSString*)message
{
    UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
    MBProgressHUD * hud = [self showMessage:message withImage:nil toView:window];
    return hud;
}

+ (MBProgressHUD*)showWarningWithMessage:(NSString*)message toView:(UIView*)view
{
    MBProgressHUD * hud = [self showMessage:message withImage:[UIImage imageNamed:@"NEXProgressAlertUtil.bundle/hud-warning"] toView:view];
    return hud;
}

+ (MBProgressHUD*)showSuccessWithMessage:(NSString*)message toView:(UIView*)view
{
    MBProgressHUD * hud = [self showMessage:message withImage:[UIImage imageNamed:@"NEXProgressAlertUtil.bundle/hud-success"] toView:view];
    return hud;
}

+ (MBProgressHUD*)showFailWithMessage:(NSString*)message toView:(UIView*)view
{
    MBProgressHUD * hud = [self showMessage:message withImage:[UIImage imageNamed:@"NEXProgressAlertUtil.bundle/hud-fail"] toView:view];
    return hud;
}

#pragma -mark privately func

+ (void)showAnimatedWithImage:(UIImage*)image toHUD:(MBProgressHUD*)hud
{
    hud.mode = MBProgressHUDModeCustomView;
    UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.removedOnCompletion = NO;//保证切换到其他页面或进入后台再回来动画继续执行
    rotationAnimation.repeatCount = CGFLOAT_MAX;
    
    [imageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    hud.customView = imageView;
}

+ (MBProgressHUD*)showMessage:(NSString*)message withImage:(UIImage*)image toView:(UIView*)view
{
    MBProgressHUD * hud = [MBProgressHUD HUDForView:view];
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:HUDAnimated];
    }
    hud.removeFromSuperViewOnHide = YES;
    hud.detailsLabel.text = message;
    
    if (image==nil) {
        hud.mode = MBProgressHUDModeText;
    }else{
        hud.mode = MBProgressHUDModeCustomView;
        
        hud.customView = [[UIImageView alloc] initWithImage:image];
    }
    
    [self customHUDAppearance:hud];
    [hud hideAnimated:HUDAnimated afterDelay:delay];
    return hud;
}

+ (void)customHUDAppearance:(MBProgressHUD*)hud
{
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:.8];
    hud.detailsLabel.font = [UIFont systemFontOfSize:14.f];
    //不透明
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.layer.cornerRadius = 10;
}

+ (void)customPageHUDAppearance:(MBProgressHUD*)hud
{
    hud.contentColor = [UIColor grayColor];
    hud.bezelView.color = [UIColor clearColor];
    hud.detailsLabel.font = [UIFont systemFontOfSize:14.f];
    //    hud.bezelView.alpha = 0.8f;
    //不透明
    hud.backgroundView.color = [UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.layer.cornerRadius = 10;
}

@end

