
#import <UIKit/UIKit.h>

@interface UITextField (UnderLineAndLeftRightImage)


/**
 *  给UITextField设置右侧的图片
 */
- (void)setTextFieldLeftImageViewWithRect:(CGRect)rect imageName:(NSString *)imageName;
/**
 *  给UITextField设置右侧的图片
 */
- (void)setTextFieldRightImageViewWithRect:(CGRect)rect imageName:(NSString *)imageName;


@end
