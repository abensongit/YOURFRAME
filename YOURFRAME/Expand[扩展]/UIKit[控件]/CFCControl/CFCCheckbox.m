

#import "CFCCheckbox.h"


@implementation CFCCheckbox

@synthesize checked = _checked;
@synthesize disabled = _disabled;


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _normalBgColor = [UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1.00f];
        _selectBgColor = [UIColor colorWithRed:0.13f green:0.51f blue:0.97f alpha:1.00f];
        [self.layer setMasksToBounds:YES];
        [self.layer setBorderWidth:self.checked?0.0f:1.0f];
        [self.layer setCornerRadius:CGRectGetWidth(frame)*0.2f];
        [self.layer setBorderColor:[UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:1.00].CGColor];
        [self setBackgroundColor:self.checked ? _normalBgColor : _selectBgColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame selectBgColor:(UIColor *)selectBgColor normalBgColor:(UIColor *)normalBgColor
{
    self = [self initWithFrame:frame];
    if (self) {
        _normalBgColor = normalBgColor ? normalBgColor : [UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1.00f];
        _selectBgColor = selectBgColor ? selectBgColor : [UIColor colorWithRed:0.13f green:0.51f blue:0.97f alpha:1.00f];
        [self setBackgroundColor:self.checked ? _normalBgColor : _selectBgColor];
    }
    return self;
}



-(void)drawRect:(CGRect)rect
{
    UIColor* checkMarkColor = self.checked ? _normalBgColor : _selectBgColor;
    [self setBackgroundColor:checkMarkColor];
    [self.layer setBorderWidth:self.checked?0.0f:1.0f];
    
    CGRect frame = self.bounds;
    UIBezierPath* checkMarkPath = [UIBezierPath bezierPath];
    [checkMarkPath moveToPoint: CGPointMake(frame.size.width*0.20f, frame.size.width*0.50f)];
    [checkMarkPath addLineToPoint: CGPointMake(frame.size.width*0.45f, frame.size.width*0.70f)];
    [checkMarkPath addLineToPoint: CGPointMake(frame.size.width*0.80f, frame.size.width*0.25f)];
    [checkMarkPath setLineWidth:frame.size.width*0.12f];
    [_normalBgColor setStroke];
    [checkMarkPath stroke];
    
    if(self.disabled) {
        self.userInteractionEnabled = FALSE;
        self.alpha = 0.7f;
    } else {
        self.userInteractionEnabled = TRUE;
        self.alpha = 1.0f;
    }
}

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [self setChecked:!self.checked];
    return TRUE;
}

-(void)setChecked:(BOOL)boolValue {
    _checked = boolValue;
    [self setNeedsDisplay];
}

-(void)setDisabled:(BOOL)boolValue {
    _disabled = boolValue;
    [self setNeedsDisplay];
}

@end



