
#import "CFCTabPager1ViewController.h"
#import "CFCTab1ScrollView.h"

@interface CFCTabPager1ViewController () <CFCTab1ScrollDelegate, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (assign, nonatomic) NSInteger selectedIndex;
@property (strong, nonatomic) CFCTab1ScrollView *tabHeader;
@property (strong, nonatomic) NSMutableArray *viewControllers;
@property (strong, nonatomic) NSMutableArray *tabTitles;
@property (strong, nonatomic) UIColor *tabLineColor;
@property (strong, nonatomic) UIColor *tabIndicatorColor;
@property (strong, nonatomic) UIColor *tabBackgroundColor;
@property (strong, nonatomic) UIColor *tabTitleNoramlColor;
@property (strong, nonatomic) UIColor *tabTitleSelectColor;
@property (assign, nonatomic) CGFloat headerHeight;

@end

@implementation CFCTabPager1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setPageViewController:[[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                                navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                              options:nil]];
    
    for (UIView *view in [[[self pageViewController] view] subviews]) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            // UIScrollView 其它设置
            [(UIScrollView *)view setCanCancelContentTouches:YES];
            [(UIScrollView *)view setDelaysContentTouches:NO];
            // UIScrollView 支持侧滑返回
            UIViewController *viewController = [self pageViewController];
            [viewController tz_addPopGestureToView:view];
        }
    }
    
    [[self pageViewController] setDataSource:self];
    [[self pageViewController] setDelegate:self];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self reloadTabs];
}
#pragma clang diagnostic pop


#pragma mark - Page View Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger pageIndex = [[self viewControllers] indexOfObject:viewController];
    return pageIndex > 0 ? [self viewControllers][pageIndex - 1]: nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger pageIndex = [[self viewControllers] indexOfObject:viewController];
    return pageIndex < [[self viewControllers] count] - 1 ? [self viewControllers][pageIndex + 1]: nil;
}

#pragma mark - Page View Delegate

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    NSInteger index = [[self viewControllers] indexOfObject:pendingViewControllers[0]];
    [[self tabHeader] animateToTabAtIndex:index];
    
    if ([[self delegate] respondsToSelector:@selector(tabPager:willTransitionToTabAtIndex:viewControllerAtIndex:)]) {
        [[self delegate] tabPager:self willTransitionToTabAtIndex:index viewControllerAtIndex:pendingViewControllers[0]];
    }
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    UIPageViewController *selectedViewController = [[self pageViewController] viewControllers][0];
    
    [self setSelectedIndex:[[self viewControllers] indexOfObject:selectedViewController]];
    
    [[self tabHeader] animateToTabAtIndex:[self selectedIndex]];
    
    if ([[self delegate] respondsToSelector:@selector(tabPager:didTransitionToTabAtIndex:viewControllerAtIndex:)]) {
        [[self delegate] tabPager:self didTransitionToTabAtIndex:[self selectedIndex] viewControllerAtIndex:selectedViewController];
    }
}

#pragma mark - Tab Scroll View Delegate

- (void)tabScrollView:(CFCTab1ScrollView *)tabScrollView didSelectTabAtIndex:(NSInteger)index {
    if (index != [self selectedIndex]) {
        if ([[self delegate] respondsToSelector:@selector(tabPager:willTransitionToTabAtIndex:viewControllerAtIndex:)]) {
            [[self delegate] tabPager:self willTransitionToTabAtIndex:index viewControllerAtIndex:[self viewControllers][index]];
        }
        
        [[self pageViewController]  setViewControllers:@[[self viewControllers][index]]
                                             direction:(index > [self selectedIndex]) ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse
                                              animated:[self selectTabbarIndexAnimation]
                                            completion:^(BOOL finished) {
                                                [self setSelectedIndex:index];
                                                if ([[self delegate] respondsToSelector:@selector(tabPager:didTransitionToTabAtIndex:viewControllerAtIndex:)]) {
                                                    [[self delegate] tabPager:self didTransitionToTabAtIndex:[self selectedIndex] viewControllerAtIndex:[self viewControllers][index]];
                                                }
                                            }];
    }
}

- (void)reloadData
{
    [self reloadDataIndex:0];
}

- (void)reloadDataIndex:(NSInteger)index
{
    [self setViewControllers:[NSMutableArray array]];
    [self setTabTitles:[NSMutableArray array]];
    
    for (int i = 0; i < [[self dataSource] numberOfViewControllers]; i++) {
        UIViewController *viewController;
        
        if ((viewController = [[self dataSource] viewControllerForIndex:i]) != nil) {
            [[self viewControllers] addObject:viewController];
        }
        
        if ([[self dataSource] respondsToSelector:@selector(titleForTabAtIndex:)]) {
            NSString *title;
            if ((title = [[self dataSource] titleForTabAtIndex:i]) != nil) {
                [[self tabTitles] addObject:title];
            }
        }
    }
    
    [self reloadTabs];
    
    CGRect frame = [[self view] frame];
    frame.origin.y = [self headerHeight];
    frame.size.height -= [self headerHeight];
    
    [[[self pageViewController] view] setFrame:frame];
    
    [self.pageViewController setViewControllers:@[[self viewControllers][index]]
                                      direction:UIPageViewControllerNavigationDirectionReverse
                                       animated:NO
                                     completion:nil];
    [self setSelectedIndex:index];
    [self selectTabbarIndex:index animation:NO];
    if ([[self delegate] respondsToSelector:@selector(tabPager:willTransitionToTabAtIndex:viewControllerAtIndex:)]) {
        [[self delegate] tabPager:self willTransitionToTabAtIndex:[self selectedIndex] viewControllerAtIndex:[self viewControllers][index]];
    }
    if ([[self delegate] respondsToSelector:@selector(tabPager:didTransitionToTabAtIndex:viewControllerAtIndex:)]) {
        [[self delegate] tabPager:self didTransitionToTabAtIndex:[self selectedIndex] viewControllerAtIndex:[self viewControllers][index]];
    }
}

- (void)reloadTabs
{
    if ([[self dataSource] numberOfViewControllers] == 0) {
        return;
    }
    
    if ([[self dataSource] respondsToSelector:@selector(tabHeight)]) {
        [self setHeaderHeight:[[self dataSource] tabHeight]];
    } else {
        [self setHeaderHeight:44.0f];
    }
    
    if ([[self dataSource] respondsToSelector:@selector(tabIndicatorColor)]) {
        [self setTabIndicatorColor:[[self dataSource] tabIndicatorColor]];
    } else {
        [self setTabIndicatorColor:[UIColor orangeColor]];
    }
    
    if ([[self dataSource] respondsToSelector:@selector(tabLineColor)]) {
        [self setTabLineColor:[[self dataSource] tabLineColor]];
    } else {
        [self setTabLineColor:[UIColor orangeColor]];
    }
    
    if ([[self dataSource] respondsToSelector:@selector(tabBackgroundColor)]) {
        [self setTabBackgroundColor:[[self dataSource] tabBackgroundColor]];
    } else {
        [self setTabBackgroundColor:[UIColor colorWithWhite:0.95f alpha:1.0f]];
    }
    
    NSMutableArray *tabViews = [NSMutableArray array];
    
    if ([[self dataSource] respondsToSelector:@selector(viewForTabAtIndex:)]) {
        for (int i = 0; i < [[self viewControllers] count]; i++) {
            UIView *view;
            if ((view = [[self dataSource] viewForTabAtIndex:i]) != nil) {
                [tabViews addObject:view];
            }
        }
    } else {
        UIFont *font;
        if ([[self dataSource] respondsToSelector:@selector(titleFont)]) {
            font = [[self dataSource] titleFont];
        } else {
            font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20.0f];
        }
        
        UIColor *color;
        if ([[self dataSource] respondsToSelector:@selector(titleColor)]) {
            color = [[self dataSource] titleColor];
        } else {
            color = [UIColor blackColor];
        }
        self.tabTitleNoramlColor = color;
        
        UIColor *selectColor;
        if ([[self dataSource] respondsToSelector:@selector(titleSelectColor)]) {
            selectColor = [[self dataSource] titleSelectColor];
        } else {
            selectColor = [UIColor blackColor];
        }
        self.tabTitleSelectColor = selectColor;
        
        for (NSString *title in [self tabTitles]) {
            UILabel *label = [UILabel new];
            [label setText:title];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setFont:font];
            [label setTextColor:color];
            [label sizeToFit];
            
            CGRect frame = [label frame];
            frame.size.width = MAX(frame.size.width + 30, 60);
            [label setFrame:frame];
            [tabViews addObject:label];
        }
    }
    
    if ([self tabHeader]) {
        [[self tabHeader] removeFromSuperview];
    }
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    frame.size.height = [self headerHeight];
    CFCTab1ScrollView *tabHeader = [[CFCTab1ScrollView alloc] initWithFrame:frame tabViews:tabViews tabBarHeight:[self headerHeight] tabIndicatorColor:[self tabIndicatorColor] tabLineColor:[self tabLineColor] backgroundColor:[self tabBackgroundColor] tabTitleNormalColor:[self tabTitleNoramlColor] tabTitleSelectColor:[self tabTitleSelectColor] selectedTabIndex:self.selectedIndex];
    
    [self setTabHeader:tabHeader];
    [self.tabHeader addShadowWithOffset:CGSizeMake(0, 5) opacity:0.45f andRadius:5.0];
    [self.tabHeader setTabScrollDelegate:self];

    // UIScrollView 支持侧滑返回
    [self tz_addPopGestureToView:tabHeader];
    
    [self.view addSubview:self.tabHeader];
    [self.view.layer setMasksToBounds:YES];
}

#pragma mark - Public Methods

- (BOOL)selectTabbarIndexAnimation
{
    return YES;
}

- (void)selectTabbarIndex:(NSInteger)index {
    [self selectTabbarIndex:index animation:NO];
}

- (void)selectTabbarIndex:(NSInteger)index animation:(BOOL)animation {
    [self.pageViewController setViewControllers:@[[self viewControllers][index]]
                                      direction:UIPageViewControllerNavigationDirectionReverse
                                       animated:animation
                                     completion:nil];
    [[self tabHeader] animateToTabAtIndex:index animated:animation];
    [self setSelectedIndex:index];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    /* Need to calculate max/min offset for *every* page, not just the first and last. */
    CGFloat minXOffset = scrollView.bounds.size.width - (self.selectedIndex * scrollView.bounds.size.width);
    CGFloat maxXOffset = (([self.viewControllers count] - self.selectedIndex) * scrollView.bounds.size.width);
    
    CGRect scrollBounds = scrollView.bounds;
    if (scrollView.contentOffset.x <= minXOffset) {
        scrollView.contentOffset = CGPointMake(minXOffset, 0);
        scrollBounds.origin = CGPointMake(minXOffset, 0);
    } else if (scrollView.contentOffset.x >= maxXOffset) {
        scrollView.contentOffset = CGPointMake(maxXOffset, 0);
        scrollBounds.origin = CGPointMake(maxXOffset, 0);
    }
    [scrollView setBounds:scrollBounds];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    /* Need to calculate max/min offset for *every* page, not just the first and last. */
    CGFloat minXOffset = scrollView.bounds.size.width - (self.selectedIndex * scrollView.bounds.size.width);
    CGFloat maxXOffset = (([self.viewControllers count] - self.selectedIndex) * scrollView.bounds.size.width);
    
    if (scrollView.contentOffset.x <= minXOffset) {
        *targetContentOffset = CGPointMake(minXOffset, 0);
    } else if (scrollView.contentOffset.x >= maxXOffset) {
        *targetContentOffset = CGPointMake(maxXOffset, 0);
    }
}

@end


