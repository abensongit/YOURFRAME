

#import <Foundation/Foundation.h>

@interface CFCCountDownObject : NSObject

#pragma mark -
#pragma mark 每秒回调一次，注意释放定时器
- (void)countDownWithSecondBlock:(void (^)(void))secondBlock;

#pragma mark 根据日期 NSDate 类型倒计时
- (void)countDownWithStratDate:(NSDate *)startDate finishDate:(NSDate *)finishDate completeBlock:(void (^)(NSInteger timeInterval, NSInteger day, NSInteger hour, NSInteger minute, NSInteger second))completeBlock;

#pragma mark 销毁定时器
- (void)destoryTimer;

@end
