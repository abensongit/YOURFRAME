
#import "NSArray+Query.h"

@implementation NSArray (Query)


- (NSUInteger)lastObjectIndex
{
    return [self indexOfObject:[self lastObject]];
}


- (NSArray *)reversedArray
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    
    for (id element in enumerator) [array addObject:element];
    
    return array;
}

@end
