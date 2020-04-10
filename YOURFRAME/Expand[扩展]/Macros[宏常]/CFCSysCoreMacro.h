

#ifndef _CFC_SYS_CORE_MACRO_H_
#define _CFC_SYS_CORE_MACRO_H_


#pragma mark -
#pragma mark 当前系统版本
#define APP_VERSION                             @"1.0.0"


#pragma mark -
#pragma mark 第三方注册值
#define APP_BUGLY_PROJECT_UUID                  @"d4a16a648c"
#define APP_JSHARE_APP_KEY                      @"324639381ddde212b44b411b"
#define APP_JSHARE_APP_ID_QQ                    @"1109367880"
#define APP_JSHARE_APP_KEY_KEY                  @"UDI2FoVYbU12bZLB"
#define APP_JSHARE_APP_ID_WEIXIN                @""
#define APP_JSHARE_APP_KEY_WEIXIN               @""


#pragma mark -
#pragma mark 应用基本信息
#define APPINFORMATION                          [CFCSysUserDefaults standardUserDefaults]

#pragma mark -
#pragma mark 本地数据储存
#define NSUSERDEFAULTS_OBJECT_KEY(KEY)          [[NSUserDefaults standardUserDefaults] objectForKey:(KEY)]
#define NSUSERDEFAULTS_OBJECT_SET(VALUE,KEY)    [[NSUserDefaults standardUserDefaults] setObject:(VALUE) forKey:(KEY)];[[NSUserDefaults standardUserDefaults] synchronize]

#pragma mark -
#pragma mark 避免循环引用
#define WEAKTYPE(type) __weak __typeof(&*type)weak##type = type
#define WEAKSELF(weakSelf) __weak __typeof(&*self)weakSelf = self

#pragma mark -
#pragma mark 屏幕尺寸大小
#define SCREEN_SIZE              ([UIScreen mainScreen].bounds.size)
#define SCREEN_BOUNDS            ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH             ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT            ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_MAX_LENGTH        (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH        (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#pragma mark -
#pragma mark 机型判断
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0 && SCREEN_MIN_LENGTH == 320.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0 && SCREEN_MIN_LENGTH == 375.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0 && SCREEN_MIN_LENGTH == 414.0)
#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0 && SCREEN_MIN_LENGTH == 375.0)
#define IS_IPHONE_XR (IS_IPHONE && SCREEN_MAX_LENGTH == 896.0 && SCREEN_MIN_LENGTH == 414.0)
#define IS_IPHONE_XS (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0 && SCREEN_MIN_LENGTH == 375.0)
#define IS_IPHONE_XSMAX (IS_IPHONE && SCREEN_MAX_LENGTH == 896.0 && SCREEN_MIN_LENGTH == 414.0)
#define IS_IPHONE_X_OR_GREATER (IS_IPHONE_X || IS_IPHONE_XR || IS_IPHONE_XS || IS_IPHONE_XSMAX)

#pragma mark -
#pragma mark 机型判断
#define IS_PLATFORM_IPHONE_2G       ([[NSObject deviceName]  isEqualToString:@"iPhone 2G"])
#define IS_PLATFORM_IPHONE_3G       ([[NSObject deviceName]  isEqualToString:@"iPhone 3G"])
#define IS_PLATFORM_IPHONE_3GS      ([[NSObject deviceName]  isEqualToString:@"iPhone 3GS"])
#define IS_PLATFORM_IPHONE_4        ([[NSObject deviceName]  isEqualToString:@"iPhone 4"])
#define IS_PLATFORM_IPHONE_4S       ([[NSObject deviceName]  isEqualToString:@"iPhone 4S"])
#define IS_PLATFORM_IPHONE_5        ([[NSObject deviceName]  isEqualToString:@"iPhone 5"])
#define IS_PLATFORM_IPHONE_5S       ([[NSObject deviceName]  isEqualToString:@"iPhone 5S"])
#define IS_PLATFORM_IPHONE_5C       ([[NSObject deviceName]  isEqualToString:@"iPhone 5C"])
#define IS_PLATFORM_IPHONE_6        ([[NSObject deviceName]  isEqualToString:@"iPhone 6"])
#define IS_PLATFORM_IPHONE_6P       ([[NSObject deviceName]  isEqualToString:@"iPhone 6 Plus"])
#define IS_PLATFORM_IPHONE_6S       ([[NSObject deviceName]  isEqualToString:@"iPhone 6S"])
#define IS_PLATFORM_IPHONE_6SP      ([[NSObject deviceName]  isEqualToString:@"iPhone 6S Plus"])
#define IS_PLATFORM_IPHONE_SE       ([[NSObject deviceName]  isEqualToString:@"iPhone SE"])
#define IS_PLATFORM_IPHONE_7        ([[NSObject deviceName]  isEqualToString:@"iPhone 7"])
#define IS_PLATFORM_IPHONE_7P       ([[NSObject deviceName]  isEqualToString:@"iPhone 7 Plus"])
#define IS_PLATFORM_IPHONE_8        ([[NSObject deviceName]  isEqualToString:@"iPhone 8"])
#define IS_PLATFORM_IPHONE_8P       ([[NSObject deviceName]  isEqualToString:@"iPhone 8 Plus"])
#define IS_PLATFORM_IPHONE_X        ([[NSObject deviceName]  isEqualToString:@"iPhone X"])
#define IS_PLATFORM_IPHONE_XR       ([[NSObject deviceName]  isEqualToString:@"iPhone XR"])
#define IS_PLATFORM_IPHONE_XS       ([[NSObject deviceName]  isEqualToString:@"iPhone XS"])
#define IS_PLATFORM_IPHONE_XS_MAX   ([[NSObject deviceName]  isEqualToString:@"iPhone XS Max"])
#define IS_PLATFORM_SIMULATOR       ([[NSObject deviceName]  isEqualToString:@"Simulator i386"] || [[NSObject deviceName]  isEqualToString:@"Simulator x86_64"])

#pragma mark -
#pragma mark 应用程序尺寸
// APP_FRAME_WIDTH = SCREEN_WIDTH
#define APP_FRAME_WIDTH ([UIScreen mainScreen].applicationFrame.size.width)
// APP_FRAME_HEIGHT = SCREEN_HEIGHT-STATUSBAR_HEIGHT
// 注意：横屏（UIDeviceOrientationLandscape）时，iOS8默认隐藏状态栏，此时 APP_FRAME_HEIGHT = SCREEN_HEIGHT
#define APP_FRAME_HEIGHT ([UIScreen mainScreen].applicationFrame.size.height)

#pragma mark -
#pragma mark 不同机型宽度、高度、字体适配
// 字体进行适配
#define CFC_AUTOSIZING_FONT(fontSize)                             [CFCAutosizingUtil getAutosizeFontSize:(fontSize)]
#define CFC_AUTOSIZING_FONT_SCALE(fontSize)                       [CFCAutosizingUtil getAutosizeFontSizeScale:(fontSize)]
// 宽度进行适配
#define CFC_AUTOSIZING_WIDTH(width)                               [CFCAutosizingUtil getAutosizeViewWidth:(width)]
#define CFC_AUTOSIZING_WIDTH_SCALE(width)                         [CFCAutosizingUtil getAutosizeViewWidthScale:(width)]
// 高度进行适配
#define CFC_AUTOSIZING_HEIGTH(height)                             [CFCAutosizingUtil getAutosizeViewHeight:(height)]
#define CFC_AUTOSIZING_HEIGTH_SCALE(height)                       [CFCAutosizingUtil getAutosizeViewHeightScale:(height)]
// 间隔进行适配
#define CFC_AUTOSIZING_MARGIN(MARGIN)                             [CFCAutosizingUtil getAutosizeViewMargin:(MARGIN)]
#define CFC_AUTOSIZING_MARGIN_SCALE(MARGIN)                       [CFCAutosizingUtil getAutosizeViewMarginScale:(MARGIN)]

#pragma mark -
#pragma mark 颜色工具宏
#define COLOR_HEXSTRING(A)                                        [UIColor colorWithHexString:(A)]
#define COLOR_RANDOM                                              COLOR_RGBA(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), 1.0f)
#define COLOR_RANDOM_ALPHA(X)                                     COLOR_RGBA(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), (X))
#define COLOR_RGB(R, G, B)                                        [UIColor colorWithRed:((R)/255.f) green:((G)/255.f) blue:((B)/255.f) alpha:1.0f]
#define COLOR_RGBA(R, G, B, A)                                    [UIColor colorWithRed:((R)/255.f) green:((G)/255.f) blue:((B)/255.f) alpha:(A)]

#pragma mark -
#pragma mark 系统主题色 - 界面主色
#define COLOR_SYSTEM_MAIN_UI_THEME_DEFAULT                        COLOR_HEXSTRING(@"#C52133")
#pragma mark 系统主题色 - 界面底色 - 默认
#define COLOR_SYSTEM_MAIN_UI_BACKGROUND_DEFAULT                   COLOR_HEXSTRING(@"#FFFFFF")
#pragma mark 系统主题色 - 主字体色 - 默认
#define COLOR_SYSTEM_MAIN_FONT_DEFAULT                            COLOR_HEXSTRING(@"#2A2A2A")
#pragma mark 系统主题色 - 辅助字体色 - 默认
#define COLOR_SYSTEM_MAIN_FONT_ASSIST_DEFAULT                     COLOR_HEXSTRING(@"#959595")
#pragma mark 系统主题色 - 按钮的颜色 - 正常 - 默认
#define COLOR_SYSTEM_MAIN_BUTTON_BACKGROUND_NORMAL_DEFAULT        COLOR_HEXSTRING(@"#FFFFFF")
#pragma mark 系统主题色 - 按钮的颜色 - 选中 - 默认
#define COLOR_SYSTEM_MAIN_BUTTON_BACKGROUND_SELECT_DEFAULT        COLOR_SYSTEM_MAIN_UI_THEME_DEFAULT

#pragma mark -
#pragma mark 导航栏配置 - 背景颜色
#define COLOR_NAVIGATION_BAR_BACKGROUND_DEFAULT                   COLOR_SYSTEM_MAIN_UI_THEME_DEFAULT
#pragma mark 导航栏配置 - 标题字体颜色
#define FONT_NAVIGATION_BAR_TITLE_DEFAULT                         [UIFont boldSystemFontOfSize:CFC_AUTOSIZING_FONT(18.0f)]
#define COLOR_NAVIGATION_BAR_TITLE_DEFAULT                        COLOR_HEXSTRING(@"#FEFDFD")
#pragma mark 导航栏配置 - 按钮字体颜色
#define FONT_NAVIGATION_BAR_BUTTON_TITLE_DEFAULT                  [UIFont boldSystemFontOfSize:CFC_AUTOSIZING_FONT(16.0f)]
#define COLOR_NAVIGATION_BAR_BUTTON_TITLE_NORMAL_DEFAULT          COLOR_NAVIGATION_BAR_TITLE_DEFAULT
#define COLOR_NAVIGATION_BAR_BUTTON_TITLE_SELECT_DEFAULT          COLOR_NAVIGATION_BAR_TITLE_DEFAULT
#pragma mark 导航栏配置 - 底部横线颜色
#define COLOR_NAVIGATION_BAR_HAIR_LINE_DEFAULT                    COLOR_SYSTEM_MAIN_UI_BACKGROUND_DEFAULT

#pragma mark -
#pragma mark 标签栏配置 - 背景颜色
#define COLOR_TAB_BAR_BACKGROUND_DEFAULT                          COLOR_HEXSTRING(@"#F8F8F9")
#pragma mark 标签栏配置 - 标题字体颜色
#define FONT_TAB_BAR_TITLE_DEFAULT                                [UIFont boldSystemFontOfSize:CFC_AUTOSIZING_FONT(10.0f)]
#define COLOR_TAB_BAR_TITLE_NORMAL_DEFAULT                        COLOR_HEXSTRING(@"#7B7F83")
#define COLOR_TAB_BAR_TITLE_SELECT_DEFAULT                        COLOR_NAVIGATION_BAR_BACKGROUND_DEFAULT

#pragma mark -
#pragma mark UITableView表格背景色
#define COLOR_TABLEVIEW_SEPARATOR_LINE_DEFAULT                    COLOR_HEXSTRING(@"#E9E9EE")
#define COLOR_TABLEVIEW_BACK_VIEW_BACKGROUND_DEFAULT              COLOR_HEXSTRING(@"#E9E9EE")
#define COLOR_TABLEVIEW_HEADER_VIEW_BACKGROUND_DEFAULT            COLOR_HEXSTRING(@"#E9E9EE")
#define COLOR_TABLEVIEW_FOOTER_VIEW_BACKGROUND_DEFAULT            COLOR_HEXSTRING(@"#E9E9EE")

#pragma mark -
#pragma mark 系统主题色 - 系统按钮
#define COLOR_SYSTEM_MAIN_UI_BUTTON_DEFAULT                       COLOR_SYSTEM_MAIN_UI_THEME_DEFAULT

#pragma mark -
#pragma mark 刷新控件 - 背景颜色
#define COLOR_REFRESH_CONTROL_FRONT_DEFAULT                       COLOR_SYSTEM_MAIN_UI_THEME_DEFAULT
#define COLOR_REFRESH_CONTROL_BACKGROUND_DEFAULT                  COLOR_HEXSTRING(@"#D6D6D6")

#pragma mark -
#pragma mark UIWebView - 进度条颜色
#define COLOR_UIWEBVIEW_PROGRESSVIEW_BACKGROUND                   COLOR_HEXSTRING(@"#D13E3D")

#pragma mark -
#pragma mark UIActivityIndicatorView - 菊花颜色
#define COLOR_ACTIVITY_INDICATOR_BACKGROUND                       COLOR_SYSTEM_MAIN_UI_THEME_DEFAULT

#pragma mark -
#pragma mark 滑动菜单控件配置
#define COLOR_DRAWRESULT_SUB_TAB_PAGER_TAB_LINE                   COLOR_HEXSTRING(@"#E9E9EE")
#define COLOR_DRAWRESULT_SUB_TAB_PAGER_BACKGROUND                 COLOR_HEXSTRING(@"#FFFFFF")
#define COLOR_DRAWRESULT_SUB_TAB_PAGER_TITLE_NORMAL               COLOR_HEXSTRING(@"#9B9EA1")
#define COLOR_DRAWRESULT_SUB_TAB_PAGER_TITLE_SELECT               COLOR_SYSTEM_MAIN_UI_THEME_DEFAULT
#define COLOR_DRAWRESULT_SUB_TAB_PAGER_TAB_INDICATOR              COLOR_SYSTEM_MAIN_UI_THEME_DEFAULT


#pragma mark -
#pragma mark 登录退出选中标签
#define LOGIN_IN_TAB_SELECTED_INDEX         (2)
#define LOGIN_OUT_TAB_SELECTED_INDEX        (0)



#endif /* _CFC_SYS_CORE_MACRO_H_ */

