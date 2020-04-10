
#import "UIViewController+AlterMessage.h"

@implementation UIViewController (AlterMessage)

#pragma mark - 提示信息-普通信息
- (void)alertPromptInfoMessage:(NSString *)message
{
    NSString *info = nil == message ? @"" : message;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"%@", info] preferredStyle:UIAlertControllerStyleAlert];
    
    // 取消
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancleAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - 提示信息-错误信息
- (void)alertPromptErrorMessage:(NSString *)message
{
    NSString *info = nil == message ? @"" : message;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"警告：%@", info] preferredStyle:UIAlertControllerStyleAlert];
    
    // 取消
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancleAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}



#pragma mark - 提示信息-功能开发
- (void)alertPromptMessage:(NSString *)message
{
    NSString *info = nil == message ? @"" : message;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"%@正在开发中！", info] preferredStyle:UIAlertControllerStyleAlert];
    
    // 取消
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancleAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}




#pragma mark -
- (void)alertPromptMessage:(NSString *)message okActionBlock:(void (^)(NSString *content))okActionBlock
{
  [self alertPromptMessage:message okActionTitle:@"确定" okActionBlock:okActionBlock];
}

- (void)alertPromptMessage:(NSString *)message okActionTitle:(NSString *)okTitle okActionBlock:(void (^)(NSString *content))okActionBlock
{
  [self alertPrompTitle:nil message:message cancleActionTitle:nil cancleActionBlock:nil okActionTitle:okTitle okActionBlock:okActionBlock];
}

- (void)alertPrompTitle:(NSString *)title message:(NSString *)message cancleActionBlock:(void (^)(NSString *content))cancleActionBlock okActionBlock:(void (^)(NSString *content))okActionBlock
{
  [self alertPrompTitle:title message:message cancleActionTitle:@"取消" cancleActionBlock:cancleActionBlock okActionTitle:@"确定" okActionBlock:okActionBlock];
}

- (void)alertPrompTitle:(NSString *)title message:(NSString *)message cancleActionTitle:(NSString *)cancleActionTitle cancleActionBlock:(void (^)(NSString *content))cancleActionBlock okActionTitle:(NSString *)okTitle okActionBlock:(void (^)(NSString *content))okActionBlock
{
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
  // 取消
  if (cancleActionBlock) {
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:cancleActionTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
      cancleActionBlock(cancleActionTitle);
    }];
    [alertController addAction:cancleAction];
  }
  // 确认
  UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    if (okActionBlock) {
      okActionBlock(okTitle);
    }
  }];
  [alertController addAction:confirmAction];
  //
  [self presentViewController:alertController animated:YES completion:nil];
}


@end
