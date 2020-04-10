
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFCSysCore : NSObject

#pragma mark MJRefresh下拉加载提示信息
UIKIT_EXTERN CGFloat const CFCRefreshAutoHeaderFontSize;
UIKIT_EXTERN NSString *const CFCRefreshAutoHeaderColor;
UIKIT_EXTERN NSString *const CFCRefreshAutoHeaderIdleText;
UIKIT_EXTERN NSString *const CFCRefreshAutoHeaderPullingText;
UIKIT_EXTERN NSString *const CFCRefreshAutoHeaderRefreshingText;

#pragma mark 上拉刷新提示信息
UIKIT_EXTERN CGFloat const CFCRefreshAutoFooterFontSize;
UIKIT_EXTERN NSString *const CFCRefreshAutoFooterColor;
UIKIT_EXTERN NSString *const CFCRefreshAutoFooterIdleText;
UIKIT_EXTERN NSString *const CFCRefreshAutoFooterRefreshingText;
UIKIT_EXTERN NSString *const CFCRefreshAutoFooterNoMoreDataText;

#pragma mark 加载提示信息
UIKIT_EXTERN NSString *const CFCLoadingProgessHUDText;


#pragma mark 用户登录状态
typedef NS_ENUM(NSInteger, JSLLoginStatusType) {
  JSLLoginStatusTypeFailure = 0,    // 用户登录失败状态
  JSLLoginStatusTypeSuccess = 1,    // 用户登录成功状态
};


#pragma mark 用户登录状态监听的广播频段
UIKIT_EXTERN NSString * const NOTIFICATION_USER_LOGIN_STATUS_FREQUENCY;
#pragma mark 用户登录状态广播内容 - 字典Key
UIKIT_EXTERN NSString * const NOTIFICATION_USER_LOGIN_STATUS_KEY;


@end

NS_ASSUME_NONNULL_END
