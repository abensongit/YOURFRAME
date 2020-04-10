
#import "CFCBaseCoreViewController.h"

@interface CFCBaseCommonViewController : CFCBaseCoreViewController

/**
 * 是否添加监听通知事件
 */
@property (assign, nonatomic) BOOL canAddObservers;

/**
 * 是否可以全屏右滑返回
 */
@property (assign, nonatomic) BOOL canFullScreenPopGesture;


- (void)contentSizeDidChange:(NSString*)size;

- (void)keyboardWillShow:(NSNotification *)notification;

- (void)keyboardDidShow:(NSNotification *)notification;

- (void)keyboardWillHide:(NSNotification *)notification;

- (void)keyboardDidHide:(NSNotification *)notification;


@end
