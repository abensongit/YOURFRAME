
#import <UIKit/UIKit.h>

@interface UIView (DistributeSubview)

#pragma mark 水平方向间隙
- (void) distributeSpacingHorizontallyWith:(NSArray*)views;

#pragma mark 垂直方向间隙
- (void) distributeSpacingVerticallyWith:(NSArray*)views;

@end
