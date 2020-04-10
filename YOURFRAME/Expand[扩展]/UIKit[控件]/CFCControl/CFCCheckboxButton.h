

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFCCheckboxButton : UIControl

- (void)setChecked:(BOOL)boolValue;
- (void)setDisabled:(BOOL)boolValue;
- (void)setText:(NSString *)stringValue;

@property(nonatomic, copy) NSString *text;
@property(nonatomic, strong) UIFont *textFont;
@property(nonatomic, strong) UIColor *textColor;

@property(nonatomic, assign) BOOL checked;
@property(nonatomic, assign) BOOL disabled;

@property(nonatomic, copy) NSString *normalBgImage;
@property(nonatomic, copy) NSString *selectBgImage;

@end

NS_ASSUME_NONNULL_END
