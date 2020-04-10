

#import <UIKit/UIKit.h>

@interface CFCProgressHUD : UIView

#pragma mark - Display methods

+ (void)show;
+ (void)show:(NSString *)status;
+ (void)show:(NSString *)status Interaction:(BOOL)interaction;

+ (void)showSuccess;
+ (void)showSuccess:(NSString *)status;
+ (void)showSuccess:(NSString *)status Interaction:(BOOL)interaction;

+ (void)showError;
+ (void)showError:(NSString *)status;
+ (void)showError:(NSString *)status Interaction:(BOOL)interaction;

+ (void)dismiss;

#pragma mark - Property methods

+ (void)statusFont:(UIFont *)font;
+ (void)statusColor:(UIColor *)color;
+ (void)spinnerColor:(UIColor *)color;
+ (void)hudColor:(UIColor *)color;
+ (void)backgroundColor:(UIColor *)color;
+ (void)imageSuccess:(UIImage *)image;
+ (void)imageError:(UIImage *)image;

#pragma mark - Properties

@property (strong, nonatomic) UIFont *statusFont;
@property (strong, nonatomic) UIColor *statusColor;
@property (strong, nonatomic) UIColor *spinnerColor;
@property (strong, nonatomic) UIColor *hudColor;
@property (strong, nonatomic) UIColor *backgroundColor;
@property (strong, nonatomic) UIImage *imageSuccess;
@property (strong, nonatomic) UIImage *imageError;

@end
