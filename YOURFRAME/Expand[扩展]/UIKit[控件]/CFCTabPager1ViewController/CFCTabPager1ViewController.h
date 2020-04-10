
#import "CFCBaseCommonViewController.h"
@class CFCTab1ScrollView;

@protocol CFCTabPager1Delegate;
@protocol CFCTabPager1DataSource;

@interface CFCTabPager1ViewController : CFCBaseCommonViewController

@property (weak, nonatomic) id<CFCTabPager1Delegate> delegate;
@property (weak, nonatomic) id<CFCTabPager1DataSource> dataSource;

- (void)reloadData;
- (void)reloadDataIndex:(NSInteger)index;
- (NSInteger)selectedIndex;

- (BOOL)selectTabbarIndexAnimation;
- (void)selectTabbarIndex:(NSInteger)index;
- (void)selectTabbarIndex:(NSInteger)index animation:(BOOL)animation;

@end

@protocol CFCTabPager1DataSource <NSObject>

@required
- (NSInteger)numberOfViewControllers;
- (UIViewController *)viewControllerForIndex:(NSInteger)index;

@optional
- (UIView *)viewForTabAtIndex:(NSInteger)index;
- (NSString *)titleForTabAtIndex:(NSInteger)index;
- (CGFloat)tabHeight;
- (UIColor *)tabLineColor;
- (UIColor *)tabIndicatorColor;
- (UIColor *)tabBackgroundColor;
- (UIFont *)titleFont;
- (UIColor *)titleColor;
- (UIColor *)titleSelectColor;

@end

@protocol CFCTabPager1Delegate <NSObject>

@optional
- (void)tabPager:(CFCTabPager1ViewController *)tabPager willTransitionToTabAtIndex:(NSInteger)index viewControllerAtIndex:(UIViewController *)viewController;
- (void)tabPager:(CFCTabPager1ViewController *)tabPager didTransitionToTabAtIndex:(NSInteger)index viewControllerAtIndex:(UIViewController *)viewController;

@end

