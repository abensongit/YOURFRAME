
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef void(^CFCAssistiveTouchButtonClickBlock)(void);

@interface CFCAssistiveTouchButton : UIButton {
    BOOL MoveEnable;
    BOOL MoveEnabled;
    CGPoint benginpoint;
}

@property(nonatomic, assign) BOOL MoveEnable;
@property(nonatomic, assign) BOOL MoveEnabled;
@property (nonatomic, copy) CFCAssistiveTouchButtonClickBlock clickBlock;

@end
