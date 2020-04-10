
#import <UIKit/UIKit.h>

@protocol CFCTabScrollDelegate;

@interface CFCTabScrollView : UIScrollView

@property (weak, nonatomic) id<CFCTabScrollDelegate> tabScrollDelegate;

- (instancetype)initWithFrame:(CGRect)frame tabViews:(NSArray *)tabViews tabBarHeight:(CGFloat)height tabIndicatorHeight:(CGFloat)tabIndicatorHeight tabIndicatorColor:(UIColor *)tabIndicatorColor tabLineColor:(UIColor *)tabLineColor backgroundColor:(UIColor *)backgroundColor tabTitleNormalColor:(UIColor *)tabTitleNormalColor tabTitleSelectColor:(UIColor *)tabTitleSelectColor selectedTabIndex:(NSInteger)index tabHeaderDirection:(CFCTabPagerHeaderDirection)tabHeaderDirection;
- (instancetype)initWithFrame:(CGRect)frame tabViews:(NSArray *)tabViews tabBarHeight:(CGFloat)height tabIndicatorHeight:(CGFloat)tabIndicatorHeight tabIndicatorColor:(UIColor *)tabIndicatorColor tabLineColor:(UIColor *)tabLineColor backgroundColor:(UIColor *)backgroundColor tabTitleNormalColor:(UIColor *)tabTitleNormalColor tabTitleSelectColor:(UIColor *)tabTitleSelectColor tabHeaderDirection:(CFCTabPagerHeaderDirection)tabHeaderDirection;

- (void)animateToTabAtIndex:(NSInteger)index;
- (void)animateToTabAtIndex:(NSInteger)index animated:(BOOL)animated;

@end

@protocol CFCTabScrollDelegate <NSObject>

- (void)tabScrollView:(CFCTabScrollView *)tabScrollView didSelectTabAtIndex:(NSInteger)index;

@end





