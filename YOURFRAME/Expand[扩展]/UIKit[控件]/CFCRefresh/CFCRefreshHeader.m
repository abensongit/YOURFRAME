
#import "CFCRefreshHeader.h"
#import <AudioToolbox/AudioServices.h>
#import "CFCCircleActivityIndicatorView.h"

@interface CFCRefreshHeader()
@property (nonatomic, assign) BOOL isRefreshPulling;
@property (nonatomic, assign) BOOL isRefreshPeekSound;
@property (nonatomic, weak) CFCCircleActivityIndicatorView *loadingView;
@end

@implementation CFCRefreshHeader

#pragma mark - 懒加载子控件
- (CFCCircleActivityIndicatorView *)loadingView
{
    if (!_loadingView) {
        CGRect loadingViewFrame = CGRectMake(0, 0, self.mj_h * 0.48,self.mj_h * 0.48);
        CFCCircleActivityIndicatorView *loadingView = [[CFCCircleActivityIndicatorView alloc] initWithFrame:loadingViewFrame];
        [loadingView setLineWidth:3.0f];
        [loadingView setFrontLineColor:COLOR_REFRESH_CONTROL_FRONT_DEFAULT];
        [loadingView setBackLineColor:COLOR_REFRESH_CONTROL_BACKGROUND_DEFAULT];
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}

#pragma mark - 刷新控件 - 前景色
- (void)setFrontLineColor:(UIColor *)frontLineColor
{
    _frontLineColor = frontLineColor;
    [self.loadingView setFrontLineColor:frontLineColor];
}

#pragma mark - 刷新控件 - 背景色
- (void)setBackLineColor:(UIColor *)backLineColor
{
    _backLineColor = backLineColor;
    [self.loadingView setBackLineColor:backLineColor];
}

#pragma mark - 重写父类的方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    self.stateLabel.hidden = YES; // 隐藏状态
    self.lastUpdatedTimeLabel.hidden = YES; // 隐藏时间
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    // 圈圈的中心点
    CGFloat circleCenterX = self.mj_w * 0.5;
    if (!self.stateLabel.hidden) {
        circleCenterX -= 100;
    }
    CGFloat circleCenterY = self.mj_h * 0.5;
    CGPoint arrowCenter = CGPointMake(circleCenterX, circleCenterY);
    
    // 圈圈
    if (self.loadingView.constraints.count == 0) {
        self.loadingView.center = arrowCenter;
    }
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                self.loadingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
                if (self.state != MJRefreshStateIdle) return;
                
                self.loadingView.alpha = 1.0;
                [self.loadingView stopAnimating];
                self.isRefreshPulling = NO;
                self.isRefreshPeekSound = NO;
            }];
        } else {
            [self.loadingView stopAnimating];
            self.isRefreshPulling = NO;
            self.isRefreshPeekSound = NO;
        }
    } else if (state == MJRefreshStatePulling) {
        [self.loadingView stopAnimating];
        self.isRefreshPulling = NO;
        self.isRefreshPeekSound = NO;
    } else if (state == MJRefreshStateRefreshing) {
        self.loadingView.alpha = 1.0; // 防止refreshing -> idle的动画完毕动作没有被执行
        [self.loadingView startAnimating];
        self.isRefreshPulling = YES;
        self.isRefreshPeekSound = YES;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    if (self.isRefreshPulling) {
        [self.loadingView setAnglePercent:60.0/360.0];
    } else {
        [self.loadingView setAnglePercent:(pullingPercent-0.75)*4.0];
        if (!self.isRefreshPeekSound
            && self.loadingView.anglePercent >= 1.0f) {
            AudioServicesPlaySystemSound(1519);
            self.isRefreshPeekSound = YES;
        }
    }
}

#pragma mark 进入刷新状态
- (void)beginRefreshing
{
    // 自动刷新隐藏振动
    self.isRefreshPeekSound = YES;
    
    // 自动进入刷新状态
    [super beginRefreshing];
}

@end


