
#import <UIKit/UIKit.h>

@interface UIViewController (AlterMessage)

#pragma mark -
- (void)alertPromptInfoMessage:(NSString *)message;

- (void)alertPromptErrorMessage:(NSString *)message;

- (void)alertPromptMessage:(NSString *)message;


#pragma mark -
- (void)alertPromptMessage:(NSString *)message okActionBlock:(void (^)(NSString *content))okActionBlock;

- (void)alertPromptMessage:(NSString *)message okActionTitle:(NSString *)okTitle okActionBlock:(void (^)(NSString *content))okActionBlock;

- (void)alertPrompTitle:(NSString *)title message:(NSString *)message cancleActionBlock:(void (^)(NSString *content))cancleActionBlock okActionBlock:(void (^)(NSString *content))okActionBlock;

- (void)alertPrompTitle:(NSString *)title message:(NSString *)message cancleActionTitle:(NSString *)cancleActionTitle cancleActionBlock:(void (^)(NSString *content))cancleActionBlock okActionTitle:(NSString *)okTitle okActionBlock:(void (^)(NSString *content))okActionBlock;

@end
