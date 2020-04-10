

#import "CFCCircleActivityIndicatorView.h"

#define CIRCLE_ANGLE(angle) (2*M_PI/360*angle)
#define CIRCLE_LINE_COLOR_DEFAULT          [UIColor colorWithRed:0.87f green:0.43f blue:0.38f alpha:0.90f]
#define CIRCLE_BACKGROUND_COLOR_DEFAULT    [UIColor colorWithRed:0.88f green:0.88f blue:0.88f alpha:0.88f]

static NSString *kCircleActivityIndicatorViewAnimationKey = @"CircleActivityIndicatorView.rotation";

@interface CFCCircleActivityIndicatorView ()

@property (nonatomic, readwrite) BOOL isAnimating;
@property (nonatomic, readonly) CAShapeLayer *progressLayer;
@property (nonatomic, readonly) CAShapeLayer *backbgroundLayer;

@end


@implementation CFCCircleActivityIndicatorView

@synthesize isAnimating = _isAnimating;
@synthesize progressLayer = _progressLayer;
@synthesize backbgroundLayer = _backbgroundLayer;


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    [self.layer insertSublayer:self.progressLayer atIndex:0];
    [self.layer insertSublayer:self.backbgroundLayer atIndex:0];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.progressLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    self.backbgroundLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    
    [self updateProgressPath];
}

- (void)tintColorDidChange
{
    [super tintColorDidChange];
    
    self.progressLayer.strokeColor = self.frontLineColor.CGColor;
    self.backbgroundLayer.strokeColor = self.backLineColor.CGColor;
}


- (void)startAnimating
{
    if (self.isAnimating) {
        return;
    }
    
    [self updateProgressPathWithAnimating];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = 0.8f;
    animation.fromValue = @(0.0f);
    animation.toValue = @(2 * M_PI);
    animation.repeatCount = INFINITY;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.progressLayer addAnimation:animation forKey:kCircleActivityIndicatorViewAnimationKey];
    self.isAnimating = true;
}

- (void)stopAnimating
{
    if (!self.isAnimating) {
        return;
    }
    
    [self.progressLayer removeAnimationForKey:kCircleActivityIndicatorViewAnimationKey];
    self.isAnimating = false;
}

#pragma mark - Private

- (void)updateProgressPath
{
    if (self.anglePercent <= 0) {
        _anglePercent = 0.0f;
    }
    
    if (self.anglePercent >= 1) {
        _anglePercent = 1.0f;
    }
    
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat radius = MIN(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2) - self.progressLayer.lineWidth / 2;
    CGFloat startAngle = CIRCLE_ANGLE(-90);
    CGFloat endAngle = CIRCLE_ANGLE(-90) + CIRCLE_ANGLE(360)*self.anglePercent;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    self.progressLayer.path = path.CGPath;
}

- (void)updateProgressPathWithAnimating
{
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat radius = MIN(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2) - self.progressLayer.lineWidth / 2;
    CGFloat startAngle = CIRCLE_ANGLE(-90);
    CGFloat endAngle = CIRCLE_ANGLE(-40);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    self.progressLayer.path = path.CGPath;
}

- (void)updateBackgroundPath
{
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat radius = MIN(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2) - self.progressLayer.lineWidth / 2;
    CGFloat startAngle = CIRCLE_ANGLE(-90);
    CGFloat endAngle = CIRCLE_ANGLE(270);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    self.backbgroundLayer.path = path.CGPath;
}

#pragma mark - Properties

- (CAShapeLayer *)progressLayer
{
    if (!_progressLayer) {
        UIColor *frontLineColor = CIRCLE_LINE_COLOR_DEFAULT;
        if (self.frontLineColor) {
            frontLineColor = self.frontLineColor;
        }
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.strokeColor = frontLineColor.CGColor;
        _progressLayer.fillColor = nil;
        _progressLayer.lineWidth = 1.5f;
    }
    return _progressLayer;
}

- (CAShapeLayer *)backbgroundLayer
{
    if (!_backbgroundLayer) {
        UIColor *backLineColor = CIRCLE_BACKGROUND_COLOR_DEFAULT;
        if (self.backLineColor) {
            backLineColor = self.backLineColor;
        }
        _backbgroundLayer = [CAShapeLayer layer];
        _backbgroundLayer.strokeColor = backLineColor.CGColor;
        _backbgroundLayer.fillColor = nil;
        _backbgroundLayer.lineWidth = 1.5f;
    }
    return _backbgroundLayer;
}

- (BOOL)isAnimating
{
    return _isAnimating;
}

- (CGFloat)lineWidth
{
    return self.progressLayer.lineWidth;
}

- (void)setFrontLineColor:(UIColor *)frontLineColor
{
    _frontLineColor = frontLineColor;
    self.progressLayer.strokeColor = frontLineColor.CGColor;
    [self updateProgressPath];
}

- (void)setBackLineColor:(UIColor *)backLineColor
{
    _backLineColor = backLineColor;
    self.backbgroundLayer.strokeColor = backLineColor.CGColor;
    [self updateBackgroundPath];
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    self.progressLayer.lineWidth = lineWidth;
    self.backbgroundLayer.lineWidth = lineWidth;
    [self updateProgressPath];
    [self updateBackgroundPath];
}

- (void)setAnglePercent:(CGFloat)anglePercent
{
    _anglePercent = anglePercent;
    [self updateProgressPath];
}

@end
