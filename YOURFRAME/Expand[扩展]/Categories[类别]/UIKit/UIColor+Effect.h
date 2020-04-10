
#import <UIKit/UIKit.h>

/*
 * Special effects to be applied to UIColor objects.
 */
@interface UIColor (Effect)

/*
 * Returns a darker color version of current color.
 *
 * @returns A darker color.
 */
- (UIColor *)darkerColor;

/*
 * Returns a lighter color version of current color.
 *
 * @returns A light color.
 */
- (UIColor *)lighterColor;

/*
 * Returns a totally random color.
 *
 * @returns A random color.
 */
+ (UIColor *)randomColor;

@end
