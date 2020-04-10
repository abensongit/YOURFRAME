
#import "CFCSysCore.h"

@implementation CFCSysCore

#pragma mark MJRefresh下拉加载提示信息
CGFloat const CFCRefreshAutoHeaderFontSize = 14.0;
NSString *const CFCRefreshAutoHeaderColor = @"#A5A5A5";
NSString *const CFCRefreshAutoHeaderIdleText = @"下拉可以刷新";
NSString *const CFCRefreshAutoHeaderPullingText = @"松开立即刷新";
NSString *const CFCRefreshAutoHeaderRefreshingText = @"正在刷新数据中";

#pragma mark MJRefresh上拉刷新提示信息
CGFloat const CFCRefreshAutoFooterFontSize = 14.0;
NSString *const CFCRefreshAutoFooterColor = @"#A5A5A5";
NSString *const CFCRefreshAutoFooterIdleText = @"点击或上拉加载更多";
NSString *const CFCRefreshAutoFooterRefreshingText = @"正在加载更多的数据";
NSString *const CFCRefreshAutoFooterNoMoreDataText = @"已经全部加载完毕";

#pragma mark 加载提示信息
NSString *const CFCLoadingProgessHUDText = @"加载中";


#pragma mark 用户登录状态监听的广播频段
NSString * const NOTIFICATION_USER_LOGIN_STATUS_FREQUENCY = @"UserLoginStatusFrequency";
#pragma mark 用户登录状态广播内容 - 字典Key
NSString * const NOTIFICATION_USER_LOGIN_STATUS_KEY = @"UserLoginStatusKey";



@end
