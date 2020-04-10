
#import "CFCBaseCommonViewController.h"

@class CFCTabScrollView;
@protocol CFCTabPagerDelegate;
@protocol CFCTabPagerDataSource;

typedef NS_ENUM(NSUInteger, CFCTabPagerHeaderDirection) {
  CFCTabPagerHeaderDirectionTop = 0,
  CFCTabPagerHeaderDirectionBottom = 1,
};

@interface CFCTabPagerViewController : CFCBaseCommonViewController

@property (weak, nonatomic) id<CFCTabPagerDelegate> delegate;
@property (weak, nonatomic) id<CFCTabPagerDataSource> dataSource;

- (void)reloadData;
- (void)reloadDataIndex:(NSInteger)index;
- (NSInteger)selectedIndex;

- (BOOL)isLockBouncesPanGesture;
- (BOOL)selectTabbarIndexAnimation;
- (void)selectTabbarIndex:(NSInteger)index;
- (void)selectTabbarIndex:(NSInteger)index animation:(BOOL)animation;

@end

@protocol CFCTabPagerDataSource <NSObject>

@required
- (NSInteger)numberOfViewControllers;
- (UIViewController *)viewControllerForIndex:(NSInteger)index;

@optional
- (NSInteger)tabCountAtOnePage;
- (UIView *)viewForTabAtIndex:(NSInteger)index;
- (NSString *)titleForTabAtIndex:(NSInteger)index;
- (CFCTabPagerHeaderDirection)tabDirection;
- (CGFloat)tabHeight;
- (CGFloat)tabIndicatorHeight;
- (UIColor *)tabLineColor;
- (UIColor *)tabIndicatorColor;
- (UIColor *)tabBackgroundColor;
- (UIFont *)titleFont;
- (UIColor *)titleColor;
- (UIColor *)titleSelectColor;

@end

@protocol CFCTabPagerDelegate <NSObject>

@optional
- (void)tabPager:(CFCTabPagerViewController *)tabPager willTransitionToTabAtIndex:(NSInteger)index viewControllerAtIndex:(UIViewController *)viewController;
- (void)tabPager:(CFCTabPagerViewController *)tabPager didTransitionToTabAtIndex:(NSInteger)index viewControllerAtIndex:(UIViewController *)viewController;

@end

