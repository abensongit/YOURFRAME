
#import <Foundation/Foundation.h>

/*
 */
@interface NSObject (KVC)

/*
 Returns all the available keys of an object.
 Based on Chatchavan's answer on StackOverflow http://stackoverflow.com/questions/754824/get-an-object-attributes-list-in-objective-c/4008326#4008326

 @returns The available keys of an object.
 */
- (NSArray *)allKeys;

@end
