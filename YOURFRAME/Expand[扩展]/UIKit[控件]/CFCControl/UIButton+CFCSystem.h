
#import <UIKit/UIKit.h>

@interface UIButton (CFCSystem)


/**
 * 默认风格按钮
 */
- (void)defaultStyleButton;

/**
 * 登录界面：登录按钮
 */
- (void)loginStyleButton;

/**
 * 登录界面：注册按钮
 */
- (void)registerStyleButton;

/**
 * 登录界面：忘记密码按钮
 */
- (void)retPasswordStyleButton;

/**
 * 玄机锦囊
 */
- (void)discoerXuanJiJinLang;

/**
 * 投票按钮
 */
- (void)voteStyleButton;

/**
 * 设置背景
 */
- (void)setBackgroundImageColor:(UIColor *)backgroundImageColor;

/**
 * 公共按钮
 */
- (void)defaultCommonButtonWithTitleColor:(UIColor *)titleColor
                          backgroundColor:(UIColor *)backgroundColor
                     backgroundImageColor:(UIColor *)backgroundImageColor
                              borderColor:(UIColor *)borderColor
                              borderWidth:(CGFloat)borderWidth
                             cornerRadius:(CGFloat)cornerRadius;

/**
 * 公共按钮：高亮显示
 */
- (void)defaultCommonButtonWithTitleColor:(UIColor *)titleColor
                          backgroundColor:(UIColor *)backgroundColor
               backgroundImageNormalColor:(UIColor *)backgroundImageNormalColor
             backgroundImageSelectedColor:(UIColor *)backgroundImageSelectedColor
                              borderColor:(UIColor *)borderColor
                              borderWidth:(CGFloat)borderWidth
                             cornerRadius:(CGFloat)cornerRadius;

@end



