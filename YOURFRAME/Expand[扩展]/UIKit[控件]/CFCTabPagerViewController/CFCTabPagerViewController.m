
#import "CFCTabPagerViewController.h"
#import "CFCTabScrollView.h"

@interface CFCTabPagerViewController () <CFCTabScrollDelegate, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (assign, nonatomic) NSInteger selectedIndex;
@property (strong, nonatomic) CFCTabScrollView *tabHeader;
@property (strong, nonatomic) NSMutableArray *viewControllers;
@property (strong, nonatomic) NSMutableArray *tabTitles;
@property (strong, nonatomic) UIColor *tabLineColor;
@property (strong, nonatomic) UIColor *tabIndicatorColor;
@property (strong, nonatomic) UIColor *tabBackgroundColor;
@property (strong, nonatomic) UIColor *tabTitleNoramlColor;
@property (strong, nonatomic) UIColor *tabTitleSelectColor;
@property (assign, nonatomic) CGFloat indicatorHeight;
@property (assign, nonatomic) CGFloat headerHeight;
@property (assign, nonatomic) CFCTabPagerHeaderDirection headerDirection;

@property (strong, nonatomic) UIPanGestureRecognizer *lockBouncesPan;

@end


@implementation CFCTabPagerViewController


- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self setPageViewController:[[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil]];
  
  for (UIView *view in [[[self pageViewController] view] subviews]) {
    if ([view isKindOfClass:[UIScrollView class]]) {
      // UIScrollView 设置代理，禁掉弹性效果
      // [(UIScrollView *)view setDelegate:self];
      // UIScrollView 其它设置
      [(UIScrollView *)view setCanCancelContentTouches:YES];
      [(UIScrollView *)view setDelaysContentTouches:NO];
      // UIScrollView 支持侧滑返回
      UIViewController *viewController = [self pageViewController];
      [viewController tz_addPopGestureToView:view];
      
      // 实现既有侧滑返回又无弹簧效果
      if ([self isLockBouncesPanGesture]) {
        _lockBouncesPan = [UIPanGestureRecognizer new];
        _lockBouncesPan.delegate = self;
        [((UIScrollView *)view) addGestureRecognizer:_lockBouncesPan];
        [((UIScrollView *)view).panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.fd_fullscreenPopGestureRecognizer];
        [((UIScrollView *)view).panGestureRecognizer requireGestureRecognizerToFail:_lockBouncesPan];
        [_lockBouncesPan requireGestureRecognizerToFail:self.navigationController.fd_fullscreenPopGestureRecognizer];
      }
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

- (void)tabScrollView:(CFCTabScrollView *)tabScrollView didSelectTabAtIndex:(NSInteger)index {
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
  
  if (CFCTabPagerHeaderDirectionTop == self.headerDirection) {
    CGRect frame = [[self view] frame];
    frame.origin.y = [self headerHeight];
    frame.size.height -= [self headerHeight];
    [[[self pageViewController] view] setFrame:frame];
  } else if (CFCTabPagerHeaderDirectionBottom == self.headerDirection) {
    CGRect frame = [[self view] frame];
    frame.size.height = frame.size.height - [self headerHeight] - (IS_IPHONE_X_OR_GREATER ? TAB_BAR_DANGER_HEIGHT : 0.0f);
    [[[self pageViewController] view] setFrame:frame];
  }
  
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
  
  if ([[self dataSource] respondsToSelector:@selector(tabDirection)]) {
    [self setHeaderDirection:[[self dataSource] tabDirection]];
  } else {
    [self setHeaderDirection:CFCTabPagerHeaderDirectionTop];
  }
  
  if ([[self dataSource] respondsToSelector:@selector(tabHeight)]) {
    [self setHeaderHeight:[[self dataSource] tabHeight]];
  } else {
    [self setHeaderHeight:44.0f];
  }
  
  if ([[self dataSource] respondsToSelector:@selector(tabIndicatorHeight)]) {
    [self setIndicatorHeight:[[self dataSource] tabIndicatorHeight]];
  } else {
    [self setIndicatorHeight:4.0f];
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
    
    if ([[self dataSource] respondsToSelector:@selector(tabCountAtOnePage)]) {
      CGFloat labelWidth = 0.0f;
      NSInteger tabCount = [[self dataSource] tabCountAtOnePage];
      if (self.tabTitles.count <= tabCount) {
        labelWidth = (self.view.frame.size.width - 10*(self.tabTitles.count+1)) / self.tabTitles.count;
      } else {
        labelWidth = (self.view.frame.size.width - 10*(tabCount+1)) / tabCount;
      }
      
      for (NSString *title in [self tabTitles]) {
        UILabel *label = [UILabel new];
        [label setText:title];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:font];
        [label setTextColor:color];
        [label sizeToFit];
        
        CGRect frame = [label frame];
        frame.size.width = MAX(frame.size.width + 30, labelWidth);
        [label setFrame:frame];
        [tabViews addObject:label];
      }
    } else {
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
  }
  
  if ([self tabHeader]) {
    [[self tabHeader] removeFromSuperview];
  }
  
  CGRect frame = self.view.frame;
  if (CFCTabPagerHeaderDirectionTop == self.headerDirection) {
    frame.origin.y = 0;
    frame.size.height = [self headerHeight];
  } else if (CFCTabPagerHeaderDirectionBottom == self.headerDirection) {
    frame.origin.y = frame.size.height - [self headerHeight] - (IS_IPHONE_X_OR_GREATER ? TAB_BAR_DANGER_HEIGHT : 0.0f) - STATUS_NAVIGATION_BAR_HEIGHT;
    frame.size.height = [self headerHeight];
  }
  CFCTabScrollView *tabHeader = [[CFCTabScrollView alloc] initWithFrame:frame tabViews:tabViews tabBarHeight:[self headerHeight] tabIndicatorHeight:[self indicatorHeight] tabIndicatorColor:[self tabIndicatorColor] tabLineColor:[self tabLineColor] backgroundColor:[self tabBackgroundColor] tabTitleNormalColor:[self tabTitleNoramlColor] tabTitleSelectColor:[self tabTitleSelectColor] selectedTabIndex:self.selectedIndex tabHeaderDirection:self.headerDirection];
  [self setTabHeader:tabHeader];
  [[self tabHeader] setTabScrollDelegate:self];
  
  // UIScrollView 支持侧滑返回
  [self tz_addPopGestureToView:tabHeader];
  
  [[self view] insertSubview:[self tabHeader] atIndex:0];
}

#pragma mark - Public Methods

- (BOOL)isLockBouncesPanGesture
{
  return NO;
}

- (BOOL)selectTabbarIndexAnimation
{
  return NO;
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


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
  return YES;
}


@end



