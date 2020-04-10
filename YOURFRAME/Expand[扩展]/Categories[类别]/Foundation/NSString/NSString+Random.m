
#import "NSString+Random.h"

@implementation NSString (Random)

- (NSString *)randomString
{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:self.length];
    for (NSInteger i = 0; i < self.length; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex:arc4random_uniform((int32_t)([letters length]))]];
    }
    return randomString;
}

- (NSString *)randomStringWithLetters:(NSString *)letters
{
    NSMutableString *randomString = [NSMutableString stringWithCapacity:self.length];
    for (NSInteger i = 0; i <self.length; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int32_t)[letters length])]];
    }
    return randomString;
}

@end

