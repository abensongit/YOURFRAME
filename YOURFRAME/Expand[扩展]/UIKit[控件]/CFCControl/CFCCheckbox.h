

#import <UIKit/UIKit.h>

@interface CFCCheckbox : UIControl

-(void)setChecked:(BOOL)boolValue;
-(void)setDisabled:(BOOL)boolValue;

@property(nonatomic, assign) BOOL checked;
@property(nonatomic, assign) BOOL disabled;

@property(nonatomic, strong) UIColor *normalBgColor;
@property(nonatomic, strong) UIColor *selectBgColor;

- (instancetype)initWithFrame:(CGRect)frame selectBgColor:(UIColor *)selectBgColor normalBgColor:(UIColor *)normalBgColor;

@end
