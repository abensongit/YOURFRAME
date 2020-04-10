

#import <Foundation/Foundation.h>

#if __has_include(<SVProgressHUD/SVProgressHUD.h>)
#import <SVProgressHUD/SVProgressHUD.h>
#else
#import "SVProgressHUD.h"
#endif

typedef void (^NEXProgressHUDDismissCompletion)(void);


@interface CFCProgressHUDUtil : NSObject

+ (void)show;
+ (void)showWithStatus:(nullable NSString*)status;

+ (void)showProgress:(float)progress;
+ (void)showProgress:(float)progress status:(nullable NSString*)status;

+ (void)showInfoWithStatus:(nullable NSString*)status;
+ (void)showSuccessWithStatus:(nullable NSString*)status;
+ (void)showErrorWithStatus:(nullable NSString*)status;

+ (void)showImage:(nonnull UIImage*)image status:(nullable NSString*)status;

+ (void)dismiss;
+ (void)dismissWithDelay:(NSTimeInterval)delay;
+ (void)dismissWithCompletion:(nullable NEXProgressHUDDismissCompletion)completion;

+ (BOOL)isVisible;

@end


