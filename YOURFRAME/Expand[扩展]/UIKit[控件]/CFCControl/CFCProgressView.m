

#import "CFCProgressView.h"

#define KZLLProgressBorderWidth 1.2f
#define KZLLProgressPadding 0.5f

@interface CFCProgressView ()

@property (nonatomic, weak) UIView *tView;

@property (nonatomic, weak) UIView *borderView;

@end

@implementation CFCProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 颜色
        self.progressColor = [UIColor colorWithRed:0/255.0 green:191/255.0 blue:255/255.0 alpha:1];
        
        // 边框
        UIView *borderView = [[UIView alloc] initWithFrame:self.bounds];
        borderView.backgroundColor = COLOR_HEXSTRING(@"#E9E9EE");
        borderView.layer.borderColor = [COLOR_HEXSTRING(@"#E9E9EE") CGColor];
        borderView.layer.borderWidth = KZLLProgressBorderWidth;
        [self addSubview:borderView];
        self.borderView = borderView;
        
        // 进度
        UIView *tView = [[UIView alloc] init];
        tView.backgroundColor = self.progressColor;
        [self addSubview:tView];
        self.tView = tView;
    }
    
    return self;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    CGFloat margin = KZLLProgressBorderWidth + KZLLProgressPadding;
    CGFloat maxWidth = self.bounds.size.width - margin * 2;
    CGFloat heigth = self.bounds.size.height - margin * 2;
    
    _tView.frame = CGRectMake(margin, margin, maxWidth * progress, heigth);
}


- (void)setProgressColor:(UIColor *)progressColor
{
    _progressColor = progressColor;
    self.borderView.layer.borderColor = [COLOR_HEXSTRING(@"#E9E9EE") CGColor];
    self.tView.backgroundColor = _progressColor;
}


@end


