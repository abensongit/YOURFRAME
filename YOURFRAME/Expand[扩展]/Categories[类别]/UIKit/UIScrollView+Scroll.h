
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIScrollViewDirection) {
    UIScrollViewDirectionNone,
    UIScrollViewDirectionTop,
    UIScrollViewDirectionBottom,
    UIScrollViewDirectionRight,
    UIScrollViewDirectionLeft
};

@interface UIScrollView (Scroll)

- (void)scrollToTopAnimated:(BOOL)animated;

- (void)scrollToBottomAnimated:(BOOL)animated;

- (BOOL)isOnTop;

- (BOOL)isOnBottom;

@end
