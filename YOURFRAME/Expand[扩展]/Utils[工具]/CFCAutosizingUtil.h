
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, CFCIPhoneAutosizeType){
    CFCIPhoneAutosizeTypeW320H480, // 320*480 iPhone4
    CFCIPhoneAutosizeTypeW320H568, // 320*568 iPhone5
    CFCIPhoneAutosizeTypeW375H667, // 375*667 iPhone6
    CFCIPhoneAutosizeTypeW414H736, // 414*736 iPhone6Plus
    CFCIPhoneAutosizeTypeW375H812, // 375*812 IPhoneXS
    CFCIPhoneAutosizeTypeW414H896, // 414*896 IPhoneXSMax
    CFCIPhoneAutosizeTypeUnKnown
};

@interface CFCAutosizingUtil : NSObject


#pragma mark - 以iPhone7的屏幕为基准进行适配
UIKIT_EXTERN CGFloat const CFC_IPHONE_AUTOSIZE_BASIC_WIDTH;
UIKIT_EXTERN CGFloat const CFC_IPHONE_AUTOSIZE_BASIC_HEIGHT;


#pragma mark -
#pragma mark 获取适配类型
+ (CFCIPhoneAutosizeType)getAutosizeType;


#pragma mark -
#pragma mark 适配字体大小
+ (CGFloat)getAutosizeFontSize:(CGFloat)fontSize;
#pragma mark 适配字体大小 - 以375*667为基础等比例缩放
+ (CGFloat)getAutosizeFontSizeScale:(CGFloat)fontSize;


#pragma mark -
#pragma mark 适配视图宽度
+ (CGFloat)getAutosizeViewWidth:(CGFloat)width;
#pragma mark 适配视图宽度 - 以375*667为基础等比例缩放
+ (CGFloat)getAutosizeViewWidthScale:(CGFloat)width;


#pragma mark -
#pragma mark 适配视图高度
+ (CGFloat)getAutosizeViewHeight:(CGFloat)height;
#pragma mark 适配视图高度 - 以375*667为基础等比例缩放
+ (CGFloat)getAutosizeViewHeightScale:(CGFloat)height;


#pragma mark -
#pragma mark 适配视图间隔
+ (CGFloat)getAutosizeViewMargin:(CGFloat)margin;
#pragma mark 适配视图间隔 - 以375*667为基础等比例缩放
+ (CGFloat)getAutosizeViewMarginScale:(CGFloat)margin;


#pragma mark -
#pragma mark 创建单例
+ (instancetype)sharedAutosizingUtil;

@end


NS_ASSUME_NONNULL_END

