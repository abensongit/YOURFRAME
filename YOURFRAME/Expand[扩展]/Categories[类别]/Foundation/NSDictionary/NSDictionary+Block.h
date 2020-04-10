
#import <Foundation/Foundation.h>

@interface NSDictionary (Block)
#pragma mark - Manipulation
- (NSDictionary *)dictionaryByAddingEntriesFromDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)dictionaryByRemovingEntriesWithKeys:(NSSet *)keys;

#pragma mark - RX
- (void)enumerateKeysAndObjects:(void (^)(id k, id v))block;
- (void)enumerateKey:(void (^)(id k))block;
- (void)enumerateValue:(void (^)(id v))block;
- (BOOL)hasKey:(id)key;
- (NSDictionary *)pick:(NSArray *)keys;
- (NSDictionary *)omit:(NSArray *)key;

@end
