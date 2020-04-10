
#import "UITextField+Appearance.h"

@implementation UITextField (Appearance)


- (void)setPlaceholderColor:(UIColor *)color
{
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}

- (UIColor *)placeholderColor
{
    return [self valueForKey:@"_placeholderLabel.textColor"];
}


- (void)setPlaceholderFont:(UIFont *)font
{
    [self setValue:font forKeyPath:@"_placeholderLabel.font"];
}

- (UIFont *)placeholderFont
{
    return [self valueForKey:@"_placeholderLabel.font"];
}

@end
