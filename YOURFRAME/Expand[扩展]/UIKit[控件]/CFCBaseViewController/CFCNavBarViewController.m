
#import "CFCNavBarViewController.h"
#import "CFCSysCoreMacro.h"
#import "CFCStringMacro.h"
#import "CFCAssetsMacro.h"
#import "CFCSysUtil.h"
#import "CFCAutosizingUtil.h"
#import "CFCSysConst.h"
#import "UIImage+Effect.h"
#import "UIImage+Resize.h"
#import "UIColor+Extension.h"
#import "NSObject+System.h"
#import "NSString+Size.h"

@implementation CFCNavigationBarTitleView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
@end

@interface CFCNavBarViewController ()
@property (nonatomic, strong) UILabel *navigationBarTitleLabel; // 导航栏标题
@end

@implementation CFCNavBarViewController

#pragma mark -
#pragma mark 视图生命周期（加载视图）
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 导航栏类型
    switch ([self preferredNavigationBarType]) {
            // 默认系统导航栏
        case CFCNavBarTypeDefault: {
            [self setFd_prefersNavigationBarHidden:[self prefersNavigationBarHidden]];
            break;
        }
            // 自定义导航栏（隐藏系统导航栏，自定义导航栏）
        case CFCNavBarTypeCustom: {
            [self setFd_prefersNavigationBarHidden:YES];
            break;
        }
        default: {
            break;
        }
    }
    
    // 自定义配置导航栏
    [self setupNavigationBar];
}

#pragma mark 视图生命周期（将要显示）
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 设置导航条背景
    if (!self.fd_prefersNavigationBarHidden) {
        [self setupNavigationBarBackgroundColor];
    }
}

#pragma mark 自定义配置导航栏
- (void)setupNavigationBar
{
    // 导航栏类型
    switch ([self preferredNavigationBarType]) {
            // 默认系统导航栏
        case CFCNavBarTypeDefault: {
            [self setupNavigationBarDefault];
            break;
        }
            // 自定义导航栏（隐藏系统导航栏，自定义导航栏）
        case CFCNavBarTypeCustom: {
            [self setupNavigationBarCustom];
            break;
        }
        default: {
            break;
        }
    }
}

#pragma mark 设置导航栏按钮、标题区域内容
- (void)setupNavigationBarView
{
    // 导航栏类型
    switch ([self preferredNavigationBarType]) {
            // 默认系统导航栏
        case CFCNavBarTypeDefault: {
            [self setupNavigationBarViewDefault];
            break;
        }
            // 自定义导航栏（隐藏系统导航栏，自定义导航栏）
        case CFCNavBarTypeCustom: {
            [self setupNavigationBarViewCustom];
            break;
        }
        default: {
            break;
        }
    }
}


#pragma mark 创建导航栏标题控件
- (void)createNavigationBarTitleView:(UIView *)navigationBarTitleView
{
    UILabel *label = [[UILabel alloc] initWithFrame:navigationBarTitleView.bounds];
    NSInteger titleLength = self.navigationBarTitleViewTitle.length > NAVIGATION_BAR_TITLE_MAX_NUM ? NAVIGATION_BAR_TITLE_MAX_NUM :self.navigationBarTitleViewTitle.length;
    [label setText:[self.navigationBarTitleViewTitle substringToIndex:titleLength]];
    [label setFont:[self prefersNavigationBarTitleFont]];
    [label setTextColor:[self prefersNavigationBarTitleColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [navigationBarTitleView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(navigationBarTitleView.mas_centerX);
        make.centerY.equalTo(navigationBarTitleView.mas_centerY);
    }];
    
    // 导航标题栏
    self.navigationBarTitleLabel = label;
}



#pragma mark -
#pragma mark 设置状态栏是否隐藏
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

#pragma mark 设置状态的栏背景色
- (UIColor *)prefersStatusBarColor
{
    return [self prefersNavigationBarColor];
}

#pragma mark 设置状态栏样式类型
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark 设置状态栏隐藏动画
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return UIStatusBarAnimationSlide;
}

#pragma mark 设置导航条是否隐藏
- (BOOL)prefersNavigationBarHidden
{
    return NO;
}

#pragma mark 设置导航条样式类型（默认:CFCNavBarTypeDefault）
- (CFCNavBarType)preferredNavigationBarType
{
    return CFCNavBarTypeDefault;
}

#pragma mark 设置导航条背景颜色
- (UIColor *)prefersNavigationBarColor
{
    return COLOR_NAVIGATION_BAR_BACKGROUND_DEFAULT;
}

#pragma mark 设置导航条背景图片
- (UIImage *)prefersNavigationBarBackgroundImage
{
    return [UIImage imageWithColor:[self prefersNavigationBarColor] andSize:CGSizeMake(self.navigationController.navigationBar.frame.size.width, STATUS_NAVIGATION_BAR_HEIGHT)];
}

#pragma mark 设置导航条背景图片（是否强制使用图片）
- (BOOL)prefersNavigationBarBackgroundImageForce
{
    return NO;
}

#pragma mark 设置导航栏底部横线高度（默认1.0）
- (CGFloat)prefersNavigationBarHairlineHeight
{
    return NAVIGATION_BAR_HAIR_LINE_HEIGHT_DEFAULT;
}

#pragma mark 设置导航栏底部横线背景颜色
- (UIColor *)prefersNavigationBarHairlineColor
{
    return COLOR_NAVIGATION_BAR_HAIR_LINE_DEFAULT;
}

#pragma mark 设置导航条标题字体
- (UIFont *)prefersNavigationBarTitleFont
{
    return FONT_NAVIGATION_BAR_TITLE_DEFAULT;
}

#pragma mark 设置导航条标题颜色
- (UIColor *)prefersNavigationBarTitleColor
{
    return COLOR_NAVIGATION_BAR_TITLE_DEFAULT;
}

#pragma mark 设置导航栏标题文字
- (NSString *)prefersNavigationBarTitleViewTitle
{
    return self.title;
}

#pragma mark 导航栏左边按钮类型（默认"返回"按钮）
- (CFCNavBarButtonItemType)prefersNavigationBarLeftButtonItemType
{
    if (self.navigationController.viewControllers.count > 1) {
        return CFCNavBarButtonItemTypeDefault;
    }
    if (![STR_NAVIGATION_BAR_BUTTON_TITLE_RETURN_BACK isEqualToString:[self prefersNavigationBarLeftButtonItemTitle]]) {
        return CFCNavBarButtonItemTypeCustom;
    }
    return CFCNavBarButtonItemTypeNone;
}

#pragma mark 导航栏右边按钮类型（默认 "" 按钮）
- (CFCNavBarButtonItemType)prefersNavigationBarRightButtonItemType
{
    if (![STR_NAVIGATION_BAR_BUTTON_TITLE_EMPTY isEqualToString:[self prefersNavigationBarRightButtonItemTitle]]) {
        return CFCNavBarButtonItemTypeCustom;
    }
    return CFCNavBarButtonItemTypeNone;
}

#pragma mark 设置导航栏左边按钮控件标题（默认“返回”）
- (NSString *)prefersNavigationBarLeftButtonItemTitle
{
    return STR_NAVIGATION_BAR_BUTTON_TITLE_RETURN_BACK;
}

#pragma mark 设置导航栏右边按钮控件标题（默认“”）
- (NSString *)prefersNavigationBarRightButtonItemTitle
{
    return STR_NAVIGATION_BAR_BUTTON_TITLE_EMPTY;
}

#pragma mark 设置导航栏左边按钮控件标题字体
- (UIFont *)prefersNavigationBarLeftButtonItemTitleFont
{
    return FONT_NAVIGATION_BAR_BUTTON_TITLE_DEFAULT;
}

#pragma mark 设置导航栏右边按钮控件标题字体
- (UIFont *)prefersNavigationBarRightButtonItemTitleFont
{
    return FONT_NAVIGATION_BAR_BUTTON_TITLE_DEFAULT;
}

#pragma mark 设置导航栏左边按钮控件标题颜色（正常）
- (UIColor *)prefersNavigationBarLeftButtonItemTitleColorNormal
{
    return COLOR_NAVIGATION_BAR_BUTTON_TITLE_NORMAL_DEFAULT;
}

#pragma mark 设置导航栏右边按钮控件标题颜色（正常）
- (UIColor *)prefersNavigationBarRightButtonItemTitleColorNormal
{
    return COLOR_NAVIGATION_BAR_BUTTON_TITLE_NORMAL_DEFAULT;
}

#pragma mark 设置导航栏左边按钮控件标题颜色（选中）
- (UIColor *)prefersNavigationBarLeftButtonItemTitleColorSelect
{
    return COLOR_NAVIGATION_BAR_BUTTON_TITLE_SELECT_DEFAULT;
}

#pragma mark 设置导航栏右边按钮控件标题颜色（选中）
- (UIColor *)prefersNavigationBarRightButtonItemTitleColorSelect
{
    return COLOR_NAVIGATION_BAR_BUTTON_TITLE_SELECT_DEFAULT;
}

#pragma mark 设置导航栏左边按钮控件图标（正常）
- (NSString *)prefersNavigationBarLeftButtonItemImageNormal
{
    CFCNavBarButtonItemType barButtonItemType = [self prefersNavigationBarLeftButtonItemType];
    
    switch (barButtonItemType) {
            // 无按钮
        case CFCNavBarButtonItemTypeNone: {
            
            break;
        }
            // 默认返回
        case CFCNavBarButtonItemTypeDefault: {
            return ICON_NAVIGATION_BAR_BUTTON_WHITE_ARROW;
            break;
        }
            // 自定义
        case CFCNavBarButtonItemTypeCustom: {
            
        }
        default: {
            break;
        }
    }
    
    return nil;
}

#pragma mark 设置导航栏右边按钮控件图标（正常）
- (NSString *)prefersNavigationBarRightButtonItemImageNormal
{
    CFCNavBarButtonItemType barButtonItemType = [self prefersNavigationBarRightButtonItemType];
    
    switch (barButtonItemType) {
            // 无按钮
        case CFCNavBarButtonItemTypeNone: {
            
            break;
        }
            // 默认返回
        case CFCNavBarButtonItemTypeDefault: {
            return ICON_NAVIGATION_BAR_BUTTON_WHITE_ARROW;
            break;
        }
            // 自定义
        case CFCNavBarButtonItemTypeCustom: {
            
        }
        default: {
            break;
        }
    }
    
    return nil;
}

#pragma mark 设置导航栏左边按钮控件图标（选中）
- (NSString *)prefersNavigationBarLeftButtonItemImageSelect
{
    CFCNavBarButtonItemType barButtonItemType = [self prefersNavigationBarLeftButtonItemType];
    
    switch (barButtonItemType) {
            // 无按钮
        case CFCNavBarButtonItemTypeNone: {
            
            break;
        }
            // 默认返回
        case CFCNavBarButtonItemTypeDefault: {
            return ICON_NAVIGATION_BAR_BUTTON_WHITE_ARROW;
            break;
        }
            // 自定义
        case CFCNavBarButtonItemTypeCustom: {
            
        }
        default: {
            break;
        }
    }
    
    return nil;
}

#pragma mark 设置导航栏右边按钮控件图标（选中）
- (NSString *)prefersNavigationBarRightButtonItemImageSelect
{
    CFCNavBarButtonItemType barButtonItemType = [self prefersNavigationBarRightButtonItemType];
    
    switch (barButtonItemType) {
            // 无按钮
        case CFCNavBarButtonItemTypeNone: {
            
            break;
        }
            // 默认返回
        case CFCNavBarButtonItemTypeDefault: {
            return ICON_NAVIGATION_BAR_BUTTON_WHITE_ARROW;
            break;
        }
            // 自定义
        case CFCNavBarButtonItemTypeCustom: {
            
        }
        default: {
            break;
        }
    }
    
    return nil;
}

#pragma mark 点击导航栏左侧按钮事件
- (void)pressNavigationBarLeftButtonItem:(id)sender;
{
    CFCNavBarButtonItemType barButtonItemType = [self prefersNavigationBarLeftButtonItemType];
    
    switch (barButtonItemType) {
            // 无按钮
        case CFCNavBarButtonItemTypeNone: {
            
            break;
        }
            // 默认返回
        case CFCNavBarButtonItemTypeDefault: {
            
            [self.navigationController popViewControllerAnimated:YES];
            
            break;
        }
            // 自定义
        case CFCNavBarButtonItemTypeCustom: {
            // 子类继承此方法进行处理
            break;
        }
        default:
            break;
    }
    
}

#pragma mark 点击导航栏右侧按钮事件
- (void)pressNavigationBarRightButtonItem:(id)sender
{
    CFCNavBarButtonItemType barButtonItemType = [self prefersNavigationBarRightButtonItemType];
    
    switch (barButtonItemType) {
            // 无按钮
        case CFCNavBarButtonItemTypeNone: {
            
            break;
        }
            // 默认返回
        case CFCNavBarButtonItemTypeDefault: {
            
            [self.navigationController popViewControllerAnimated:YES];
            
            break;
        }
            // 自定义
        case CFCNavBarButtonItemTypeCustom: {
            // 子类继承此方法进行处理
            break;
        }
        default:
            break;
    }
}




#pragma mark 创建导航栏左边按钮控件
- (UIView *)createNavigationBarLeftButtonItem
{
    UIView *ctl_btn = nil;
    
    CFCNavBarButtonItemType barButtonItemType = [self prefersNavigationBarLeftButtonItemType];
    UIFont *titleFont = [self prefersNavigationBarLeftButtonItemTitleFont];
    UIColor *titleNormalColor = [self prefersNavigationBarLeftButtonItemTitleColorNormal];
    UIColor *titleSelectColor = [self prefersNavigationBarLeftButtonItemTitleColorSelect];
    NSString *iconNameNormal = [self prefersNavigationBarLeftButtonItemImageNormal];
    NSString *iconNameSelect = [self prefersNavigationBarLeftButtonItemImageSelect];
    NSString *title = (nil == [self navigationBarLeftButtonItemTitle]) ? @"": [self navigationBarLeftButtonItemTitle];
    SEL actionSel = @selector(pressNavigationBarLeftButtonItem:);
    
    switch (barButtonItemType) {
            // 无按钮
        case CFCNavBarButtonItemTypeNone: {
            ctl_btn = [[UIView alloc] initWithFrame:CGRectZero];
            break;
        }
            // 默认返回
        case CFCNavBarButtonItemTypeDefault: {
            ctl_btn = [self createNavigationBarButtonItemTypeDefaultTitle:title
                                                         titleNormalColor:titleNormalColor
                                                         titleSelectColor:titleSelectColor
                                                                titleFont:titleFont
                                                           iconNameNormal:iconNameNormal
                                                           iconNameSelect:iconNameSelect
                                                                   action:actionSel];
            break;
        }
            // 自定义
        case CFCNavBarButtonItemTypeCustom: {
            ctl_btn = [self createNavigationBarButtonItemTypeCustomTitle:title
                                                        titleNormalColor:titleNormalColor
                                                        titleSelectColor:titleSelectColor
                                                               titleFont:titleFont
                                                          iconNameNormal:iconNameNormal
                                                          iconNameSelect:iconNameSelect
                                                                  action:actionSel];
        }
        default: {
            break;
        }
    }
    
    return ctl_btn;
}


#pragma mark 创建导航栏右边按钮控件
- (UIView *)createNavigationBarRightButtonItem
{
    UIView *ctl_btn = nil;
    
    CFCNavBarButtonItemType barButtonItemType = [self prefersNavigationBarRightButtonItemType];
    UIFont *titleFont = [self prefersNavigationBarRightButtonItemTitleFont];
    UIColor *titleNormalColor = [self prefersNavigationBarRightButtonItemTitleColorNormal];
    UIColor *titleSelectColor = [self prefersNavigationBarRightButtonItemTitleColorSelect];
    NSString *iconNameNormal = [self prefersNavigationBarRightButtonItemImageNormal];
    NSString *iconNameSelect = [self prefersNavigationBarRightButtonItemImageSelect];
    NSString *title = (nil == [self navigationBarRightButtonItemTitle]) ? @"": [self navigationBarRightButtonItemTitle];
    SEL actionSel = @selector(pressNavigationBarRightButtonItem:);
    
    switch (barButtonItemType) {
            // 无按钮
        case CFCNavBarButtonItemTypeNone: {
            ctl_btn = [[UIView alloc] initWithFrame:CGRectZero];
            break;
        }
            // 默认返回
        case CFCNavBarButtonItemTypeDefault: {
            ctl_btn = [self createNavigationBarButtonItemTypeDefaultTitle:title
                                                         titleNormalColor:titleNormalColor
                                                         titleSelectColor:titleSelectColor
                                                                titleFont:titleFont
                                                           iconNameNormal:iconNameNormal
                                                           iconNameSelect:iconNameSelect
                                                                   action:actionSel];
            break;
        }
            // 自定义
        case CFCNavBarButtonItemTypeCustom: {
            ctl_btn = [self createNavigationBarButtonItemTypeCustomTitle:title
                                                        titleNormalColor:titleNormalColor
                                                        titleSelectColor:titleSelectColor
                                                               titleFont:titleFont
                                                          iconNameNormal:iconNameNormal
                                                          iconNameSelect:iconNameSelect
                                                                  action:actionSel];
        }
        default: {
            break;
        }
    }
    
    
    return ctl_btn;
}

#pragma mark 创建导航栏按钮控件CFCNavBarButtonItemTypeDefault
- (UIView *)createNavigationBarButtonItemTypeDefaultTitle:(NSString *)title
                                         titleNormalColor:(UIColor *)normalColor
                                         titleSelectColor:(UIColor *)selectColor
                                                titleFont:(UIFont *)font
                                           iconNameNormal:(NSString *)iconNameNormal
                                           iconNameSelect:(NSString *)iconNameSelect
                                                   action:(SEL)action
{
    // 自定义按钮
    UIButton *btn = [[UIButton alloc] init];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 默认显示图片
    if (iconNameNormal) {
        CGFloat imageSizeWidth = CFC_AUTOSIZING_WIDTH(12.0f);
        CGFloat imageSizeHeight = CFC_AUTOSIZING_HEIGTH(20.0f);
        CGRect btnFrame = CGRectMake(0, 0, CFC_AUTOSIZING_WIDTH(NAVIGATION_BAR_BUTTON_MAX_WIDTH), NAVIGATION_BAR_HEIGHT);
        [btn setFrame:btnFrame];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [btn setImage:[[UIImage imageNamed:iconNameNormal] imageByScalingProportionallyToSize:CGSizeMake(imageSizeWidth, imageSizeHeight)]
             forState:UIControlStateNormal];
        [btn setImage:[[UIImage imageNamed:iconNameSelect] imageByScalingProportionallyToSize:CGSizeMake(imageSizeWidth, imageSizeHeight)]
             forState:UIControlStateHighlighted];
    }
    
    // 设置显示标题
    if (title.length > 0) {
        // 按钮正常标题
        NSMutableAttributedString *attributedNormalTitle = [[NSMutableAttributedString alloc] initWithString:title];
        [attributedNormalTitle addAttribute:NSForegroundColorAttributeName value:normalColor range:NSMakeRange(0, title.length)];
        [attributedNormalTitle addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, title.length)];
        CGFloat titleWidth = [title widthWithFont:font constrainedToHeight:NAVIGATION_BAR_HEIGHT];
        // 按钮选中标题
        NSMutableAttributedString *attributedSelectTitle = [[NSMutableAttributedString alloc] initWithString:title];
        [attributedSelectTitle addAttribute:NSForegroundColorAttributeName value:selectColor range:NSMakeRange(0, title.length)];
        [attributedSelectTitle addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, title.length)];
        // 设置显示标题
        [btn setAttributedTitle:attributedNormalTitle forState:UIControlStateNormal];
        [btn setAttributedTitle:attributedSelectTitle forState:UIControlStateHighlighted];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        // 调整控件大小
        CGFloat maxWidth = MAX(MARGIN*2.5+titleWidth, CFC_AUTOSIZING_WIDTH(NAVIGATION_BAR_BUTTON_MAX_WIDTH));
        CGRect btnFrame = CGRectMake(0.0f, 0.0f, maxWidth, NAVIGATION_BAR_HEIGHT);
        [btn setFrame:btnFrame];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, -MARGIN)];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, -MARGIN/2.0f)];
    }
    
    return btn;
}

#pragma mark 创建导航栏按钮控件CFCNavBarButtonItemTypeCustom
- (UIView *)createNavigationBarButtonItemTypeCustomTitle:(NSString *)title
                                        titleNormalColor:(UIColor *)normalColor
                                        titleSelectColor:(UIColor *)selectColor
                                               titleFont:(UIFont *)font
                                          iconNameNormal:(NSString *)iconNameNormal
                                          iconNameSelect:(NSString *)iconNameSelect
                                                  action:(SEL)action
{
    // 按钮正常标题
    NSMutableAttributedString *attributedNormalTitle = [[NSMutableAttributedString alloc] initWithString:title];
    [attributedNormalTitle addAttribute:NSForegroundColorAttributeName value:normalColor range:NSMakeRange(0, title.length)];
    [attributedNormalTitle addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, title.length)];
    CGFloat titleWidth = [title widthWithFont:font constrainedToHeight:NAVIGATION_BAR_HEIGHT];
    
    // 按钮选中标题
    NSMutableAttributedString *attributedSelectTitle = [[NSMutableAttributedString alloc] initWithString:title];
    [attributedSelectTitle addAttribute:NSForegroundColorAttributeName value:selectColor range:NSMakeRange(0, title.length)];
    [attributedSelectTitle addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, title.length)];
    
    // 自定义按钮
    CGFloat imageSize = CFC_AUTOSIZING_WIDTH(20.0f);
    CGFloat maxWidth = MAX(MARGIN*1.5+titleWidth, NAVIGATION_BAR_BUTTON_MAX_WIDTH); // 按钮最大宽度
    CGRect btnFrame = CGRectMake(0, 0, maxWidth, NAVIGATION_BAR_HEIGHT);
    UIButton *btn = [[UIButton alloc] initWithFrame:btnFrame];
    [btn setAttributedTitle:attributedNormalTitle forState:UIControlStateNormal];
    [btn setAttributedTitle:attributedSelectTitle forState:UIControlStateHighlighted];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    if (![CFCSysUtil validateStringEmpty:iconNameNormal] && [CFCSysUtil validateStringEmpty:iconNameSelect]) {
        iconNameSelect = iconNameNormal;
    }
    if ([CFCSysUtil validateStringEmpty:iconNameNormal] && ![CFCSysUtil validateStringEmpty:iconNameSelect]) {
        iconNameNormal = iconNameSelect;
    }
    if (iconNameNormal) {
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [btn setImage:[[UIImage imageNamed:iconNameNormal] imageByScalingProportionallyToSize:CGSizeMake(imageSize, imageSize)]
             forState:UIControlStateNormal];
        [btn setImage:[[UIImage imageNamed:iconNameSelect] imageByScalingProportionallyToSize:CGSizeMake(imageSize, imageSize)]
             forState:UIControlStateHighlighted];
    }
    return btn;
}


#pragma mark - Private
#pragma mark 自定义配置导航栏（默认系统导航栏）
- (void)setupNavigationBarDefault
{
    // 找出导航条底部横线并隐藏
    {
        UIImageView *hairLineImageView = [self findNavigationBarHairlineImageView:self.navigationController.navigationBar];
        [self setNavigationBarHairlineImageView:hairLineImageView];
        [self.navigationBarHairlineImageView setHidden:(0.0 == [self prefersNavigationBarHairlineHeight] ? YES : NO)];
    }
    
    // 隐藏导航条、不隐藏状态栏、导航条为空
    if (!self.naviStatusBarCustomView && [self prefersNavigationBarHidden] && ![self prefersStatusBarHidden] ) {
        
        // 显示导航条+状态栏父容器大小
        CGRect naviStatusBarFrame = CGRectMake(0, 0, SCREEN_WIDTH, STATUS_NAVIGATION_BAR_HEIGHT);
        
        // 显示导航条容器大小
        CGRect navigationBarFrame = CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH, NAVIGATION_BAR_HEIGHT);
        
        // 显示状态栏
        if ([self prefersNavigationBarHidden] && ![self prefersStatusBarHidden]) {
            naviStatusBarFrame = CGRectMake(0, 0, SCREEN_WIDTH, STATUS_BAR_HEIGHT);
            navigationBarFrame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
        }
        
        // 导航栏+状态栏容器
        UIView *naviStatusBarCustomView = ({
            UIView *view = [[UIView alloc] initWithFrame:naviStatusBarFrame];
            [view setTag:STATUS_NAVIGATION_BAR_TAG];
            [view setBackgroundColor:[self prefersStatusBarColor]];
            [self.view addSubview:view];
            
            view;
        });
        self.naviStatusBarCustomView = naviStatusBarCustomView;
        
        // 自定义导航条视图
        UIView *navigationBarCustomView = ({
            UIView *view = [[UIView alloc] initWithFrame:navigationBarFrame];
            [view setBackgroundColor:[self prefersNavigationBarColor]];
            [naviStatusBarCustomView addSubview:view];
            
            view;
        });
        self.navigationBarCustomView = navigationBarCustomView;
        
        // 底部发丝线
        UIView *navigationBarHairlineImageView = ({
            UIView *view = [[UIView alloc] init];
            CGFloat navigationBarHairlineHeight = [self prefersNavigationBarHidden] ? 0 : [self prefersNavigationBarHairlineHeight];
            [view setFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT-navigationBarHairlineHeight, SCREEN_WIDTH, navigationBarHairlineHeight)];
            [view setBackgroundColor:[self prefersNavigationBarHairlineColor]];
            [navigationBarCustomView addSubview:view];
            
            view;
        });
        self.navigationBarHairlineImageView = navigationBarHairlineImageView;
    }
    
    // 隐藏导航条
    if ([self prefersNavigationBarHidden]) {
        return;
    }
    
    // 设置导航栏按钮、标题区域内容
    [self setupNavigationBarView];
}


#pragma mark 自定义配置导航栏（隐藏系统导航栏，自定义导航栏）
- (void)setupNavigationBarCustom
{
    // 导航条和状态栏都隐藏
    if ([self prefersNavigationBarHidden] && [self prefersStatusBarHidden]) {
        return;
    }
    
    // 如果导航条为空，则创建导航条视图
    if (!self.navigationBarCustomView) {
        
        // 显示导航条+状态栏父容器大小
        CGRect naviStatusBarFrame = CGRectMake(0, 0, SCREEN_WIDTH, STATUS_NAVIGATION_BAR_HEIGHT);
        
        // 显示导航条容器大小
        CGRect navigationBarFrame = CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH, NAVIGATION_BAR_HEIGHT);
        
        // 显示状态栏
        if ([self prefersNavigationBarHidden] && ![self prefersStatusBarHidden]) {
            naviStatusBarFrame = CGRectMake(0, 0, SCREEN_WIDTH, STATUS_BAR_HEIGHT);
            navigationBarFrame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
        }
        // 显示导航条
        else if (![self prefersNavigationBarHidden] && [self prefersStatusBarHidden]) {
            naviStatusBarFrame = CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATION_BAR_HEIGHT);
            navigationBarFrame = CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATION_BAR_HEIGHT);
        }
        // 显示状态栏+导航条
        else if (![self prefersNavigationBarHidden] && ![self prefersStatusBarHidden]) {
            naviStatusBarFrame = CGRectMake(0, 0, SCREEN_WIDTH, STATUS_NAVIGATION_BAR_HEIGHT);
            navigationBarFrame = CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH, NAVIGATION_BAR_HEIGHT);
        }
        
        // 状态栏+导航条容器（64）
        UIView *naviStatusBarCustomView = ({
            UIView *view = [[UIView alloc] initWithFrame:naviStatusBarFrame];
            [view setBackgroundColor:[self prefersStatusBarColor]];
            [self.view addSubview:view];
            
            view;
        });
        self.naviStatusBarCustomView = naviStatusBarCustomView;
        
        // 导航条容器（44）
        if (![self prefersNavigationBarHidden]) {
            // 自定义导航条视图
            UIView *navigationBarCustomView = ({
                UIView *view = [[UIView alloc] initWithFrame:navigationBarFrame];
                [view setBackgroundColor:[self prefersNavigationBarColor]];
                [naviStatusBarCustomView addSubview:view];
                
                view;
            });
            self.navigationBarCustomView = navigationBarCustomView;
            
            // 导航条底部发丝线z
            UIView *navigationBarHairlineImageView = ({
                UIView *view = [[UIView alloc] init];
                CGFloat navigationBarHairlineHeight = [self prefersNavigationBarHidden] ? 0 : [self prefersNavigationBarHairlineHeight];
                [view setFrame:CGRectMake(0, navigationBarFrame.size.height-navigationBarHairlineHeight, navigationBarFrame.size.width, navigationBarHairlineHeight)];
                [view setBackgroundColor:[self prefersNavigationBarHairlineColor]];
                [navigationBarCustomView addSubview:view];
                
                view;
            });
            self.navigationBarHairlineImageView = navigationBarHairlineImageView;
        }
        
        // 是否强制使用图片设置导航条背景
        if ([self prefersNavigationBarBackgroundImageForce]) {
            // 使用图片设置导航栏背景
            [self.navigationBarCustomView setBackgroundColor:[UIColor clearColor]];
            UIImageView *navBackgroundImage = [[UIImageView alloc] initWithFrame:self.naviStatusBarCustomView.frame];
            [navBackgroundImage setUserInteractionEnabled:YES];
            [navBackgroundImage setImage:[self prefersNavigationBarBackgroundImage]];
            [self.naviStatusBarCustomView insertSubview:navBackgroundImage belowSubview:self.navigationBarCustomView];
        }
    }
    
    // 隐藏导航条
    if ([self prefersNavigationBarHidden]) {
        return;
    }
    
    // 设置导航栏按钮、标题区域内容
    [self setupNavigationBarView];
}


#pragma mark 设置导航栏按钮、标题区域内容（默认系统导航栏）
- (void)setupNavigationBarViewDefault
{
    // 设置导航条背景
    [self setupNavigationBarBackgroundColor];
    
    
    // 左选项按钮
    if ([self prefersNavigationBarLeftButtonItemType]) {
        // 设置按钮标题
        [self setupNavigationBarLeftButtonItemTitle];
        // 创建按钮控件
        self.navigationBarLeftButtonItem = [self createNavigationBarLeftButtonItem];
        if (self.navigationBarLeftButtonItem) {
            // 调整控件位置
            UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.navigationBarLeftButtonItem];
            if([[NSObject OSVersion] floatValue] >= 11.0) {
                [self.navigationItem setLeftBarButtonItem:leftItem];
            } else if([[NSObject OSVersion] floatValue] >= 7.0) {
                /**
                 * width为正数时，相当于UIButton向右移动width数值个像素
                 * width为负数时，正好相反，相当于往左移动width数值个像素
                 */
                UIBarButtonItem *spacerItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                            target:nil
                                                                                            action:nil];
                spacerItem.width = -CFC_AUTOSIZING_WIDTH(NAVIGATION_BAR_SCREEN_MARGIN*2.0);
                [[self navigationItem] setLeftBarButtonItems:@[spacerItem, leftItem]];
            } else {
                [[self navigationItem] setLeftBarButtonItem:leftItem  animated:NO];
            }
            
            // 验证是否为UIControl
            if ([self.navigationBarLeftButtonItem isKindOfClass:[UIControl class]]) {
                [(UIControl *)self.navigationBarLeftButtonItem addTarget:self
                                                                  action:@selector(pressNavigationBarLeftButtonItem:)
                                                        forControlEvents:UIControlEventTouchUpInside];
            } else {
                //
                
            }
        }
    }
    
    
    // 右选项按钮
    if ([self prefersNavigationBarRightButtonItemType]) {
        // 设置按钮标题
        [self setupNavigationBarRightButtonItemTitle];
        // 创建按钮控件
        self.navigationBarRightButtonItem = [self createNavigationBarRightButtonItem];
        if (self.navigationBarRightButtonItem) {
            // 调整控件位置
            UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.navigationBarRightButtonItem];
            if([[NSObject OSVersion] floatValue] >= 11.0) {
                [[self navigationItem] setRightBarButtonItem:rightItem];
            } else if([[NSObject OSVersion] floatValue] >= 7.0) {
                /**
                 * width为正数时，相当于UIButton向左移动width数值个像素
                 * width为负数时，正好相反，相当于往右移动width数值个像素
                 */
                UIBarButtonItem *spacerItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                            target:nil
                                                                                            action:nil];
                spacerItem.width = -CFC_AUTOSIZING_WIDTH(NAVIGATION_BAR_SCREEN_MARGIN*2.0);
                [[self navigationItem] setRightBarButtonItems:@[spacerItem, rightItem]];
            } else {
                [[self navigationItem] setRightBarButtonItem:rightItem  animated:NO];
            }
            
            // 验证是否为UIControl
            if ([self.navigationBarRightButtonItem isKindOfClass:[UIControl class]]) {
                [(UIControl *)self.navigationBarRightButtonItem addTarget:self
                                                                   action:@selector(pressNavigationBarRightButtonItem:)
                                                         forControlEvents:UIControlEventTouchUpInside];
            } else {
                //
                
            }
            
        }
    }
    
    
    // 标题区域
    {
        CGFloat maxWidth = MAX(CGRectGetWidth(self.navigationBarLeftButtonItem.frame) , CGRectGetWidth(self.navigationBarRightButtonItem.frame)) + NAVIGATION_BAR_SCREEN_MARGIN;
        CGRect titleRect = CGRectMake(0, 0, SCREEN_WIDTH - 2*maxWidth, NAVIGATION_BAR_HEIGHT);
        //CGRect titleRect = CGRectMake(SCREEN_WIDTH/2.0, 0, NAVIGATION_BAR_HEIGHT, NAVIGATION_BAR_HEIGHT);
        UIView *titleContainerView = [[CFCNavigationBarTitleView alloc] initWithFrame:titleRect];
        [self setNavigationBarTitleView:titleContainerView];
        [self.navigationItem setTitleView:titleContainerView];
        
        // 导航条标题视图配置
        [self setNavigationBarTitleViewTitle:[self prefersNavigationBarTitleViewTitle]];
        [self createNavigationBarTitleView:self.navigationBarTitleView];
    }
    
}


#pragma mark 设置导航栏按钮、标题区域内容（隐藏系统导航栏，自定义导航栏）
- (void)setupNavigationBarViewCustom
{
    // 隐藏系统默认的导航按钮
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    [[self navigationItem] setLeftBarButtonItem:leftItem  animated:NO];
    [[self navigationItem] setRightBarButtonItem:rightItem  animated:NO];
    
    
    // 左选项按钮
    if ([self prefersNavigationBarLeftButtonItemType]) {
        // 设置按钮标题
        [self setupNavigationBarLeftButtonItemTitle];
        // 创建按钮控件
        self.navigationBarLeftButtonItem = [self createNavigationBarLeftButtonItem];
        if (self.navigationBarLeftButtonItem) {
            // 调整控件位置
            CGRect frame = CGRectMake(self.navigationBarLeftButtonItem.frame.origin.x,
                                      self.navigationBarLeftButtonItem.frame.origin.y,
                                      self.navigationBarLeftButtonItem.frame.size.width,
                                      self.navigationBarLeftButtonItem.frame.size.height);
            [self.navigationBarLeftButtonItem setFrame:frame];
            [self.navigationBarCustomView addSubview:self.navigationBarLeftButtonItem];
            
            // 验证是否为UIControl
            if ([self.navigationBarLeftButtonItem isKindOfClass:[UIControl class]]) {
                [(UIControl *)self.navigationBarLeftButtonItem addTarget:self
                                                                  action:@selector(pressNavigationBarLeftButtonItem:)
                                                        forControlEvents:UIControlEventTouchUpInside];
            } else {
                //
                
            }
        }
    }
    
    
    // 右选项按钮
    if ([self prefersNavigationBarRightButtonItemType]) {
        // 设置按钮标题
        [self setupNavigationBarRightButtonItemTitle];
        // 创建按钮控件
        self.navigationBarRightButtonItem = [self createNavigationBarRightButtonItem];
        if (self.navigationBarRightButtonItem) {
            // 调整控件位置
            CGRect frame = CGRectMake(SCREEN_WIDTH - self.navigationBarRightButtonItem.frame.size.width,
                                      self.navigationBarRightButtonItem.frame.origin.y,
                                      self.navigationBarRightButtonItem.frame.size.width,
                                      self.navigationBarRightButtonItem.frame.size.height);
            [self.navigationBarRightButtonItem setFrame:frame];
            [self.navigationBarCustomView addSubview:self.navigationBarRightButtonItem];
            
            // 验证是否为UIControl
            if ([self.navigationBarRightButtonItem isKindOfClass:[UIControl class]]) {
                [(UIControl *)self.navigationBarRightButtonItem addTarget:self
                                                                   action:@selector(pressNavigationBarRightButtonItem:)
                                                         forControlEvents:UIControlEventTouchUpInside];
            } else {
                //
                
            }
        }
    }
    
    
    // 标题区域
    {
        CGFloat maxWidth = MAX(CGRectGetWidth(self.navigationBarLeftButtonItem.frame) , CGRectGetWidth(self.navigationBarRightButtonItem.frame));
        CGRect titleRect = CGRectMake(maxWidth, 0, SCREEN_WIDTH - 2*maxWidth, NAVIGATION_BAR_HEIGHT);
        UIView *titleContainerView = [[UIView alloc] initWithFrame:titleRect];
        [self setNavigationBarTitleView:titleContainerView];
        [self.navigationBarCustomView addSubview:titleContainerView];
        
        // 导航条标题视图配置
        [self setNavigationBarTitleViewTitle:[self prefersNavigationBarTitleViewTitle]];
        [self createNavigationBarTitleView:self.navigationBarTitleView];
    }
    
}


#pragma mark 设置导航栏背景色
- (void)setupNavigationBarBackgroundColor
{
    // 导航栏类型
    switch ([self preferredNavigationBarType]) {
            // 默认系统导航栏
        case CFCNavBarTypeDefault: {
            [self setupNavigationBarBackgroundColorDefault];
            break;
        }
            // 自定义导航栏（隐藏系统导航栏，自定义导航栏）
        case CFCNavBarTypeCustom: {
            // 设置自定义导航条背景色
            [self.navigationBarCustomView setBackgroundColor:[self prefersNavigationBarColor]];
            break;
        }
        default: {
            break;
        }
    }
    
}


#pragma mark 设置导航栏背景色（默认系统导航栏）
- (void)setupNavigationBarBackgroundColorDefault
{
    // 是否强制使用图片设置导航条背景
    if (![self prefersNavigationBarBackgroundImageForce]) {
        
        // 方法一：设置导航条背景（颜色）
        if ([self prefersNavigationBarColor]) {
            // 设置是否有透明度(默认导航条是有透明度的)
            [self.navigationController.navigationBar setTranslucent:NO];
            // 设置导航条的颜色，这个改变的是导航条的背景色
            [self.navigationController.navigationBar setBarTintColor:[self prefersNavigationBarColor]];
        }
    } else {
        
        // 方法二：设置导航条背景（图片）
        if ([self prefersNavigationBarBackgroundImage]) {
            // 如果设置了navigationBar的setBackgroundImage:forBarMetrics:接口，那么上面的setBarTintColor接口就不能改变statusBar的背景色，statusBar的背景色就会变成纯黑色
            [self.navigationController.navigationBar setBackgroundImage:[self prefersNavigationBarBackgroundImage]
                                                         forBarPosition:UIBarPositionAny
                                                             barMetrics:UIBarMetricsDefault];
        }
        
    }
    
    // 设置状态栏颜色（如果状态栏与导航条颜色不一样，则自定一个状态栏背景视图）
    if (![[self prefersNavigationBarColor] isEqual:[self prefersStatusBarColor]]) {
        
        // 隐藏导航条、不隐藏状态栏、导航条为空
        if (!self.naviStatusBarCustomView && ![self prefersStatusBarHidden] ) {
            
            // 显示导航条+状态栏父容器大小
            CGRect naviStatusBarFrame = CGRectMake(0, -STATUS_BAR_HEIGHT, SCREEN_WIDTH, STATUS_BAR_HEIGHT);
            
            // 显示导航条容器大小
            CGRect navigationBarFrame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
            
            // 导航栏+状态栏容器
            UIView *naviStatusBarCustomView = ({
                UIView *view = [[UIView alloc] initWithFrame:naviStatusBarFrame];
                [view setTag:STATUS_NAVIGATION_BAR_TAG];
                [view setBackgroundColor:[self prefersStatusBarColor]];
                [self.navigationController.navigationBar addSubview:view];
                
                view;
            });
            self.naviStatusBarCustomView = naviStatusBarCustomView;
            
            // 自定义导航条视图
            UIView *navigationBarCustomView = ({
                UIView *view = [[UIView alloc] initWithFrame:navigationBarFrame];
                [view setBackgroundColor:[self prefersNavigationBarColor]];
                [naviStatusBarCustomView addSubview:view];
                
                view;
            });
            self.navigationBarCustomView = navigationBarCustomView;
            
            // 底部发丝线
            UIView *navigationBarHairlineImageView = ({
                UIView *view = [[UIView alloc] init];
                CGFloat navigationBarHairlineHeight = [self prefersNavigationBarHidden] ? 0 : [self prefersNavigationBarHairlineHeight];
                [view setFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT-navigationBarHairlineHeight, SCREEN_WIDTH, navigationBarHairlineHeight)];
                [view setBackgroundColor:[self prefersNavigationBarHairlineColor]];
                [navigationBarCustomView addSubview:view];
                
                view;
            });
            self.navigationBarHairlineImageView = navigationBarHairlineImageView;
            
        } else {
            
            [self.naviStatusBarCustomView setBackgroundColor:[self prefersStatusBarColor]];
            
        }
        
    } else {
        
        // 导航栏+状态栏容器（因为导航条是高度集成的，此容器可能在父类的导航条中进行了设置）
        [self.navigationController.navigationBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (view.tag == STATUS_NAVIGATION_BAR_TAG) {
                [view setBackgroundColor:[self prefersStatusBarColor]];
                *stop = YES;
            }
            
        }];
        
    }
    
}


#pragma mark 找出导航栏底部横线
- (UIImageView *)findNavigationBarHairlineImageView:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findNavigationBarHairlineImageView:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}


#pragma mark 设置控制器标题
- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    
    [self setNavigationBarTitleViewTitle:title];
}


#pragma mark 释放资源
- (void)dealloc
{
    _navigationBarCustomView = nil;
    _navigationBarHairlineImageView = nil;
    _navigationBarTitleView = nil;
    _navigationBarTitleViewTitle = nil;
    _navigationBarLeftButtonItem = nil;
    _navigationBarLeftButtonItemTitle = nil;
    _navigationBarRightButtonItem = nil;
    _navigationBarRightButtonItemTitle = nil;
}


#pragma mark -
#pragma mark 设置导航栏中间标题文字
- (void)setNavigationBarTitleViewTitle:(NSString *)navigationBarTitleViewTitle
{
    _navigationBarTitleViewTitle = navigationBarTitleViewTitle;
    if (_navigationBarTitleLabel) {
        NSInteger titleLength = _navigationBarTitleViewTitle.length > NAVIGATION_BAR_TITLE_MAX_NUM ? NAVIGATION_BAR_TITLE_MAX_NUM : _navigationBarTitleViewTitle.length;
        [_navigationBarTitleLabel setText:[_navigationBarTitleViewTitle substringToIndex:titleLength]];
    }
}


#pragma mark 设置导航栏左边按钮标题
- (void)setupNavigationBarLeftButtonItemTitle
{
    [self setNavigationBarLeftButtonItemTitle:[self prefersNavigationBarLeftButtonItemTitle]];
}


#pragma mark 设置导航栏右边按钮标题
- (void)setupNavigationBarRightButtonItemTitle
{
    [self setNavigationBarRightButtonItemTitle:[self prefersNavigationBarRightButtonItemTitle]];
}


@end





