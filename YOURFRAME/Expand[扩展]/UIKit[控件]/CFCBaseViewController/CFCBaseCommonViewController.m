
#import "CFCBaseCommonViewController.h"

@interface CFCBaseCommonViewController ()

@end

@implementation CFCBaseCommonViewController


#pragma mark - Keyboard Notification

- (void)keyboardWillShow:(NSNotification *)notification
{
    // Implement in subclass
    
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    // Implement in subclass
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    // Implement in subclass
    
}

- (void)keyboardDidHide:(NSNotification *)notification
{
    // Implement in subclass
    
}

- (void)contentSizeDidChange:(NSString *)size
{
    // Implement in subclass
    
}


#pragma mark - LifeCycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        _canAddObservers = YES; // 是否能添加监听和通知
        _canFullScreenPopGesture = YES; // 是否可以全屏右滑返回
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    [self preferredDeviceInterfaceOrientation:[self preferredInterfaceOrientation]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加监听通知
    [self addObservers];
  
    // 是否可以全屏右滑返回
    if (!_canFullScreenPopGesture) {
        // 设置全屏右滑返回左边手势允许的最大距离
        [self setFd_interactivePopMaxAllowedInitialDistanceToLeftEdge:FULLSCREEN_POP_GESTURE_MAX_DISTANCE_TO_LEFT_EDGE];
    }
}

- (void)dealloc
{
    [self removeObservers];
}


#pragma mark - Private
- (void)addObservers
{
    if(self.canAddObservers)
    {
        // 添加监听 UIKeyboardWillShowNotification
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
        
        // 添加监听 UIKeyboardDidShowNotification
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShowNotification:) name:UIKeyboardDidShowNotification object:nil];
        
        // 添加监听 UIKeyboardWillHideNotification
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
        
        // 添加监听 UIKeyboardDidHideNotification
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHideNotification:) name:UIKeyboardDidHideNotification object:nil];
        
        // 添加监听 UIContentSizeCategoryDidChangeNotification
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentSizeDidChangeNotification:) name:UIContentSizeCategoryDidChangeNotification object:nil];
        
        //
        self.canAddObservers = NO;
    }
}


- (void)removeObservers
{
    // 移除监听 UIKeyboardWillShowNotification
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    // 移除监听 UIKeyboardDidShowNotification
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    
    // 移除监听 UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    // 移除监听 UIKeyboardDidHideNotification
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    
    // 移除监听 UIContentSizeCategoryDidChangeNotification
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIContentSizeCategoryDidChangeNotification object:nil];
}


- (void)keyboardWillShowNotification:(NSNotification*)notification
{
    [self keyboardWillShow:notification];
    
}

- (void)keyboardDidShowNotification:(NSNotification*)notification
{
    [self keyboardDidShow:notification];
    
}

- (void)keyboardWillHideNotification:(NSNotification*)notification
{
    [self keyboardWillHide:notification];
}

- (void)keyboardDidHideNotification:(NSNotification*)notification
{
    [self keyboardWillHide:notification];
}

- (void)contentSizeDidChangeNotification:(NSNotification*)notification
{
    [self contentSizeDidChange:notification.userInfo[UIContentSizeCategoryNewValueKey]];
}


@end

