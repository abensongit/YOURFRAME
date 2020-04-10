
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFCTabBarController : UITabBarController

#pragma mark 添加子导航控制器
- (void)addChildNavigationController:(Class)navigationControllerClass
                  rootViewController:(Class)rootViewControllerClass
                     navigationTitle:(NSString *)navigationTitle
                     tabBarItemTitle:(NSString *)tabBarItemTitle
               tabBarNormalImageName:(NSString *)normalImageName
               tabBarSelectImageName:(NSString *)selectImageName
                   tabBarItemEnabled:(BOOL)enabled;

@end

NS_ASSUME_NONNULL_END
