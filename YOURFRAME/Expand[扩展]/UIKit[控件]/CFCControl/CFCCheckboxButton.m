

#import "CFCCheckboxButton.h"

@interface CFCCheckboxButton () {
    BOOL loaded;
}
@property(nonatomic, strong) UILabel *textLabel;
@property(nonatomic, strong) UIImageView *imageView;
@end


@implementation CFCCheckboxButton

@synthesize checked = _checked;
@synthesize disabled = _disabled;
@synthesize text = _text;
@synthesize textLabel = _textLabel;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-missing-super-calls"
- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
}
#pragma clang diagnostic pop


-(void)drawRect:(CGRect)rect
{
    if(!loaded) {
        // 图标
        CGFloat imageSize = self.frame.size.height*0.9f;
        UIImage *image = [UIImage imageNamed:self.checked ? _selectBgImage : _normalBgImage];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                               (self.frame.size.height-imageSize)*0.5f,
                                                                               imageSize,
                                                                               imageSize)];
        [imageView setImage:image];
        [self setImageView:imageView];
        [self addSubview:imageView];
        
        // 标题
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageSize*1.3f, 0, self.frame.size.width-imageSize*1.3f, self.frame.size.height)];
        _textLabel.font = _textFont;
        _textLabel.textColor = _textColor;
        _textLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_textLabel];
        
        loaded = TRUE;
    }
    
    if(self.disabled) {
        self.userInteractionEnabled = FALSE;
        self.alpha = 0.7f;
    } else {
        self.userInteractionEnabled = TRUE;
        self.alpha = 1.0f;
    }
    
    if(self.text) {
        _textLabel.text = self.text;
    }

    [self.textLabel setTextColor:_textColor];
    [self.layer setMasksToBounds:YES];
  
    NSString *imageName = self.checked ? _selectBgImage : _normalBgImage;
    [self.imageView setImage:[UIImage imageNamed:imageName]];
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self setChecked:!self.checked];
    return TRUE;
}

- (void)setChecked:(BOOL)boolValue
{
    _checked = boolValue;
    [self setNeedsDisplay];
}

- (void)setDisabled:(BOOL)boolValue
{
    _disabled = boolValue;
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)stringValue
{
    _text = stringValue;
    [self setNeedsDisplay];
}

@end

