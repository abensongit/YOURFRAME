
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFCNetworkingCacheUtil : NSObject

/**
 *  缓存网络数据
 *
 *  @param responseCache 服务器返回的数据
 *  @param key           缓存数据对应的key值，推荐填入请求的URL
 */
+ (void)saveResponseCache:(id)responseCache forKey:(NSString *)key;


/**
 *  取出缓存的数据
 *
 *  @param key 根据存入时候填入的key值来取出对应的数据
 *
 *  @return 缓存的数据
 */
+ (id)getResponseCacheForKey:(NSString *)key;


/**
 *  清空缓存数据
 *
 *  @param key 根据存入时候填入的key值来删除对应的数据
 */
+ (void)removeObjectForKey:(NSString *)key;


/**
 *  清空所有缓存数据
 */
+ (void)removeAllObjects;


/**
 *  缓存数据大小
 */
+ (CGFloat)totalObjectsSizeCost;


@end

NS_ASSUME_NONNULL_END
