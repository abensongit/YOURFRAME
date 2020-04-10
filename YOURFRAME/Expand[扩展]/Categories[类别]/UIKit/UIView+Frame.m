
#import "UIView+Frame.h"

@implementation UIView (Frame)

#pragma mark - Getters

- (CGFloat)x
{
    return self.origin.x;
}

- (CGFloat)y
{
    return self.origin.y;
}

- (CGFloat)width
{
    return self.size.width;
}

- (CGFloat)height
{
    return self.size.height;
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGPoint)origin
{
    return self.frame.origin;
}


#pragma mark - Setters

- (void)setX:(CGFloat)x
{
    CGPoint point = self.origin;
    point.x = x;
    self.origin = point;
}

- (void)setY:(CGFloat)y
{
    CGPoint point = self.origin;
    point.y = y;
    self.origin = point;
}

- (void)setWidth:(CGFloat)width
{
    CGSize size = self.size;
    size.width = width;
    self.size = size;
}

- (void)setHeight:(CGFloat)height
{
    CGSize size = self.size;
    size.height = height;
    self.size = size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect rect = self.frame;
    rect.origin = origin;
    self.frame = rect;
}

- (void)setSize:(CGSize)size
{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}


-(CGFloat)centerX {
    return self.center.x;
}

-(void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

-(CGFloat)centerY {
    return self.center.y;
}

-(void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top {
    self.frame = CGRectMake(self.left, top, self.width, self.height);
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    self.frame = CGRectMake(self.left, bottom - self.height, self.width, self.height);
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left {
    self.frame = CGRectMake(left, self.top, self.width, self.height);
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    self.frame = CGRectMake(right - self.width, self.top, self.width, self.height);
}


#pragma mark - Summation

- (void)addToX:(CGFloat)value
{
    self.x = self.x + value;
}

- (void)addToY:(CGFloat)value
{
    self.y = self.y + value;
}

- (void)addToWidth:(CGFloat)value
{
    self.width = self.width + value;
}

- (void)addToHeight:(CGFloat)value
{
    self.height = self.height + value;
}


#pragma mark - Multiplication

- (void)multiplyToX:(CGFloat)value
{
    self.x = self.x * value;
}

- (void)multiplyToY:(CGFloat)value
{
    self.y = self.y * value;
}

- (void)multiplyToWidth:(CGFloat)value
{
    self.width = self.width * value;
}

- (void)multiplyToHeight:(CGFloat)value
{
    self.height = self.height * value;
}


#pragma mark - Deprecated

- (void)setFrameOriginX:(CGFloat)x
{
    self.x = x;
}

- (void)setFrameOriginY:(CGFloat)y
{
    self.y = y;
}

- (void)setFrameWidth:(CGFloat)width
{
    self.width = width;
}

- (void)setFrameHeight:(CGFloat)height
{
    self.height = height;
}

- (void)setFrameOrigin:(CGPoint)origin
{
    self.origin = origin;
}

- (void)setFrameSize:(CGSize)size
{
    self.size = size;
}

@end
