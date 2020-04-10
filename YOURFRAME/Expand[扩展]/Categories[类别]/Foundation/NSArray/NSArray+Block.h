
#import <Foundation/Foundation.h>

@interface NSArray (Block)

- (void)enumerateObjects:(void (^)(id object))block;

- (void)enumerateObjectsWithIndex:(void (^)(id object, NSUInteger index))block;

- (NSArray *)filteredArray:(BOOL (^)(id object))block;

- (NSArray *)rejectedArray:(BOOL (^)(id object))block;

@end
