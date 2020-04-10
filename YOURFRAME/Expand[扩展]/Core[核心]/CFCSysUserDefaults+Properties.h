
#import "CFCSysUserDefaults.h"


NS_ASSUME_NONNULL_BEGIN


@interface CFCSysUserDefaults (Properties)

@property (nonatomic, weak) NSString *token;                  // 系统Token
@property (nonatomic, weak) NSString *userId;                 // 用户标识
@property (nonatomic, weak) NSString *userName;               // 用户帐号
@property (nonatomic, weak) NSString *nickName;               // 用户昵称
@property (nonatomic, weak) NSString *appversion;             // 系统版本

@end


NS_ASSUME_NONNULL_END

