
#import "CFCTabBarController.h"
#import "UIColor+Extension.h"
#import "UIImage+CreateOriginal.h"
#import "UIImage+ChangeColor.h"
#import "UIImage+Resize.h"
#import "CFCSysConst.h"
#import "CFCSysCoreMacro.h"

@interface CFCTabBarController () <UITabBarControllerDelegate>

@end

@implementation CFCTabBarController

#pragma mark 视图生命周期（加载视图）
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加子控制器
    [self addChildControllers];
    
    // 设置TabBar的透明效果
     [UITabBar.appearance setTranslucent:NO];
  
    // 设置TabBar字体颜色
    [UITabBar.appearance setTintColor:COLOR_TAB_BAR_TITLE_SELECT_DEFAULT];

    // 设置TabBar背景颜色
    [UITabBar.appearance setBarTintColor:COLOR_TAB_BAR_BACKGROUND_DEFAULT];
    
    // 标签栏透明效果
    [self.tabBar setBackgroundImage:[UIImage imageWithColor:COLOR_TAB_BAR_BACKGROUND_DEFAULT]];
    [self.tabBar setShadowImage: [UIImage new]];
}

#pragma mark 添加导航控制器
- (void)addChildNavigationController:(Class)navigationControllerClass
                  rootViewController:(Class)rootViewControllerClass
                     navigationTitle:(NSString *)navigationTitle
                     tabBarItemTitle:(NSString *)tabBarItemTitle
               tabBarNormalImageName:(NSString *)normalImageName
               tabBarSelectImageName:(NSString *)selectImageName
                   tabBarItemEnabled:(BOOL)enabled
{
    // 创建视图控制器
    UIViewController *rootViewController = [[rootViewControllerClass alloc] init];
    rootViewController.automaticallyAdjustsScrollViewInsets = NO;
    rootViewController.title = tabBarItemTitle; // 默认设置与tabBarItem一样
    if (nil != navigationTitle && navigationTitle.length > 0) {
        rootViewController.title = navigationTitle;
    }
    
    // 创建导航控制器
    UINavigationController *naviViewController = [[navigationControllerClass  alloc] initWithRootViewController:rootViewController];
    naviViewController.automaticallyAdjustsScrollViewInsets = NO;
    if (enabled) {
        naviViewController.tabBarItem.enabled = YES;
        // 标签栏字体
        naviViewController.tabBarItem.title = tabBarItemTitle;
        naviViewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
        [naviViewController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:FONT_TAB_BAR_TITLE_DEFAULT,
                                                                NSForegroundColorAttributeName:COLOR_TAB_BAR_TITLE_NORMAL_DEFAULT}
                                                     forState:UIControlStateNormal];
        [naviViewController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:FONT_TAB_BAR_TITLE_DEFAULT,
                                                                NSForegroundColorAttributeName:COLOR_TAB_BAR_TITLE_SELECT_DEFAULT}
                                                     forState:UIControlStateSelected];
        // 标签栏图标
        CGSize imageSize = CGSizeMake(TAB_BAR_HEIGHT*0.46, TAB_BAR_HEIGHT*0.46);
        naviViewController.tabBarItem.image = [[[UIImage imageNamed:normalImageName]
                                                imageByScalingProportionallyToSize:imageSize]
                                               imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        naviViewController.tabBarItem.selectedImage = [[[UIImage imageNamed:selectImageName]
                                                        imageByScalingProportionallyToSize:imageSize]
                                                       imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        naviViewController.tabBarItem.enabled = NO;
        naviViewController.tabBarItem.title = @"";
    }
    
    // 主标签控制器中添加子导航控制器
    [self addChildViewController:naviViewController];
    
    // 设置底部UITabBarControllerDelegate代理
    rootViewController.tabBarController.delegate = self;
}

#pragma mark 设置子控制器，子类继承并重写
- (void)addChildControllers
{
    // add view controllers in subviews
    
}

#pragma mark -
#pragma mark 通过设置返回值来禁止某个UIViewController能否被选中
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}

#pragma mark 选中Tab项时被调用（在这里做某些操作：如隐藏状态栏，导航栏什么的）
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
}

@end


