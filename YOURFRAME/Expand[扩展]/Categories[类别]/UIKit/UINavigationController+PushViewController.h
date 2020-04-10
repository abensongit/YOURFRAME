
#import <UIKit/UIKit.h>

@interface UINavigationController (PushViewController)

- (void)pushViewController:(UIViewController *)viewController removeViewController:(UIViewController *)removeViewController;
- (void)pushViewController:(UIViewController *)viewController removeViewController:(UIViewController *)removeViewController animated:(BOOL)animated;

- (void)pushViewController:(UIViewController *)viewController removeViewControllerAtIndex:(NSInteger)index;
- (void)pushViewController:(UIViewController *)viewController removeViewControllerAtIndex:(NSInteger)index animated:(BOOL)animated;

- (void)pushViewController:(UIViewController *)viewController removeViewControllersAtIndexes:(NSIndexSet *)indexes;
- (void)pushViewController:(UIViewController *)viewController removeViewControllersAtIndexes:(NSIndexSet *)indexes animated:(BOOL)animated;

- (void)pushViewControllers:(NSArray<UIViewController *> *)viewControllers removeViewControllersAtIndexes:(NSIndexSet *)indexes;
- (void)pushViewControllers:(NSArray<UIViewController *> *)viewControllers removeViewControllersAtIndexes:(NSIndexSet *)indexes animated:(BOOL)animated;

@end
