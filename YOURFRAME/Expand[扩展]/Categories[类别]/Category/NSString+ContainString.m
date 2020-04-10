
#import "NSString+ContainString.h"

@implementation NSString (ContainString)

- (BOOL)hasContainString:(NSString*)subString
{
    if(!subString) {
        return NO;
    }
    
    if([self respondsToSelector:@selector(containsString:)]) { // ≥iOS8
        return [self containsString:subString];
    } else { // <iOS8
        NSRange range = [self rangeOfString:subString];
        return (range.location!=NSNotFound ? YES : NO); // return (range.length>0 ? YES : NO);
    }
}

@end
