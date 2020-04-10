//
//  NSString+Random.h
//  CpNative
//
//  Created by david on 2019/3/26.
//  Copyright © 2019年 david. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Random)

- (NSString *)randomString;

- (NSString *)randomStringWithLetters:(NSString *)letters;

@end

NS_ASSUME_NONNULL_END
