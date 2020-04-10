
#import "CFCTabScrollView.h"


#define MAP(a, b, c) MIN(MAX(a, b), c)

@interface CFCTabScrollView ()

- (void)_initTabbatAtIndex:(NSInteger)index;

@property (strong, nonatomic) NSArray *tabViews;
@property (strong, nonatomic) NSLayoutConstraint *tabIndicatorDisplacement;
@property (strong, nonatomic) NSLayoutConstraint *tabIndicatorWidth;

@property (strong, nonatomic) UIView *lastSelectTabView;
@property (strong, nonatomic) UIColor *tabTitleNormalColor;
@property (strong, nonatomic) UIColor *tabTitleSelectColor;

@end

@implementation CFCTabScrollView

#pragma mark - Initialize Methods

- (instancetype)initWithFrame:(CGRect)frame tabViews:(NSArray *)tabViews tabBarHeight:(CGFloat)height tabIndicatorHeight:(CGFloat)tabIndicatorHeight tabIndicatorColor:(UIColor *)tabIndicatorColor tabLineColor:(UIColor *)tabLineColor backgroundColor:(UIColor *)backgroundColor tabTitleNormalColor:(UIColor *)tabTitleNormalColor tabTitleSelectColor:(UIColor *)tabTitleSelectColor selectedTabIndex:(NSInteger)index  tabHeaderDirection:(CFCTabPagerHeaderDirection)tabHeaderDirection {
  self = [self initWithFrame:frame tabViews:tabViews tabBarHeight:height tabIndicatorHeight:tabIndicatorHeight tabIndicatorColor:tabIndicatorColor tabLineColor:tabLineColor backgroundColor:backgroundColor tabTitleNormalColor:tabTitleNormalColor tabTitleSelectColor:tabTitleSelectColor tabHeaderDirection:tabHeaderDirection];
  if (self) {
    NSInteger tabIndex = 0;
    if (0 < index && index < tabViews.count) {
      tabIndex = index;
    }
    _lastSelectTabView = self.tabViews[tabIndex];
    _tabTitleNormalColor = tabTitleNormalColor;
    _tabTitleSelectColor = tabTitleSelectColor;
    [self _initTabbatAtIndex:tabIndex];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame tabViews:(NSArray *)tabViews tabBarHeight:(CGFloat)height tabIndicatorHeight:(CGFloat)tabIndicatorHeight tabIndicatorColor:(UIColor *)tabIndicatorColor tabLineColor:(UIColor *)tabLineColor backgroundColor:(UIColor *)backgroundColor tabTitleNormalColor:(UIColor *)tabTitleNormalColor tabTitleSelectColor:(UIColor *)tabTitleSelectColor tabHeaderDirection:(CFCTabPagerHeaderDirection)tabHeaderDirection {
  self = [super initWithFrame:frame];
  
  if (self) {
    [self setShowsHorizontalScrollIndicator:NO];
    [self setBounces:NO];
    
    [self setTabViews:tabViews];
    
    CGFloat width = 10;
    
    for (UIView *view in tabViews) {
      width += view.frame.size.width + 10;
    }
    
    [self setContentSize:CGSizeMake(MAX(width, self.frame.size.width), height)];
    
    CGFloat widthDifference = MAX(0, self.frame.size.width * 1.0f - width);
    
    UIView *contentView = [UIView new];
    [contentView setFrame:CGRectMake(0, 0, MAX(width, self.frame.size.width), height)];
    [contentView setBackgroundColor:backgroundColor];
    [contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:contentView];
    
    NSMutableString *VFL = [NSMutableString stringWithString:@"H:|"];
    NSMutableDictionary *views = [NSMutableDictionary dictionary];
    int index = 0;
    
    for (UIView *tab in tabViews) {
      [contentView addSubview:tab];
      [tab setTranslatesAutoresizingMaskIntoConstraints:NO];
      [VFL appendFormat:@"-%f-[T%d(%f)]", index ? 10.0f : 10.0, index, tab.frame.size.width];
      [views setObject:tab forKey:[NSString stringWithFormat:@"T%d", index]];
      
      [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[T]-2-|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:@{@"T": tab}]];
      [tab setTag:index];
      [tab setUserInteractionEnabled:YES];
      [tab addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabTapHandler:)]];
      
      index++;
    }
    
    [VFL appendString:[NSString stringWithFormat:@"-%f-|", 10.0f + widthDifference]];
    
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:VFL
                                                                        options:0
                                                                        metrics:nil
                                                                          views:views]];
    if (CFCTabPagerHeaderDirectionTop == tabHeaderDirection) {
      
      UIView *bottomLine = [UIView new];
      [bottomLine setTranslatesAutoresizingMaskIntoConstraints:NO];
      [contentView addSubview:bottomLine];
      [bottomLine setBackgroundColor:tabLineColor];
      
      [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[S]-margin-|"
                                                                          options:0
                                                                          metrics:@{@"margin": @(-self.frame.size.width)}
                                                                            views:@{@"S": bottomLine}]];
      
      [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-height-[S(1.5)]-0-|"
                                                                          options:0
                                                                          metrics:@{@"height": @(height - 1.5f)}
                                                                            views:@{@"S": bottomLine}]];
      
    } else  if (CFCTabPagerHeaderDirectionBottom == tabHeaderDirection) {
      
      UIView *topLine = [UIView new];
      [topLine setTranslatesAutoresizingMaskIntoConstraints:NO];
      [contentView addSubview:topLine];
      [topLine setBackgroundColor:tabLineColor];
      
      [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[S]-margin-|"
                                                                          options:0
                                                                          metrics:@{@"margin": @(-self.frame.size.width)}
                                                                            views:@{@"S": topLine}]];
      
      [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[S(1.0)]-height-|"
                                                                          options:0
                                                                          metrics:@{@"height": @(height - 1.0f)}
                                                                            views:@{@"S": topLine}]];
    }
    
    UIView *tabIndicator = [UIView new];
    [tabIndicator setTranslatesAutoresizingMaskIntoConstraints:NO];
    [contentView addSubview:tabIndicator];
    [tabIndicator setBackgroundColor:tabIndicatorColor];
    
    [self setTabIndicatorDisplacement:[NSLayoutConstraint constraintWithItem:tabIndicator
                                                                   attribute:NSLayoutAttributeLeading
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:contentView
                                                                   attribute:NSLayoutAttributeLeading
                                                                  multiplier:1.0f
                                                                    constant:widthDifference / 2 + 5]];
    
    [self setTabIndicatorWidth:[NSLayoutConstraint constraintWithItem:tabIndicator
                                                            attribute:NSLayoutAttributeWidth
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil
                                                            attribute:0
                                                           multiplier:1.0f
                                                             constant:[tabViews[0] frame].size.width + 10]];
    
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[S(%f)]-0-|", tabIndicatorHeight]
                                                                        options:0
                                                                        metrics:nil
                                                                          views:@{@"S": tabIndicator}]];
    
    [contentView addConstraints:@[[self tabIndicatorDisplacement], [self tabIndicatorWidth]]];
  }
  
  return self;
}

#pragma mark - Public Methods

- (void)animateToTabAtIndex:(NSInteger)index {
  [self animateToTabAtIndex:index animated:YES];
}

- (void)animateToTabAtIndex:(NSInteger)index animated:(BOOL)animated {
  CGFloat animatedDuration = 0.4f;
  if (!animated) {
    animatedDuration = 0.0f;
  }
  
  CGFloat x = [[self tabViews][0] frame].origin.x - 5;
  
  for (int i = 0; i < index; i++) {
    x += [[self tabViews][i] frame].size.width + 10;
  }
  
  CGFloat w = [[self tabViews][index] frame].size.width + 10;
  [UIView animateWithDuration:animatedDuration
                   animations:^{
                     
                     CGFloat p = x - (self.frame.size.width - w) / 2;
                     CGFloat min = 0;
                     CGFloat max = MAX(0, self.contentSize.width - self.frame.size.width);
                     
                     [self setContentOffset:CGPointMake(MAP(p, min, max), 0)];
                     [[self tabIndicatorDisplacement] setConstant:x];
                     [[self tabIndicatorWidth] setConstant:w];
                     [self layoutIfNeeded];
                     
                     //
                     if ([self.lastSelectTabView isKindOfClass:[UILabel class]]) {
                       UILabel *label = (UILabel *)self.lastSelectTabView;
                       [label setTextColor:self->_tabTitleNormalColor];
                     }
                     //
                     if ([self.tabViews[index] isKindOfClass:[UILabel class]]) {
                       UILabel *label = (UILabel *)self.tabViews[index];
                       [label setTextColor:self->_tabTitleSelectColor];
                     }
                     [self setLastSelectTabView:self.tabViews[index]];
                     
                   }];
}

- (void)tabTapHandler:(UITapGestureRecognizer *)gestureRecognizer {
  if ([[self tabScrollDelegate] respondsToSelector:@selector(tabScrollView:didSelectTabAtIndex:)]) {
    NSInteger index = [[gestureRecognizer view] tag];
    [[self tabScrollDelegate] tabScrollView:self didSelectTabAtIndex:index];
    [self animateToTabAtIndex:index];
  }
}

#pragma mark - Private Methods

- (void)_initTabbatAtIndex:(NSInteger)index {
  CGFloat x = [[self tabViews][0] frame].origin.x - 5;
  
  for (int i = 0; i < index; i++) {
    x += [[self tabViews][i] frame].size.width + 10;
  }
  
  CGFloat w = [[self tabViews][index] frame].size.width + 10;
  
  CGFloat p = x - (self.frame.size.width - w) / 2;
  CGFloat min = 0;
  CGFloat max = MAX(0, self.contentSize.width - self.frame.size.width);
  
  [self setContentOffset:CGPointMake(MAP(p, min, max), 0)];
  
  UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
  if (orientation == UIDeviceOrientationLandscapeLeft ||
      orientation == UIDeviceOrientationLandscapeRight) {
    x = x + (w/2);
  }
  
  [[self tabIndicatorDisplacement] setConstant:x];
  [[self tabIndicatorWidth] setConstant:w];
  [self layoutIfNeeded];
}


@end


