
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFCNavigationController : UINavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated title:(NSString *)title;

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers;

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
