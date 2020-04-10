
#import "UITextField+UnderLineAndLeftRightImage.h"

@implementation UITextField (UnderLineAndLeftRightImage)

/**
 *  给UITextField设置右侧的图片
 */
- (void)setTextFieldLeftImageViewWithRect:(CGRect)rect imageName:(NSString *)imageName
{
    UIImageView *leftView = [[UIImageView alloc] initWithFrame:rect];
    leftView.image = [[UIImage imageNamed:imageName] imageByScalingProportionallyToSize:rect.size] ;
    [leftView.layer setMasksToBounds:YES];
    leftView.userInteractionEnabled = YES;
    leftView.contentMode = UIViewContentModeCenter;
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

/**
 *  给UITextField设置右侧的图片
 */
- (void)setTextFieldRightImageViewWithRect:(CGRect)rect imageName:(NSString *)imageName
{
    UIImageView *rightView = [[UIImageView alloc] initWithFrame:rect];
    rightView.image = [[UIImage imageNamed:imageName] imageByScalingProportionallyToSize:rect.size] ;
    [rightView.layer setMasksToBounds:YES];
    rightView.userInteractionEnabled = YES;
    rightView.contentMode = UIViewContentModeCenter;
    self.rightView = rightView;
    self.rightViewMode = UITextFieldViewModeAlways;
}


@end
