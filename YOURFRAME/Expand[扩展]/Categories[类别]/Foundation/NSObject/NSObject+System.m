
#import "NSObject+System.h"
#include <sys/utsname.h>

@implementation NSObject (System)

+ (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

+ (NSString *)deviceModel
{
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

+ (NSString *)deviceName
{
    NSString *platform = [NSObject deviceModel];
    
    if ([platform hasPrefix:@"iPhone1,1"])      return @"iPhone 2G";
    if ([platform hasPrefix:@"iPhone1,2"])      return @"iPhone 3G";
    if ([platform hasPrefix:@"iPhone2,1"])      return @"iPhone 3GS";
    if ([platform hasPrefix:@"iPhone3,1"])      return @"iPhone 4";
    if ([platform hasPrefix:@"iPhone3,2"])      return @"iPhone 4";
    if ([platform hasPrefix:@"iPhone3,3"])      return @"iPhone 4";
    if ([platform hasPrefix:@"iPhone4,1"])      return @"iPhone 4S";
    if ([platform hasPrefix:@"iPhone5,1"])      return @"iPhone 5";
    if ([platform hasPrefix:@"iPhone5,2"])      return @"iPhone 5";
    if ([platform hasPrefix:@"iPhone5,3"])      return @"iPhone 5C";
    if ([platform hasPrefix:@"iPhone5,4"])      return @"iPhone 5C";
    if ([platform hasPrefix:@"iPhone6,1"])      return @"iPhone 5S";
    if ([platform hasPrefix:@"iPhone6,2"])      return @"iPhone 5S";
    
    if([platform  hasPrefix:@"iPhone7,1"])      return @"iPhone 6 Plus";
    if([platform  hasPrefix:@"iPhone7,2"])      return @"iPhone 6";
    if([platform  hasPrefix:@"iPhone8,1"])      return @"iPhone 6S";
    if([platform  hasPrefix:@"iPhone8,2"])      return @"iPhone 6S Plus";
    if([platform  hasPrefix:@"iPhone8,4"])      return @"iPhone SE";
    if([platform  hasPrefix:@"iPhone9,1"])      return @"iPhone 7";
    if([platform  hasPrefix:@"iPhone9,2"])      return @"iPhone 7 Plus";
    if([platform  hasPrefix:@"iPhone10,1"])     return @"iPhone 8";
    if([platform  hasPrefix:@"iPhone10,4"])     return @"iPhone 8";
    if([platform  hasPrefix:@"iPhone10,2"])     return @"iPhone 8 Plus";
    if([platform  hasPrefix:@"iPhone10,5"])     return @"iPhone 8 Plus";
    if([platform  hasPrefix:@"iPhone10,3"])     return @"iPhone X";
    if([platform  hasPrefix:@"iPhone10,6"])     return @"iPhone X";
    if([platform  hasPrefix:@"iPhone11,8"])     return @"iPhone XR";
    if([platform  hasPrefix:@"iPhone11,2"])     return @"iPhone XS";
    if([platform  hasPrefix:@"iPhone11,4"])     return @"iPhone XS Max";
    if([platform  hasPrefix:@"iPhone11,6"])     return @"iPhone XS Max";
    
    if ([platform hasPrefix:@"iPod1,1"])        return @"iPod Touch 1G";
    if ([platform hasPrefix:@"iPod2,1"])        return @"iPod Touch 2G";
    if ([platform hasPrefix:@"iPod3,1"])        return @"iPod Touch 3G";
    if ([platform hasPrefix:@"iPod4,1"])        return @"iPod Touch 4G";
    if ([platform hasPrefix:@"iPad1,1"])        return @"iPad 1G";
    if ([platform hasPrefix:@"iPad2,1"])        return @"iPad 2(WiFi)";
    if ([platform hasPrefix:@"iPad2,2"])        return @"iPad 2(GSM)";
    if ([platform hasPrefix:@"iPad2,3"])        return @"iPad 2(CDMA)";
    if ([platform hasPrefix:@"iPad3,1"])        return @"iPad 3";
    if ([platform hasPrefix:@"iPad3,2"])        return @"iPad 3(GSM/CDMA)";
    if ([platform hasPrefix:@"iPad3,3"])        return @"iPad 3(GSM)";
    if ([platform hasPrefix:@"iPad3,4"])        return @"iPad 3(GSM)";
    if ([platform hasPrefix:@"iPad2,5"])        return @"iPad mini 1G";
    if ([platform hasPrefix:@"i386"])           return @"Simulator i386";
    if ([platform hasPrefix:@"x86_64"])         return @"Simulator x86_64";
    
    return platform;
}

+ (NSString *)OSVersion
{
#if TARGET_OS_IPHONE
    return [[UIDevice currentDevice] systemVersion];
#else
    return nil;
#endif
}

+ (BOOL)isOSMinimumRequired:(NSString *)minimum
{
    // eg  NSString *reqSysVer = @"4.0";
    
    NSString *currSysVer = [NSObject OSVersion];
    if ([currSysVer compare:minimum options:NSNumericSearch] != NSOrderedAscending) return YES;
    else return NO;
}

+ (float)density
{
#if TARGET_OS_IPHONE
    return [UIScreen mainScreen].scale;
#else
    return 0.0;
#endif
    
}

+ (NSString *)bundleName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
}

+ (NSString *)appName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)appVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)buildVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (BOOL)isJailbroken
{
#if TARGET_OS_IPHONE
    NSURL *URL = [NSURL URLWithString:@"cydia://"];
    return [[UIApplication sharedApplication] canOpenURL:URL];
#else
    return NO;
#endif
}

@end
