
#import <Foundation/Foundation.h>

@interface NSString (Extension)
/**
 *  计算当前字符串显示所需的实际frame，返回值的x = 0, y = 0
 */
- (CGRect)textRectWithSize:(CGSize)size attributes:(NSDictionary *)attributes;
+ (BOOL) isEmpty:(NSString *) str;
+ (NSString *)qudiaokaitoujieweikongge:(NSString *)yaoqudiaodewenzi;
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW;
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font;
+(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxH:(CGFloat)maxH;
/*判断用户输入的文字中是否有表情符*/
+ (BOOL)stringContainsEmoji:(NSString *)string;
/*md5加密*/
- (NSString *)md5;
@end
