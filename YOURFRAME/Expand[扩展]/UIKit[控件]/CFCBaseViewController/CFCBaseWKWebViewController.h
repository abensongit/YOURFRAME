
#import <WebKit/WebKit.h>
#import "CFCBaseCommonViewController.h"
#import "WebViewJavascriptBridge.h"


@interface CFCBaseWKWebViewController : CFCBaseCommonViewController<WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, copy) NSString *htmlUrlString;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) WKWebViewConfiguration *config;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) WebViewJavascriptBridge* bridge;

@property (nonatomic, assign) BOOL hasShowCloseButton;
@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, assign) BOOL isAutoLayoutSafeAreaTop; // 是否自动适配安全区域（iOS11安全区域）
@property (nonatomic, assign) BOOL isAutoLayoutSafeAreaBottom; // 是否自动适配安全区域（iOS11安全区域）

#pragma mark 事件处理 - 刷新
- (void)pressButtonWebViewRefreshAction;
#pragma mark 事件处理 - 后退
- (void)pressButtonWebViewGoBackAction;
#pragma mark 事件处理 - 前进
- (void)pressButtonWebViewGoForwardAction;
#pragma mark 事件处理 - 关闭
- (void)pressButtonWebViewCloseAction;

#pragma mark 初始化 - 网络
- (instancetype)initWithHTMLUrlString:(NSString *)htmlUrlString;
#pragma mark 初始化 - 本地
- (instancetype)initWithLocalHTMLString:(NSString *)htmlUrlString;

#pragma mark JS与OC处理交互
- (void)webViewJavascriptBridgeRegisterHandler;

@end
