
#define kAssistiveTouchButtonXoffset 5

#import "CFCAssistiveTouchButton.h"

@implementation CFCAssistiveTouchButton
@synthesize MoveEnable;
@synthesize MoveEnabled;

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
  }
  return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  MoveEnabled = NO;
  [super touchesBegan:touches withEvent:event];
  
  if (!MoveEnable) {
    return;
  }
  
  UITouch *touch = [touches anyObject];
  benginpoint = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  if (!MoveEnable) {
    return;
  }
  
  UITouch *touch = [touches anyObject];
  CGPoint currentPosition = [touch locationInView:self];
  float offsetX = currentPosition.x - benginpoint.x;
  float offsetY = currentPosition.y - benginpoint.y;
  if (ABS(offsetX) < 4 && ABS(offsetY) < 4) {
    return;
  }
  
  MoveEnabled = YES;
  // 移动后坐标
  self.center = CGPointMake(self.center.x + offsetX, self.center.y + offsetY);
  // X轴左右极限坐标
  if (self.center.x >= (self.superview.frame.size.width - self.frame.size.width / 2 - kAssistiveTouchButtonXoffset)) {
    CGFloat x = self.superview.frame.size.width - self.frame.size.width / 2 - kAssistiveTouchButtonXoffset;
    self.center = CGPointMake(x, self.center.y);
  } else if (self.center.x <= (self.frame.size.width / 2 + kAssistiveTouchButtonXoffset)) {
    CGFloat x = self.frame.size.width / 2 + kAssistiveTouchButtonXoffset;
    self.center = CGPointMake(x, self.center.y);
  }
  
  // Y轴上下极限坐标
  CGFloat yOffset = STATUS_NAVIGATION_BAR_HEIGHT + kAssistiveTouchButtonXoffset;
  if (self.center.y > (self.superview.frame.size.height - self.frame.size.height / 2 - TAB_BAR_AND_DANGER_HEIGHT - kAssistiveTouchButtonXoffset)) {
    CGFloat x = self.center.x;
    CGFloat y = self.superview.frame.size.height - self.frame.size.height / 2 - TAB_BAR_AND_DANGER_HEIGHT - kAssistiveTouchButtonXoffset;
    self.center = CGPointMake(x, y);
  } else if (self.center.y <= self.frame.size.height / 2 + yOffset) {
    CGFloat x = self.center.x;
    CGFloat y = self.frame.size.height / 2;
    self.center = CGPointMake(x, y + yOffset);
  }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  if (!MoveEnabled && self.clickBlock) {
    self.clickBlock();
  }
  
  if (!MoveEnable) {
    return;
  }
  
  [self handleButtonMoveEndEvent];
  [super touchesEnded:touches withEvent:event];
}

- (void)handleButtonMoveEndEvent
{
  if (self.center.x >= self.superview.frame.size.width / 2) {
    // 向右侧移动
    [UIView beginAnimations:@"move" context:nil];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationDelegate:self];
    self.frame = CGRectMake(self.superview.width - self.width - kAssistiveTouchButtonXoffset, self.top, self.width, self.height);
    // 提交UIView动画
    [UIView commitAnimations];
  } else {
    // 向左侧移动
    [UIView beginAnimations:@"move" context:nil];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationDelegate:self];
    self.frame = CGRectMake(0.f + kAssistiveTouchButtonXoffset, self.top, self.width, self.height);
    // 提交UIView动画
    [UIView commitAnimations];
  }
}

@end

