
#import "NSString+CFCNetworkingCacheUtil.h"

@implementation NSString (CFCNetworkingCacheUtil)

- (NSString *)urlStringByAppendParameters:(NSDictionary *)parameters
{
    // 初始化参数变量
    NSString *str = @"&";
    
    // 快速遍历参数数组
    for(id key in parameters) {
        str = [str stringByAppendingString:key];
        str = [str stringByAppendingString:@"＝"];
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%@", [parameters objectForKey:key]]];
        str = [str stringByAppendingString:@"&"];
    }
    // 处理多余的&以及返回含参url
    if (str.length > 1) {
        // 去掉末尾的&
        str = [str substringToIndex:str.length - 1];
        // 返回含参url
        return [self stringByAppendingString:str];
    }
    return self;
}

@end
