
#import "CFCProgressHUDUtil.h"

@implementation CFCProgressHUDUtil

+ (void)show
{
  [[self class] initConfig];
  [CFCProgressHUD show];
  // [SVProgressHUD show];
}

+ (void)showWithStatus:(nullable NSString*)status
{
  [[self class] initConfig];
  [CFCProgressHUD show:status];
  // [SVProgressHUD showWithStatus:status];
}

+ (void)showProgress:(float)progress
{
  [[self class] initConfig];
  [SVProgressHUD showProgress:progress];
}

+ (void)showProgress:(float)progress status:(nullable NSString*)status
{
  [[self class] initConfig];
  [SVProgressHUD showProgress:progress status:status];
}

+ (void)showInfoWithStatus:(nullable NSString*)status
{
  [[self class] initConfig];
  [SVProgressHUD showInfoWithStatus:status];
}

+ (void)showSuccessWithStatus:(nullable NSString*)status
{
  [[self class] initConfig];
  [SVProgressHUD showSuccessWithStatus:status];
}

+ (void)showErrorWithStatus:(nullable NSString*)status
{
  [[self class] initConfig];
  [SVProgressHUD showErrorWithStatus:status];
  
}

+ (void)showImage:(nonnull UIImage*)image status:(nullable NSString*)status
{
  [[self class] initConfig];
  [SVProgressHUD showImage:image status:status];
}

+ (void)dismiss
{
  [[self class] initConfig];
  [SVProgressHUD dismiss];
  [CFCProgressHUD dismiss];
}

+ (void)dismissWithDelay:(NSTimeInterval)delay
{
  [[self class] initConfig];
  [SVProgressHUD dismissWithDelay:delay];
}

+ (void)dismissWithCompletion:(nullable NEXProgressHUDDismissCompletion)completion
{
  [[self class] initConfig];
  [SVProgressHUD dismissWithCompletion:completion];
}

+ (BOOL)isVisible
{
  return [SVProgressHUD isVisible];
}

#pragma mark - Private

+ (void)initConfig
{
  [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
  [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
  //
  [CFCProgressHUD hudColor:COLOR_RGBA(0, 0, 0, 0.9)];
  [CFCProgressHUD statusColor:COLOR_HEXSTRING(@"#FFFFFF")];
  [CFCProgressHUD statusFont:[UIFont systemFontOfSize:CFC_AUTOSIZING_FONT(14)]];
}

@end


