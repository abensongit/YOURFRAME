

#import <UIKit/UIKit.h>

@interface CFCCircleActivityIndicatorView : UIView

@property (nonatomic, assign) CGFloat anglePercent;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIColor *frontLineColor;
@property (nonatomic, strong) UIColor *backLineColor;
@property (nonatomic, readonly) BOOL isAnimating;

- (void)startAnimating;
- (void)stopAnimating;

@end
