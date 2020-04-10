
#import "CFCSysUtil.h"

@implementation CFCSysUtil

#pragma mark -
#pragma mark 验证对象是否为空（数组、字典、字符串）
+ (BOOL)validateObjectIsNull:(id)obj
{
    if (nil == obj || obj == [NSNull null]) {
        return YES;
    }
    
    // 字典
    if ([obj isKindOfClass:[NSDictionary class]]) {
        
        if([obj isKindOfClass:[NSNull class]]) {
            return YES;
        }
    }
    // 数组
    else if ([obj isKindOfClass:[NSArray class]]) {
        
        if([obj isKindOfClass:[NSNull class]]) {
            return YES;
        }
    }
    // 字符串
    else if ([obj isKindOfClass:[NSString class]]) {
        
        return [CFCSysUtil validateStringEmpty:obj];
    }
    
    return NO;
}

#pragma mark 验证字符串是否为空
+ (BOOL)validateStringEmpty:(NSString *)value
{
    if (nil == value
        || [@"NULL" isEqualToString:value]
        || [value isEqualToString:@"<null>"]
        || [value isEqualToString:@"(null)"]
        || [value isEqualToString:@"null"]) {
        return YES;
    }
    // 删除两端的空格和回车
    NSString *str = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return (str.length <= 0);
}

#pragma mark 验证字符串是否为URL
+ (BOOL)validateStringUrl:(NSString *)url
{
    NSString *regex =@"[a-zA-z]+://[^\\s]*";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:url];
}


#pragma mark -
#pragma mark 验证请求数据是否成功
+ (BOOL)validateResultCodeIsSuccess:(NSInteger)resultCode
{
    if (200 == resultCode) {
        return YES;
    }
    return NO;
}


#pragma mark -
#pragma mark 删除字符串两端的空格与回车
+ (NSString *)stringByTrimmingWhitespaceAndNewline:(NSString *)value
{
    if ([CFCSysUtil validateObjectIsNull:value]) {
        return @"";
    }
    
    return [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark 删除字符串中的空格与回车
+ (NSString *)stringRemoveSpaceAndWhitespaceAndNewline:(NSString *)value
{
    NSString *temp = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}

#pragma mark 获取带有不同样式的文字内容
+ (NSAttributedString *)attributedString:(NSArray*)stringArray attributeArray:(NSArray *)attributeArray
{
    // 定义要显示的文字内容
    NSString *string = [stringArray componentsJoinedByString:@""]; // 拼接传入的字符串数组
    // 辅助获取范围值字符串
    NSString *rangestr = @"";
    // 通过要显示的文字内容来创建一个带属性样式的字符串对象
    NSMutableAttributedString * result = [[NSMutableAttributedString alloc] initWithString:string];
    for(NSInteger i = 0; i < stringArray.count; i++) {
        // 获取当前需要设置样式的字符串
        NSString *attriString = stringArray[i];
        // 返回需要设置样式的字符串范围
        NSRange range = [string rangeOfString:attriString];
        while ([string rangeOfString:attriString].location != NSNotFound) {
            range = [string rangeOfString:attriString];
            if (range.location >= rangestr.length) {
                rangestr = [NSString stringWithFormat:@"%@%@", rangestr, attriString];
                break;
            }
            string = [string stringByReplacingCharactersInRange:NSMakeRange(range.location, range.length) withString:[attriString randomString]];
        }
        // 将某一范围内的字符串设置样式
        [result setAttributes:attributeArray[i] range:range];
    }
    // 返回已经设置好了的带有样式的文字
    return [[NSAttributedString alloc] initWithAttributedString:result];
}


#pragma mark -
#pragma mark 获取所有字体名称列表
+ (NSArray<NSString *> *)getAllFontFamilyNames
{
    NSMutableArray<NSString *> *fontNames = [NSMutableArray array];
    for(NSString *fontfamilyname in [UIFont familyNames]) {
        CFCLog(@"Family:'%@'",fontfamilyname);
        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname]) {
            [fontNames addObject:fontName];
            CFCLog(@"\tFont:'%@'",fontName);
        }
    }
    return [NSArray arrayWithArray:fontNames];
}


@end

