
#import <UIKit/UIKit.h>

@protocol CFCTab1ScrollDelegate;

@interface CFCTab1ScrollView : UIScrollView

@property (weak, nonatomic) id<CFCTab1ScrollDelegate> tabScrollDelegate;

- (instancetype)initWithFrame:(CGRect)frame tabViews:(NSArray *)tabViews tabBarHeight:(CGFloat)height tabIndicatorColor:(UIColor *)tabIndicatorColor tabLineColor:(UIColor *)tabLineColor backgroundColor:(UIColor *)backgroundColor tabTitleNormalColor:(UIColor *)tabTitleNormalColor tabTitleSelectColor:(UIColor *)tabTitleSelectColor selectedTabIndex:(NSInteger)index;

- (instancetype)initWithFrame:(CGRect)frame tabViews:(NSArray *)tabViews tabBarHeight:(CGFloat)height tabIndicatorColor:(UIColor *)tabIndicatorColor tabLineColor:(UIColor *)tabLineColor backgroundColor:(UIColor *)backgroundColor tabTitleNormalColor:(UIColor *)tabTitleNormalColor tabTitleSelectColor:(UIColor *)tabTitleSelectColor;

- (void)animateToTabAtIndex:(NSInteger)index;

- (void)animateToTabAtIndex:(NSInteger)index animated:(BOOL)animated;

@end

@protocol CFCTab1ScrollDelegate <NSObject>

- (void)tabScrollView:(CFCTab1ScrollView *)tabScrollView didSelectTabAtIndex:(NSInteger)index;

@end





