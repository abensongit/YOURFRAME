
#import <UIKit/UIKit.h>

@interface UIView (AutoLayout)

// Center alignment to superview
- (void)alignCenterToSuperview;

// Top alignments to superview
- (void)alignTopLeftToSuperview;
- (void)alignTopRightToSuperview;

// Bottom alignments to superview
- (void)alignBottomLeftToSuperview;
- (void)alignBottomRightToSuperview;

// Custom alignments to superview
- (void)alignToSuperviewWithAxes:(NSLayoutFormatOptions)axes;

@end
