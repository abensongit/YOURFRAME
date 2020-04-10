
#import <Foundation/Foundation.h>

/*
 Useful methods to ease NSArray queries.
 */
@interface NSArray (Query)

/*
 Returns the lastest object's index in the array.
 
 @returns The last object's index in the array.
*/
- (NSUInteger)lastObjectIndex;


/*
 Returns a reversed array.
 
 @returns A reversed array.
*/
- (NSArray *)reversedArray;

@end
