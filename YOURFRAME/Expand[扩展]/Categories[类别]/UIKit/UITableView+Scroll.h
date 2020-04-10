
#import <UIKit/UIKit.h>

@interface UITableView (Scroll)

- (void)scrollTableToTopAnimated:(BOOL)animated;

- (void)scrollTableToBottomAnimated:(BOOL)animated;

- (NSIndexPath *)firstIndexPath;

- (NSIndexPath *)lastIndexPath;

@end
