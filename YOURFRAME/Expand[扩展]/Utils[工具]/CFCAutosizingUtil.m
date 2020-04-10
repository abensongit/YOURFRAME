//
//  适配工具
//
//  坐标：表示屏幕物理尺寸大小，坐标变大了，表示机器屏幕尺寸变大了。
//  像素：表示屏幕图片的大小，跟坐标之间有个对应关系，比如1:1或1:2等。
//  PPI：代表屏幕物理大小到图片大小的比例值，如果PPI不变，则坐标和像素的比例不会变。
//
//  iPhone 4以前
//  iPhone、iPhone3/3G机型未采用retina，坐标是320 x 480，屏幕像素320 x 480 ，他们一一对应，1:1关系。即一个坐标对应1个像素。
//
//  iPhone 4/4s
//  机器采用了retina屏幕，坐标是320 x 480，屏幕像素640 x 960，他们之间是1:2关系。即一个坐标对应2个像素。
//
//  iPhone 5/5s/5c
//  机器采用了retina屏幕，坐标是320 x 568，屏幕像素640 x 1136，他们之间关系式1:2关系。即一个坐标对应2个像素。
//
//  iPhone 6
//  机器采用了retina屏幕，坐标是375 x 667，屏幕像素750 x 1334，他们之间关系式1:2关系。即一个坐标对应2个像素。
//
//  iPhone 6 plus
//  机器采用了retina屏幕，坐标是414 x 736，屏幕像素1080 x 1920，他们之间关系式1:2.6关系。即一个坐标对应2.6个像素。
//
//  iPhone X
//  机器采用了retina屏幕，坐标是375 x 812，屏幕像素2436 x 1125，他们之间关系式XXXX关系。即一个坐标对应XXXX个像素。
//
//  iPhone XR
//  机器采用了retina屏幕，坐标是414 x 896，屏幕像素1792 x 828，他们之间关系式XXXX关系。即一个坐标对应XXXX个像素。
//
//  iPhone XS
//  机器采用了retina屏幕，坐标是375 x 812，屏幕像素2436 x 1125，他们之间关系式XXXX关系。即一个坐标对应XXXX个像素。
//
//  iPhone XS MAX
//  机器采用了retina屏幕，坐标是414 x 896，屏幕像素2688 x 1242，他们之间关系式XXXX关系。即一个坐标对应XXXX个像素。
//
//     机型           分辨率       PPI   大小(inch)        坐标               比例    宽高比      屏幕      发行时间  发行时系统
//  iPhoneXS Max  1242 x 2688    458     5.8      {{0, 0}, {414, 896}}    xxxx    9:19    retina HD    2018    iOS12
//  iPhoneXS      1125 x 2436    458     5.8      {{0, 0}, {375, 812}}    xxxx    9:19    retina HD    2018    iOS12
//  iPhoneXR      1125 x 2436    458     5.8      {{0, 0}, {414, 896}}    xxxx    9:19    retina HD    2018    iOS12
//  iPhoneX       1125 x 2436    458     5.8      {{0, 0}, {375, 812}}    xxxx    9:19    retina HD    2017    iOS11
//  iPhone8  P    1080 x 1920    401     5.5      {{0, 0}, {414, 736}}    2.60    9:16    retina HD    2017    iOS11
//  iPhone8       750   x 1334   326     4.7      {{0, 0}, {375, 667}}    2       9:16    retina HD    2017    iOS11
//  iPhone7  P    1080 x 1920    401     5.5      {{0, 0}, {414, 736}}    2.60    9:16    retina HD    2016    iOS10
//  iPhone7       750   x 1334   326     4.7      {{0, 0}, {375, 667}}    2       9:16    retina HD    2016    iOS10
//  iPhone6s P    1080 x 1920    401     5.5      {{0, 0}, {414, 736}}    2.60    9:16    retina HD    2015    iOS9
//  iPhone6s      750  x 1334    326     4.7      {{0, 0}, {375, 667}}    2       9:16    retina HD    2015    iOS9
//  iPhone6  P    1080 x 1920    401     5.5      {{0, 0}, {414, 736}}    2.60    9:16    retina HD    2014    iOS8
//  iPhone6       750  x 1334    326     4.7      {{0, 0}, {375, 667}}    2       9:16    retina HD    2014    iOS8
//  iPhone SE     640  x 1136    326     4.0      {{0, 0}, {320, 568}}    2                            2016    iOS10
//  iPhone5s/5c   640  x 1136    326     4.0      {{0, 0}, {320, 568}}    2       9:16    retina       2013    iOS7
//  iPhone5       640  x 1136    326     4.0      {{0, 0}, {320, 568}}    2       9:16    retina       2012    iOS6
//  iPhone4s      640  x 960     326     3.5      {{0, 0}, {320, 480}}    2       2:3     retina       2011    iOS5
//  iPhone4       640  x 960     326     3.5      {{0, 0}, {320, 480}}    2       2:3     retina       2010    iOS4
//  iPhone3g      320  x 480     163     3.0      {{0, 0}, {320, 480}     1       2:3       否         2009    iOS3
//  iPhone3       2008、2009(中国)
//  iPhone        2007
//
//
//  □ 选择 iPhone 7 作为基准设计尺寸，然后通过一套适配规则自动适配到另外两种尺寸，总结起来就一句话：文字流式，控件弹性，图片等比缩放。
//  □ 控件弹性指的是 => navigation、cell、bar等适配过程中垂直方向上高度不变；水平方向宽度变化时，通过调整元素间距或元素右对齐的方式实现自适应。这样屏幕越大，在垂直方向上可以显示更多内容，发挥大屏幕的优势。
//


#import "CFCAutosizingUtil.h"

@implementation CFCAutosizingUtil

#pragma mark - 以iPhone7的屏幕为基准进行适配
CGFloat const CFC_IPHONE_AUTOSIZE_BASIC_WIDTH = 375.0f;
CGFloat const CFC_IPHONE_AUTOSIZE_BASIC_HEIGHT = 667.0f;

#pragma mark -
#pragma mark 适配字体大小
+ (CGFloat)getAutosizeFontSize:(CGFloat)fontSize
{
    CFCIPhoneAutosizeType autosizeType = [[self class] getAutosizeType];
    
    switch (autosizeType) {
        case CFCIPhoneAutosizeTypeW320H480: {
            return SCREEN_MIN_LENGTH*(fontSize/CFC_IPHONE_AUTOSIZE_BASIC_WIDTH);
        }
        case CFCIPhoneAutosizeTypeW320H568: {
            return SCREEN_MIN_LENGTH*(fontSize/CFC_IPHONE_AUTOSIZE_BASIC_WIDTH);
        }
        case CFCIPhoneAutosizeTypeW375H667: {
            return SCREEN_MIN_LENGTH*(fontSize/CFC_IPHONE_AUTOSIZE_BASIC_WIDTH);
        }
        case CFCIPhoneAutosizeTypeW414H736: {
            return fontSize;
        }
        case CFCIPhoneAutosizeTypeW375H812: {
            return fontSize;
        }
        case CFCIPhoneAutosizeTypeW414H896: {
            return fontSize;
        }
        default: {
            return fontSize;
        }
    }
}

#pragma mark 适配字体大小 - 以375*667为基础等比例缩放
+ (CGFloat)getAutosizeFontSizeScale:(CGFloat)fontSize
{
    CFCIPhoneAutosizeType autosizeType = [[self class] getAutosizeType];
    
    switch (autosizeType) {
        case CFCIPhoneAutosizeTypeW320H480: {
            return SCREEN_MIN_LENGTH*(fontSize/CFC_IPHONE_AUTOSIZE_BASIC_WIDTH);
        }
        case CFCIPhoneAutosizeTypeW320H568: {
            return SCREEN_MIN_LENGTH*(fontSize/CFC_IPHONE_AUTOSIZE_BASIC_WIDTH);
        }
        case CFCIPhoneAutosizeTypeW375H667: {
            return SCREEN_MIN_LENGTH*(fontSize/CFC_IPHONE_AUTOSIZE_BASIC_WIDTH);
        }
        case CFCIPhoneAutosizeTypeW414H736: {
            return SCREEN_MIN_LENGTH*(fontSize/CFC_IPHONE_AUTOSIZE_BASIC_WIDTH);
        }
        case CFCIPhoneAutosizeTypeW375H812: {
            return SCREEN_MIN_LENGTH*(fontSize/CFC_IPHONE_AUTOSIZE_BASIC_WIDTH);
        }
        case CFCIPhoneAutosizeTypeW414H896: {
            return SCREEN_MIN_LENGTH*(fontSize/CFC_IPHONE_AUTOSIZE_BASIC_WIDTH);
        }
        default: {
            return fontSize;
        }
    }
}

#pragma mark -
#pragma mark 适配视图宽度
+ (CGFloat)getAutosizeViewWidth:(CGFloat)width
{
    CFCIPhoneAutosizeType autosizeType = [[self class] getAutosizeType];
    switch (autosizeType) {
        case CFCIPhoneAutosizeTypeW320H480: {
            return SCREEN_MIN_LENGTH*(width/CFC_IPHONE_AUTOSIZE_BASIC_WIDTH);
        }
        case CFCIPhoneAutosizeTypeW320H568: {
            return SCREEN_MIN_LENGTH*(width/CFC_IPHONE_AUTOSIZE_BASIC_WIDTH);
        }
        case CFCIPhoneAutosizeTypeW375H667: {
            return SCREEN_MIN_LENGTH*(width/CFC_IPHONE_AUTOSIZE_BASIC_WIDTH);
        }
        case CFCIPhoneAutosizeTypeW414H736: {
            return width;
        }
        case CFCIPhoneAutosizeTypeW375H812: {
            return width;
        }
        case CFCIPhoneAutosizeTypeW414H896: {
            return width;
        }
        default: {
            return width;
        }
    }
}

#pragma mark 适配视图宽度 - 以375*667为基础等比例缩放
+ (CGFloat)getAutosizeViewWidthScale:(CGFloat)width
{
    CFCIPhoneAutosizeType autosizeType = [[self class] getAutosizeType];
    switch (autosizeType) {
        case CFCIPhoneAutosizeTypeW320H480: {
            return SCREEN_MIN_LENGTH*(width/CFC_IPHONE_AUTOSIZE_BASIC_WIDTH);
        }
        case CFCIPhoneAutosizeTypeW320H568: {
            return SCREEN_MIN_LENGTH*(width/CFC_IPHONE_AUTOSIZE_BASIC_WIDTH);
        }
        case CFCIPhoneAutosizeTypeW375H667: {
            return SCREEN_MIN_LENGTH*(width/CFC_IPHONE_AUTOSIZE_BASIC_WIDTH);
        }
        case CFCIPhoneAutosizeTypeW414H736: {
            return SCREEN_MIN_LENGTH*(width/CFC_IPHONE_AUTOSIZE_BASIC_WIDTH);
        }
        case CFCIPhoneAutosizeTypeW375H812: {
            return SCREEN_MIN_LENGTH*(width/CFC_IPHONE_AUTOSIZE_BASIC_WIDTH);
        }
        case CFCIPhoneAutosizeTypeW414H896: {
            return SCREEN_MIN_LENGTH*(width/CFC_IPHONE_AUTOSIZE_BASIC_WIDTH);
        }
        default: {
            return width;
        }
    }
}

#pragma mark -
#pragma mark 适配视图高度
+ (CGFloat)getAutosizeViewHeight:(CGFloat)height
{
    CFCIPhoneAutosizeType autosizeType = [[self class] getAutosizeType];
    switch (autosizeType) {
        case CFCIPhoneAutosizeTypeW320H480: {//4,4s
            return SCREEN_MAX_LENGTH*(height/CFC_IPHONE_AUTOSIZE_BASIC_HEIGHT);
        }
        case CFCIPhoneAutosizeTypeW320H568: {//5 5se
            return SCREEN_MAX_LENGTH*(height/CFC_IPHONE_AUTOSIZE_BASIC_HEIGHT);
        }
        case CFCIPhoneAutosizeTypeW375H667: {//6,7
            return SCREEN_MAX_LENGTH*(height/CFC_IPHONE_AUTOSIZE_BASIC_HEIGHT);
        }
        case CFCIPhoneAutosizeTypeW414H736: {//6,7plus
            return height;
        }
        case CFCIPhoneAutosizeTypeW375H812: {//6,7plus
            return height;
        }
        case CFCIPhoneAutosizeTypeW414H896: {
            return height;
        }
        default: {
            return height;
        }
    }
}

#pragma mark 适配视图高度 - 以375*667为基础等比例缩放
+ (CGFloat)getAutosizeViewHeightScale:(CGFloat)height
{
    CFCIPhoneAutosizeType autosizeType = [[self class] getAutosizeType];
    switch (autosizeType) {
        case CFCIPhoneAutosizeTypeW320H480: {
            return SCREEN_MAX_LENGTH*(height/CFC_IPHONE_AUTOSIZE_BASIC_HEIGHT);
        }
        case CFCIPhoneAutosizeTypeW320H568: {
            return SCREEN_MAX_LENGTH*(height/CFC_IPHONE_AUTOSIZE_BASIC_HEIGHT);
        }
        case CFCIPhoneAutosizeTypeW375H667: {
            return SCREEN_MAX_LENGTH*(height/CFC_IPHONE_AUTOSIZE_BASIC_HEIGHT);
        }
        case CFCIPhoneAutosizeTypeW414H736: {
            return SCREEN_MAX_LENGTH*(height/CFC_IPHONE_AUTOSIZE_BASIC_HEIGHT);
        }
        case CFCIPhoneAutosizeTypeW375H812: {
            return SCREEN_MAX_LENGTH*(height/CFC_IPHONE_AUTOSIZE_BASIC_HEIGHT);
        }
        case CFCIPhoneAutosizeTypeW414H896: {
            return SCREEN_MAX_LENGTH*(height/CFC_IPHONE_AUTOSIZE_BASIC_HEIGHT);
        }
        default: {
            return height;
        }
    }
}


#pragma mark -
#pragma mark 适配视图间隔
+ (CGFloat)getAutosizeViewMargin:(CGFloat)margin
{
    return margin;
}

#pragma mark 适配视图间隔 - 以375*667为基础等比例缩放
+ (CGFloat)getAutosizeViewMarginScale:(CGFloat)margin
{
    CFCIPhoneAutosizeType autosizeType = [[self class] getAutosizeType];
    switch (autosizeType) {
        case CFCIPhoneAutosizeTypeW320H480: {
            return SCREEN_MIN_LENGTH*(margin/CFC_IPHONE_AUTOSIZE_BASIC_WIDTH);
        }
        case CFCIPhoneAutosizeTypeW320H568: {
            return SCREEN_MIN_LENGTH*(margin/CFC_IPHONE_AUTOSIZE_BASIC_WIDTH);
        }
        case CFCIPhoneAutosizeTypeW375H667: {
            return SCREEN_MIN_LENGTH*(margin/CFC_IPHONE_AUTOSIZE_BASIC_WIDTH);
        }
        case CFCIPhoneAutosizeTypeW414H736: {
            return SCREEN_MIN_LENGTH*(margin/CFC_IPHONE_AUTOSIZE_BASIC_WIDTH);
        }
        case CFCIPhoneAutosizeTypeW375H812: {
            return SCREEN_MIN_LENGTH*(margin/CFC_IPHONE_AUTOSIZE_BASIC_WIDTH);
        }
        case CFCIPhoneAutosizeTypeW414H896: {
            return SCREEN_MIN_LENGTH*(margin/CFC_IPHONE_AUTOSIZE_BASIC_WIDTH);
        }
        default: {
            return margin;
        }
    }
}

#pragma mark - 获取适配类型
+ (CFCIPhoneAutosizeType)getAutosizeType
{
    // bounds method gets the points not the pixels!!!
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    
    // get current interface Orientation
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    
    // unknown
    if (UIInterfaceOrientationUnknown == orientation) {
        return CFCIPhoneAutosizeTypeUnKnown;
    }
    
    // portrait:width * height
    //
    // iPhone4     : 320 * 480    640  * 960
    // iPhone5     : 320 * 568    640  * 1136
    // iPhone6     : 375 * 667    750  * 1334
    // iPhone6Plus : 414 * 736    1080 * 1920
    // iPhoneXS    : 375 * 812    1125 * 2436
    // iPhoneXSMAX : 414 * 896    1242 * 2688
    
    // UIInterfaceOrientationLandscapeLeft 向左，即HOME键在右
    // UIInterfaceOrientationLandscapeRight 向右，即HOME键在左
    // UIInterfaceOrientationPortrait 正立，即HOME键在下
    // UIInterfaceOrientationPortraitUpsideDown 倒立，即HOME键在上
    
    // portrait
    if (UIInterfaceOrientationPortrait == orientation || UIDeviceOrientationPortraitUpsideDown == orientation) {
        if (width ==  320.0f) {
            if (height == 480.0f) {
                return CFCIPhoneAutosizeTypeW320H480;
            } else {
                return CFCIPhoneAutosizeTypeW320H568;
            }
        } else if (width == 375.0f) {
            if (height == 667.0f) {
                return CFCIPhoneAutosizeTypeW375H667;
            } else {
                return CFCIPhoneAutosizeTypeW375H812;
            }
        } else if (width == 414.0f) {
            if (height == 736.0f) {
                return CFCIPhoneAutosizeTypeW414H736;
            } else {
                return CFCIPhoneAutosizeTypeW414H896;
            }
        }
    }
    // landscape
    else if (UIInterfaceOrientationLandscapeLeft == orientation || UIInterfaceOrientationLandscapeRight == orientation) {
        if (height == 320.0) {
            if (width == 480.0f) {
                return CFCIPhoneAutosizeTypeW320H480;
            } else {
                return CFCIPhoneAutosizeTypeW320H568;
            }
        } else if (height == 375.0f) {
            if (width == 667.0f) {
                return CFCIPhoneAutosizeTypeW375H667;
            } else {
                return CFCIPhoneAutosizeTypeW375H812;
            }
        } else if (height == 414.0f) {
            if (height == 736.0f) {
                return CFCIPhoneAutosizeTypeW414H736;
            } else {
                return CFCIPhoneAutosizeTypeW414H896;
            }
        }
    }
    
    return CFCIPhoneAutosizeTypeUnKnown;
}

#pragma mark - 创建单例
+ (instancetype)sharedAutosizingUtil
{
    static CFCAutosizingUtil *_singetonInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if (nil == _singetonInstance) {
            _singetonInstance = [[super allocWithZone:NULL] init];
        }
    });
    return _singetonInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [[self class] sharedAutosizingUtil];
}

- (id)copyWithZone:(struct _NSZone *)zone
{
    return [[self class] sharedAutosizingUtil];
}

@end



