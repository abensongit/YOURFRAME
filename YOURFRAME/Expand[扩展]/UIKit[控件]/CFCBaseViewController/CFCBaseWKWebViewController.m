
#import "CFCBaseWKWebViewController.h"
#import "WebViewJavascriptBridge.h"
#import "YHSDropDownMenuView.h"
#import "YHSDropDownMenuModel.h"
#import "CFCAutosizingUtil.h"
#import "CFCSysCoreMacro.h"
#import "CFCAssetsMacro.h"
#import "CFCSysConst.h"
#import "CFCSysUtil.h"
#import "UIColor+Extension.h"
#import "UIImage+Resize.h"
#import "UIView+Frame.h"


@interface CFCBaseWKWebViewController ()
@property (nonatomic, assign) BOOL isLocalHTMLString; // 默认NO
@property (nonatomic, strong) YHSDropDownMenuView *dropdownMenu;
@end


@implementation CFCBaseWKWebViewController


#pragma mark -
#pragma mark 事件处理 - 点击导航栏左侧按钮事件
- (void)pressNavigationBarLeftButtonItem:(id)sender
{
  // 显示关闭按钮
  self.closeButton.hidden = YES; // 此项目设置一直不显示
  self.hasShowCloseButton = YES;
  
  if (self.webView.canGoBack) {
    [self.webView goBack];
  }  else {
    [super pressNavigationBarLeftButtonItem:sender];
  }
}

#pragma mark 事件处理 - 导航栏右侧按钮事件
- (void)pressNavigationBarRightButtonItem:(id)sender
{
  [self.dropdownMenu showMenu];
}

#pragma mark 事件处理 - 刷新
- (void)pressButtonWebViewRefreshAction
{
  [self.webView reload];
}

#pragma mark 事件处理 - 后退
- (void)pressButtonWebViewGoBackAction
{
  [self pressNavigationBarLeftButtonItem:self.navigationBarLeftButtonItem];
}

#pragma mark 事件处理 - 前进
- (void)pressButtonWebViewGoForwardAction
{
  if ([self.webView canGoForward]) {
    [self.webView goForward];
  } else {
    [self.webView reload];
  }
}

#pragma mark 事件处理 - 关闭
- (void)pressButtonWebViewCloseAction
{
  [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark JS与OC处理交互
- (void)webViewJavascriptBridgeRegisterHandler
{
  /*
   * 含义：JS调用OC
   * @param registerHandler 要注册的事件名称（比如这里我们为testJavascriptCallObjcHandler）
   * @param handler 回调block函数，当后台触发这个事件的时候会执行block里面的代码
   */
  [_bridge registerHandler:@"testJavascriptCallObjcHandler" handler:^(id data, WVJBResponseCallback responseCallback) {
    // data JS页面传过来的参数
    CFCLog(@"\ntestJavascriptCallObjcHandler called: %@", data);
    
    // 这里利用data参数处理自己的逻辑
    
    // responseCallback 给JS的回复
    responseCallback(@"Response From testJavascriptCallObjcHandler");
  }];
  
}


#pragma mark -
#pragma mark 视图生命周期（初始化 - 网络）
- (instancetype)initWithHTMLUrlString:(NSString *)htmlUrlString
{
  self = [super init];
  if (self) {
    _htmlUrlString = [CFCSysUtil stringByTrimmingWhitespaceAndNewline:htmlUrlString];
    _hasShowCloseButton = NO; // 默认没有显示过关闭按钮
    _isLocalHTMLString = NO; // 是否加载本地文件
    _isAutoLayoutSafeAreaTop = YES; // 是否自动适配安全区域（iOS11安全区域）
    _isAutoLayoutSafeAreaBottom = NO; // 是否自动适配安全区域（iOS11安全区域）
  }
  return self;
}


#pragma mark 视图生命周期（初始化 - 本地）
- (instancetype)initWithLocalHTMLString:(NSString *)htmlUrlString
{
  self = [self initWithHTMLUrlString:htmlUrlString];
  if (self) {
    _isLocalHTMLString = YES; // 加载地址HTML
    _isAutoLayoutSafeAreaTop = YES; // 是否自动适配安全区域（iOS11安全区域）
    _isAutoLayoutSafeAreaBottom = NO; // 是否自动适配安全区域（iOS11安全区域）
  }
  return self;
}


#pragma mark 视图生命周期（加载视图）
- (void)viewDidLoad
{
  [super viewDidLoad];
  
  WEAKSELF(weakSelf);
  
  // 1.导航栏右侧按钮
  {
    // 刷新
    YHSDropDownMenuModel *menuModel0 = [YHSDropDownMenuModel yhs_DropDownMenuModelWithMenuItemTitle:@"刷新" menuItemIconName:nil  menuBlock:^{
      [weakSelf pressButtonWebViewRefreshAction];
    }];
    // 后退
    YHSDropDownMenuModel *menuModel1 = [YHSDropDownMenuModel yhs_DropDownMenuModelWithMenuItemTitle:@"后退" menuItemIconName:nil menuBlock:^{
      [weakSelf pressButtonWebViewGoBackAction];
    }];
    // 前进
    YHSDropDownMenuModel *menuModel2 = [YHSDropDownMenuModel yhs_DropDownMenuModelWithMenuItemTitle:@"前进" menuItemIconName:nil menuBlock:^{
      [weakSelf pressButtonWebViewGoForwardAction];
    }];
    // 关闭
    YHSDropDownMenuModel *menuModel3 = [YHSDropDownMenuModel yhs_DropDownMenuModelWithMenuItemTitle:@"关闭" menuItemIconName:nil menuBlock:^{
      [weakSelf pressButtonWebViewCloseAction];
    }];
    
    // 下拉菜单
    self.dropdownMenu = [YHSDropDownMenuView yhs_DefaultStyleDropDownMenuWithMenuModelsArray:@[menuModel0, menuModel1, menuModel2, menuModel3] menuWidth:YHSDefaultFloat eachItemHeight:YHSDefaultFloat menuRightMargin:YHSDefaultFloat triangleRightMargin:YHSDefaultFloat];
    self.dropdownMenu.ifShouldScroll = NO;
    self.dropdownMenu.eachMenuItemHeight = 50.0f;
    self.dropdownMenu.iconRightMargin = 0.0f;
    self.dropdownMenu.iconLeftMargin = 0.0f;
    self.dropdownMenu.triangleRightMargin = (CFC_AUTOSIZING_WIDTH(NAVIGATION_BAR_BUTTON_MAX_WIDTH)-18)/2.0;
    self.dropdownMenu.triangleSize = CGSizeMake(18, 11);
    self.dropdownMenu.menuRightMargin = 5.0f;
    if (IS_IPHONE_X_OR_GREATER) {
      self.dropdownMenu.triangleY = 72.0f;
    } else {
      self.dropdownMenu.triangleY = 50.0f;
    }
    self.dropdownMenu.iconSize = CGSizeMake(20, 20);
    self.dropdownMenu.titleColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
    self.dropdownMenu.triangleColor = [UIColor colorWithRed:0.35 green:0.35 blue:0.35 alpha:0.70];
    self.dropdownMenu.menuItemBackgroundColor = [UIColor colorWithRed:0.35 green:0.35 blue:0.35 alpha:0.70];
    self.dropdownMenu.separaterLineColor = [UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:0.80];
    // 初始化
    [self.dropdownMenu setup];
  }
  
  // 2.网页加载进度条
  {
    // 初始化progressView
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2)];
    // 普通样式
    self.progressView.progressViewStyle = UIProgressViewStyleDefault;
    // 设置未走过进度的进度条颜色
    [self.progressView setTrackTintColor:[UIColor clearColor]];
    // 设置已走过进度的进度条颜色
    [self.progressView setProgressTintColor:COLOR_UIWEBVIEW_PROGRESSVIEW_BACKGROUND];
    // 设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
    [self.progressView setTransform:CGAffineTransformMakeScale(1.0f, 1.5f)];
    [self.view addSubview:self.progressView];
  }
  
  // 3.添加WKWebView属性监听
  {
    // WKWebView有好多个支持KVO的属性，这里只是监听title、estimatedProgress属性，分别用于判断获取页面标题、当前页面载入进度
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
  }
  
  // 4.添加JS交互
  {
    [WebViewJavascriptBridge enableLogging]; // 开启日志
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.bridge setWebViewDelegate:self];
    
    // JS与OC处理交互
    [self webViewJavascriptBridgeRegisterHandler];
  }
  
  // 5.开始加载网页
  [self startLoadRequestWebHtml];
  
  // 6.创建关闭按钮
  [self createNavigationBarCloseButton];
  
}


#pragma mark 视图生命周期（视图将要显示）
- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  // 创建关闭按钮
  self.closeButton.hidden = !self.hasShowCloseButton;
}


#pragma mark 视图生命周期（视图已经显示）
- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  
  self.closeButton.hidden = YES;
}


#pragma mark 视图生命周期（视图已经消失）
- (void)viewDidDisappear:(BOOL)animated
{
  [super viewDidDisappear:animated];
  
  [self.closeButton removeFromSuperview];
}

#pragma mark 创建关闭按钮
- (void)createNavigationBarCloseButton
{
  if (self.closeButton) {
    return;
  }
  
  UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
  
  [closeButton setHeight:YES];
  [closeButton setTitle:@"" forState:UIControlStateNormal];
  [closeButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
  [closeButton setFrame:CGRectMake(CGRectGetMaxX(self.navigationBarLeftButtonItem.frame), 0, 50, NAVIGATION_BAR_HEIGHT)];
  [closeButton addTarget:self action:@selector(pressButtonWebViewCloseAction) forControlEvents:UIControlEventTouchUpInside];
  [self setCloseButton:closeButton];
  
  CGFloat imageSize = CFC_AUTOSIZING_WIDTH(19.0f);
  UIImageView *closeButtonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (NAVIGATION_BAR_HEIGHT-imageSize)/2.0, imageSize, imageSize)];
  closeButtonImageView.image = [UIImage imageNamed:ICON_NAVIGATION_BAR_BUTTON_CLOSE_DEF];
  [closeButton addSubview:closeButtonImageView];
  
  [self.navigationController.navigationBar insertSubview:closeButton aboveSubview:self.navigationBarTitleView];
}


#pragma mark 加载Web网页内容
- (void)startLoadRequestWebHtml
{
  if (_isLocalHTMLString) {
    NSString *urlString = self.htmlUrlString;
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSString * localHtmlPath = [[NSBundle mainBundle] pathForResource:urlString ofType:@"html"];
    NSString * localHtmlContent = [NSString stringWithContentsOfFile:localHtmlPath encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:localHtmlContent baseURL:baseURL];
  } else {
    NSString *urlString = self.htmlUrlString;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    // 此外只能解决第一次进入的cookie问题，如果页面内跳转（a标签等）还是取不到cookie，因此还要再加代码
    [request addValue:[self getCurrentCookieWithDomain:urlString] forHTTPHeaderField:@"Cookie"];
    [request setTimeoutInterval:30.0f];
    [self.webView loadRequest:request];
  }
}


#pragma mark -
#pragma mark 监听网页加载的进度
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
  if ([keyPath isEqualToString:@"title"]) {
    
    self.title = self.webView.title;
    [self setNavigationBarTitleViewTitle:self.webView.title];
    
  } else if ([keyPath isEqualToString:@"estimatedProgress"]) {
    
    self.progressView.progress = self.webView.estimatedProgress;
    if (self.progressView.progress == 1) {
      /*
       * 添加一个简单的动画，将progressView的Height变为1.4倍
       * 动画时长0.25s，延时0.3s后开始动画
       * 动画结束后将progressView隐藏
       */
      __weak typeof (self)weakSelf = self;
      [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
        weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
      } completion:^(BOOL finished) {
        weakSelf.progressView.hidden = YES;
      }];
    }
    
  } else {
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
  }
  
}


#pragma mark - WKWKNavigationDelegate
#pragma mark 加载的状态回调 - 开始加载网页
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
  // 开始加载网页时展示出progressView
  self.progressView.hidden = NO;
  // 开始加载网页的时候将progressView的Height恢复为1.5倍
  self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
  // 防止progressView被网页挡住
  [self.view bringSubviewToFront:self.progressView];
}

#pragma mark 加载的状态回调 - 内容开始返回
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
  
}

#pragma mark 加载的状态回调 - 网页内容被终止
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
  
}

#pragma mark 加载的状态回调 - 网页加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
  // 页面内跳转（a标签等）还是取不到cookie，因此此外添加代码
  [self setCookieWithWebView:webView didFinishNavigation:navigation];
}

#pragma mark 加载的状态回调 - 网页加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
  // 加载失败同样需要隐藏progressView
  self.progressView.hidden = YES;
}

#pragma mark 页面跳转的代理 - 页面在跳转过程中出现错误
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
  
}

#pragma mark 页面跳转的代理 - 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
  
}

#pragma mark 页面跳转的代理 - 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
  decisionHandler(WKNavigationResponsePolicyAllow);
}

#pragma mark 页面跳转的代理 - 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
  decisionHandler(WKNavigationActionPolicyAllow);
}


#pragma mark - WKUIDelegate
#pragma mark Alert弹窗
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
  UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:message ? : @"" preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction * action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    completionHandler();
  }];
  [alertController addAction:action];
  [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark Confirm弹框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message ? : @"" preferredStyle:UIAlertControllerStyleAlert];
  
  UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    completionHandler(NO);
  }];
  
  UIAlertAction * confirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    completionHandler(YES);
  }];
  
  [alertController addAction:cancelAction];
  [alertController addAction:confirmAction];
  
  [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark TextInput弹框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler {
  
  UIAlertController * alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
  [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    textField.text = defaultText;
  }];
  UIAlertAction * action = [UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    completionHandler(alertController.textFields[0].text ? : @"");
  }];
  [alertController addAction:action];
  
  [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark -
#pragma mark 导航栏右边按钮类型
- (CFCNavBarButtonItemType)prefersNavigationBarRightButtonItemType
{
  return CFCNavBarButtonItemTypeNone;
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
  // 自定义按钮
  CGFloat imageSizeWith = CFC_AUTOSIZING_WIDTH(21.0f);
  CGFloat imageSizeHeight = CFC_AUTOSIZING_WIDTH(5.6f);
  CGRect btnFrame = CGRectMake(0, 0, CFC_AUTOSIZING_WIDTH(NAVIGATION_BAR_BUTTON_MAX_WIDTH), NAVIGATION_BAR_HEIGHT);
  UIButton *btn = [[UIButton alloc] initWithFrame:btnFrame];
  [btn setImage:[[UIImage imageNamed:iconNameNormal] imageByScalingProportionallyToSize:CGSizeMake(imageSizeWith, imageSizeHeight)]
       forState:UIControlStateNormal];
  [btn setImage:[[UIImage imageNamed:iconNameSelect] imageByScalingProportionallyToSize:CGSizeMake(imageSizeWith, imageSizeHeight)]
       forState:UIControlStateHighlighted];
  [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
  
  return btn;
}

#pragma mark 设置导航栏右边按钮控件图标（正常）
- (NSString *)prefersNavigationBarRightButtonItemImageNormal
{
  return ICON_NAVIGATION_BAR_BUTTON_MORE_POINT;
}

#pragma mark 设置导航栏右边按钮控件图标（选中）
- (NSString *)prefersNavigationBarRightButtonItemImageSelect
{
  return ICON_NAVIGATION_BAR_BUTTON_MORE_POINT;
}


#pragma mark -
#pragma mark Getter/Setter

- (WKWebView *)webView
{
  if (!_webView) {
    _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:self.config];
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    _webView.allowsBackForwardNavigationGestures = NO; // 是否允许手势，后退前进等操作
    _webView.scrollView.bounces = YES; // 是否允许拖动效果
    [self.view addSubview:_webView];
    //
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.view.mas_left);
      make.right.equalTo(self.view.mas_right);
      make.top.equalTo(self.view.mas_top);
      make.bottom.equalTo(self.view.mas_bottom);
    }];
  }
  return _webView;
}

- (WKWebViewConfiguration *)config
{
  if (!_config) {
    _config = [[WKWebViewConfiguration alloc] init];
    _config.allowsInlineMediaPlayback = YES;
    // iOS系统版本 >= 9.0
    if (@available(iOS 9.0, *)) {
      _config.allowsPictureInPictureMediaPlayback = YES;
    }
  }
  return _config;
}


#pragma mark -
#pragma mark Private
- (void)dealloc
{
  if (_webView) {
    [_webView removeObserver:self forKeyPath:@"title"];
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
  }
}


#pragma mark 根据域名获取当前Cookie
- (NSString *)getCurrentCookieWithDomain:(NSString *)domainString
{
  // 以前UIWebView会自动去NSHTTPCookieStorage中读取cookie，但是WKWebView并不会去读取，解决方式就是在request中手动帮其添加上。
  NSHTTPCookieStorage*cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
  NSMutableString * cookieString = [[NSMutableString alloc]init];
  for (NSHTTPCookie*cookie in [cookieJar cookies]) {
    CFCLog(@"第一次：name=%@;value=%@", cookie.name, cookie.value);
    [cookieString appendFormat:@"%@=%@;",cookie.name, cookie.value];
  }
  // 删除最后一个分号“;”
  if (cookieString && cookieString.length > 0) {
    [cookieString deleteCharactersInRange:NSMakeRange(cookieString.length - 1, 1)];
  }
  return cookieString;
}


#pragma mark 页面内跳转（A标签等）取不到Cookie
- (void)setCookieWithWebView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
  // 取出cookie
  NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
  // JS函数
  NSString *JSFuncString =
  @"function setCookie(name,value,expires)\
  {\
  var oDate=new Date();\
  oDate.setDate(oDate.getDate()+expires);\
  document.cookie=name+'='+value+';expires='+oDate+';path=/'\
  }\
  function getCookie(name)\
  {\
  var arr = document.cookie.match(new RegExp('(^| )'+name+'=({FNXX==XXFN}*)(;|$)'));\
  if(arr != null) return unescape(arr[2]); return null;\
  }\
  function delCookie(name)\
  {\
  var exp = new Date();\
  exp.setTime(exp.getTime() - 1);\
  var cval=getCookie(name);\
  if(cval!=null) document.cookie= name + '='+cval+';expires='+exp.toGMTString();\
  }";
  
  // 拼凑JS字符串
  NSMutableString *JSCookieString = JSFuncString.mutableCopy;
  for (NSHTTPCookie *cookie in cookieStorage.cookies) {
    CFCLog(@"name=%@;value=%@", cookie.name, cookie.value);
    NSString *excuteJSString = [NSString stringWithFormat:@"setCookie('%@', '%@', 1);", cookie.name, cookie.value];
    [JSCookieString appendString:excuteJSString];
  }
  // CFCLog(@"JSCookieString=%@", JSCookieString);
  // 执行JS
  [webView evaluateJavaScript:JSCookieString completionHandler:nil];
}


@end




