
#import "UIButton+CFCSystem.h"

@implementation UIButton (CFCSystem)

- (void)bootStyleButton
{
    [self.layer setBorderWidth:1.0];
    [self.layer setCornerRadius:5.0];
    [self.layer setMasksToBounds:YES];
    [self setAdjustsImageWhenHighlighted:NO];
    [self.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:self.titleLabel.font.pointSize]];
}


/**
 * 默认按钮
 */
- (void)defaultStyleButton
{
    [self bootStyleButton];
    [self.layer setCornerRadius:3.0];
    [self setShowsTouchWhenHighlighted:YES];
    [self setTitleColor:[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00] forState:UIControlStateHighlighted];
    [self.layer setBorderColor:COLOR_SYSTEM_MAIN_UI_BUTTON_DEFAULT.CGColor];
    [self setBackgroundColor:COLOR_SYSTEM_MAIN_UI_BUTTON_DEFAULT];
    [self setBackgroundImage:[self buttonImageFromColor:COLOR_SYSTEM_MAIN_UI_BUTTON_DEFAULT
                                                   rect:CGRectMake(self.frame.origin.x, self.frame.origin.y, SCREEN_WIDTH, 50)]
                    forState:UIControlStateHighlighted];
    
}

/**
 * 登录界面：登录按钮
 */
- (void)loginStyleButton
{
    [self bootStyleButton];
    [self setShowsTouchWhenHighlighted:YES];
    [self setTitleColor:[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00] forState:UIControlStateHighlighted];
    [self.layer setBorderColor:COLOR_SYSTEM_MAIN_UI_BUTTON_DEFAULT.CGColor];
    [self setBackgroundColor:COLOR_SYSTEM_MAIN_UI_BUTTON_DEFAULT];
    [self setBackgroundImage:[self buttonImageFromColor:COLOR_SYSTEM_MAIN_UI_BUTTON_DEFAULT
                                                   rect:CGRectMake(self.frame.origin.x, self.frame.origin.y, SCREEN_WIDTH, 50)]
                    forState:UIControlStateHighlighted];
}


/**
 * 登录界面：注册按钮
 */
- (void)registerStyleButton
{
    [self bootStyleButton];
    [self setShowsTouchWhenHighlighted:YES];
    [self setTitleColor:COLOR_SYSTEM_MAIN_UI_BUTTON_DEFAULT forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00] forState:UIControlStateHighlighted];
    [self.layer setBorderColor:COLOR_SYSTEM_MAIN_UI_BUTTON_DEFAULT.CGColor];
    [self setBackgroundColor:[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00]];
    [self setBackgroundImage:[self buttonImageFromColor:COLOR_SYSTEM_MAIN_UI_BUTTON_DEFAULT
                                                   rect:CGRectMake(self.frame.origin.x, self.frame.origin.y, SCREEN_WIDTH, 50)]
                    forState:UIControlStateHighlighted];
}


/**
 * 登录界面：忘记密码按钮
 */
- (void)retPasswordStyleButton
{
    [self.layer setCornerRadius:5.0];
    [self.layer setMasksToBounds:YES];
    [self.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [self setTitleColor:[UIColor colorWithRed:0.40 green:0.40 blue:0.40 alpha:1.00] forState:UIControlStateNormal];
    [self setTitleColor:COLOR_SYSTEM_MAIN_UI_BUTTON_DEFAULT forState:UIControlStateHighlighted];
    [self setBackgroundColor:[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00]];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1]
                                                   rect:CGRectMake(self.frame.origin.x, self.frame.origin.y, SCREEN_WIDTH, 50)]
                    forState:UIControlStateHighlighted];
}


/**
 * 玄机锦囊
 */
- (void)discoerXuanJiJinLang
{
  [self bootStyleButton];
  [self.layer setCornerRadius:5.0];
  [self setShowsTouchWhenHighlighted:YES];
  [self.titleLabel setFont:[UIFont systemFontOfSize:CFC_AUTOSIZING_FONT(15.0)]];
  [self setTitleColor:[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00] forState:UIControlStateNormal];
  [self setTitleColor:[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00] forState:UIControlStateHighlighted];
  [self.layer setBorderColor:COLOR_HEXSTRING(@"#C1A471").CGColor];
  [self setBackgroundColor:COLOR_HEXSTRING(@"#CFBA64")];
  [self setBackgroundImage:[self buttonImageFromColor:COLOR_HEXSTRING(@"#CFBA64")
                                                 rect:CGRectMake(self.frame.origin.x, self.frame.origin.y, SCREEN_WIDTH, 50)]
                  forState:UIControlStateHighlighted];
  
}


/**
 * 投票按钮
 */
- (void)voteStyleButton
{
  [self bootStyleButton];
  [self setShowsTouchWhenHighlighted:YES];
  [self setTitleColor:[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00] forState:UIControlStateNormal];
  [self setTitleColor:[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00] forState:UIControlStateHighlighted];
  [self.layer setBorderColor:COLOR_SYSTEM_MAIN_UI_BUTTON_DEFAULT.CGColor];
  [self setBackgroundColor:COLOR_SYSTEM_MAIN_UI_BUTTON_DEFAULT];
  [self setBackgroundImage:[self buttonImageFromColor:COLOR_SYSTEM_MAIN_UI_BUTTON_DEFAULT
                                                 rect:CGRectMake(self.frame.origin.x, self.frame.origin.y, SCREEN_WIDTH, 50)]
                  forState:UIControlStateHighlighted];
}


/**
 * 设置背景
 */
- (void)setBackgroundImageColor:(UIColor *)backgroundImageColor
{
  [self setBackgroundColor:backgroundImageColor];
  [self.layer setBorderColor:backgroundImageColor.CGColor];
  [self setBackgroundImage:[self buttonImageFromColor:backgroundImageColor
                                                 rect:CGRectMake(self.frame.origin.x, self.frame.origin.y, SCREEN_WIDTH, 50)]
                  forState:UIControlStateNormal];
}


/**
 * 公共按钮
 */
- (void)defaultCommonButtonWithTitleColor:(UIColor *)titleColor
                          backgroundColor:(UIColor *)backgroundColor
                     backgroundImageColor:(UIColor *)backgroundImageColor
                              borderColor:(UIColor *)borderColor
                              borderWidth:(CGFloat)borderWidth
                             cornerRadius:(CGFloat)cornerRadius
{
    [self.layer setMasksToBounds:YES];
    [self setShowsTouchWhenHighlighted:YES];
    [self setAdjustsImageWhenHighlighted:YES];
    [self.layer setBorderWidth:borderWidth];
    [self.layer setCornerRadius:cornerRadius];
    [self.layer setBorderColor:borderColor.CGColor];
    [self.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:self.titleLabel.font.pointSize]];
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    [self setTitleColor:titleColor forState:UIControlStateHighlighted];
    [self setBackgroundColor:backgroundColor];
    [self setBackgroundImage:[self buttonImageFromColor:backgroundImageColor
                                                   rect:CGRectMake(self.frame.origin.x, self.frame.origin.y, SCREEN_WIDTH, 50)]
                    forState:UIControlStateHighlighted];
}


/**
 * 公共按钮：高亮显示
 */
- (void)defaultCommonButtonWithTitleColor:(UIColor *)titleColor
                          backgroundColor:(UIColor *)backgroundColor
               backgroundImageNormalColor:(UIColor *)backgroundImageNormalColor
             backgroundImageSelectedColor:(UIColor *)backgroundImageSelectedColor
                              borderColor:(UIColor *)borderColor
                              borderWidth:(CGFloat)borderWidth
                             cornerRadius:(CGFloat)cornerRadius
{
    [self.layer setMasksToBounds:YES];
    [self setShowsTouchWhenHighlighted:YES];
    [self setAdjustsImageWhenHighlighted:YES];
    [self.layer setBorderWidth:borderWidth];
    [self.layer setCornerRadius:cornerRadius];
    [self.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:self.titleLabel.font.pointSize]];
    
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    [self setTitleColor:titleColor forState:UIControlStateHighlighted];
    [self setBackgroundColor:backgroundColor];
    [self.layer setBorderColor:borderColor.CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:backgroundImageNormalColor
                                                   rect:CGRectMake(self.frame.origin.x, self.frame.origin.y, SCREEN_WIDTH, 50)]
                    forState:UIControlStateNormal];
    [self setBackgroundImage:[self buttonImageFromColor:backgroundImageSelectedColor
                                                   rect:CGRectMake(self.frame.origin.x, self.frame.origin.y, SCREEN_WIDTH, 50)]
                    forState:UIControlStateHighlighted];
}


/**
 * 生成背景图片
 */
- (UIImage *) buttonImageFromColor:(UIColor *)color rect:(CGRect)frame
{
    CGRect rect = CGRectMake(0, 0, frame.size.width, frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


@end




