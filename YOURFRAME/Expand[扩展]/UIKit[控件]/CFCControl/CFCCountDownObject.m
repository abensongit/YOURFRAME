

#import "CFCCountDownObject.h"


@interface CFCCountDownObject ()
@property(nonatomic, retain) dispatch_source_t timer;
@end


@implementation CFCCountDownObject


#pragma mark -
#pragma mark 每秒走一次，回调block
- (void)countDownWithSecondBlock:(void (^)(void))secondBlock
{
    if (_timer == nil) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0); // 每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                secondBlock();
            });
        });
        dispatch_resume(_timer);
    }
}


#pragma mark 根据日期 NSDate 类型倒计时
- (void)countDownWithStratDate:(NSDate *)startDate finishDate:(NSDate *)finishDate completeBlock:(void (^)(NSInteger timeInterval, NSInteger day, NSInteger hour, NSInteger minute, NSInteger second))completeBlock
{
    if (_timer == nil) {
        NSTimeInterval timeInterval =[finishDate timeIntervalSinceDate:startDate];
        __block int timeout = timeInterval; // 倒计时时间
        if (timeout != 0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0); // 每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout <= 0){ // 倒计时结束，关闭
                  dispatch_source_cancel(self->_timer);
                  self->_timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(0, 0, 0, 0, 0);
                    });
                } else {
                    int days = (int)(timeout/(3600*24));
                    int hours = (int)((timeout-days*24*3600)/3600);
                    int minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    int second = timeout-days*24*3600-hours*3600-minute*60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(timeout, days, hours, minute, second);
                    });
                    timeout --;
                }
            });
            dispatch_resume(_timer);
        }
    }
}


#pragma mark 销毁定时器
- (void)destoryTimer
{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}


@end



