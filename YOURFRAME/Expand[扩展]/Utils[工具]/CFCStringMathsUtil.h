//
//  https://www.cnblogs.com/Kurodo/p/3456642.html
//  NSString *result = [CFCStringMathsUtil calcComplexFormulaString:@"(3+2*2+(1+2))*2-1*5+(5/10-10)"];
//
//  Created by MASON on 2018/3/24.
//  Copyright © 2018年 ZHONGLE. All rights reserved.
//
//  简单数据计算工具
//


#import <Foundation/Foundation.h>


@interface CFCStringMathsUtil : NSObject


#pragma mark -
#pragma mark 字符串 - 加法
+ (NSString *)addNumber1:(NSString *)number1 number2:(NSString *)number2;
#pragma mark 字符串 - 减法
+ (NSString *)subNumber1:(NSString *)number1 number2:(NSString *)number2;
#pragma mark 字符串 - 乘法
+ (NSString *)mulNumber1:(NSString *)number1 number2:(NSString *)number2;
#pragma mark 字符串 - 除法
+ (NSString *)divNumber1:(NSString *)number1 number2:(NSString *)number2;


#pragma mark -
#pragma mark 字符串 - 复杂计算公式计算 - 如：@"(3+2*2+(1+2))*2-1*5+(5/10-10)"
+ (NSString *)calcComplexFormulaString:(NSString *)formula;


#pragma mark -
#pragma mark 获取最大值
+ (NSString *)getMaxValueArray:(NSArray<NSString *> *)array;
#pragma mark 获取最小值
+ (NSString *)getMinValueArray:(NSArray<NSString *> *)array;
#pragma mark 对数组进行排序
+ (NSArray<NSString *> *)sortedArray:(NSArray<NSString *> *)array;


#pragma mark -
#pragma mark 验证字符串是否为数字
+ (BOOL)validateNumberCharacters:(NSString *)value;
#pragma mark 验证字符串是否为整形数字
+ (BOOL)validatePureInt:(NSString *)string;
#pragma mark 验证字符串是否为浮点数字
+ (BOOL)validatePureFloat:(NSString *)string;


@end


