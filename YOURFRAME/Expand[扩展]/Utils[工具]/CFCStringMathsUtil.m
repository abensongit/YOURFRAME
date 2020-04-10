//
//  Created by MASON on 2018/3/24.
//  Copyright © 2018年 ZHONGLE. All rights reserved.
//
//  简单数据计算工具
//


#import "CFCStringMathsUtil.h"


@implementation CFCStringMathsUtil


#pragma mark -
#pragma mark 字符串 - 加法
+ (NSString *)addNumber1:(NSString *)number1 number2:(NSString *)number2
{
    CGFloat result = [number1 doubleValue] + [number2 doubleValue];
    return [NSString stringWithFormat:@"%f", result];
}

#pragma mark 字符串 - 减法
+ (NSString *)subNumber1:(NSString *)number1 number2:(NSString *)number2
{
    CGFloat result = [number1 doubleValue] - [number2 doubleValue];
    return [NSString stringWithFormat:@"%f", result];
}

#pragma mark 字符串 - 乘法
+ (NSString *)mulNumber1:(NSString *)number1 number2:(NSString *)number2
{
    CGFloat result = [number1 doubleValue] * [number2 doubleValue];
    return [NSString stringWithFormat:@"%f", result];
}

#pragma mark 字符串 - 除法
+ (NSString *)divNumber1:(NSString *)number1 number2:(NSString *)number2
{
    CGFloat result = [number1 doubleValue] / [number2 doubleValue];
    return [NSString stringWithFormat:@"%f", result];
}

#pragma mark 字符串 - 简单 + - 的计算
+ (NSString *)calcSimpleFormula:(NSString *)formula
{
    NSString *result = @"0";
    char symbol = '+';
    
    NSInteger len = formula.length;
    int numStartPoint = 0;
    for (int i = 0; i < len; i++) {
        char c = [formula characterAtIndex:i];
        if (c == '+' || c == '-') {
            NSString *num = [formula substringWithRange:NSMakeRange(numStartPoint, i - numStartPoint)];
            switch (symbol) {
                case '+':
                    result = [self addNumber1:result number2:num];
                    break;
                case '-':
                    result = [self subNumber1:result number2:num];
                    break;
                default:
                    break;
            }
            symbol = c;
            numStartPoint = i + 1;
        }
    }
    if (numStartPoint < len) {
        NSString *num = [formula substringWithRange:NSMakeRange(numStartPoint, len - numStartPoint)];
        switch (symbol) {
            case '+':
                result = [self addNumber1:result number2:num];
                break;
            case '-':
                result = [self subNumber1:result number2:num];
                break;
            default:
                break;
        }
    }
    return result;
}

#pragma mark 字符串 - 获取字符串中的后置数字
+ (NSString *)lastNumberWithString:(NSString *)str
{
    NSInteger numStartPoint = 0;
    for (NSInteger i = str.length - 1; i >= 0; i--) {
        char c = [str characterAtIndex:i];
        if ((c < '0' || c > '9') && c != '.') {
            numStartPoint = i + 1;
            break;
        }
    }
    return [str substringFromIndex:numStartPoint];
}

#pragma mark 字符串 - 获取字符串中的前置数字
+ (NSString *)firstNumberWithString:(NSString *)str
{
    NSInteger numEndPoint = str.length;
    for (int i = 0; i < str.length; i++) {
        char c = [str characterAtIndex:i];
        if ((c < '0' || c > '9') && c != '.') {
            numEndPoint = i;
            break;
        }
    }
    return [str substringToIndex:numEndPoint];
}

#pragma mark 字符串 - 包含 * / 的计算
+ (NSString *)calcNormalFormula:(NSString *)formula
{
    NSRange mulRange = [formula rangeOfString:@"*" options:NSLiteralSearch];
    NSRange divRange = [formula rangeOfString:@"/" options:NSLiteralSearch];
    // 只包含加减的运算
    if (mulRange.length == 0 && divRange.length == 0) {
        return [self calcSimpleFormula:formula];
    }
    // 进行乘除运算
    NSInteger index = mulRange.length > 0 ? mulRange.location : divRange.location;
    // 计算左边表达式
    NSString *left = [formula substringWithRange:NSMakeRange(0, index)];
    NSString *num1 = [self lastNumberWithString:left];
    left = [left substringWithRange:NSMakeRange(0, left.length - num1.length)];
    // 计算右边表达式
    NSString *right = [formula substringFromIndex:index + 1];
    NSString *num2 = [self firstNumberWithString:right];
    right = [right substringFromIndex:num2.length];
    // 计算一次乘除结果
    NSString *tempResult = @"0";
    if (index == mulRange.location) {
        tempResult = [self mulNumber1:num1 number2:num2];
    } else {
        tempResult = [self divNumber1:num1 number2:num2];
    }
    // 代入计算得到新的公式
    NSString *newFormula = [NSString stringWithFormat:@"%@%@%@", left, tempResult, right];
    return [self calcNormalFormula:newFormula];
}


#pragma mark 字符串 - 复杂计算公式计算，接口主方法
+ (NSString *)calcComplexFormulaString:(NSString *)formula
{
    // 左括号
    NSRange lRange = [formula rangeOfString:@"(" options:NSBackwardsSearch];
    // 没有括号进行二步运算(含有乘除加减)
    if (lRange.length == 0) {
        return [self calcNormalFormula:formula];
    }
    // 右括号
    NSRange rRange = [formula rangeOfString:@")" options:NSLiteralSearch range:NSMakeRange(lRange.location, formula.length-lRange.location)];
    // 获取括号左右边的表达式
    NSString *left = [formula substringWithRange:NSMakeRange(0, lRange.location)];
    NSString *right = [formula substringFromIndex:rRange.location + 1];
    // 括号内的表达式
    NSString *middle = [formula substringWithRange:NSMakeRange(lRange.location+1, rRange.location-lRange.location-1)];
    // 代入计算新的公式
    NSString *newFormula = [NSString stringWithFormat:@"%@%@%@", left, [self calcNormalFormula:middle], right];
    return [self calcComplexFormulaString:newFormula];
}


#pragma mark -
#pragma mark 对数组进行排序
+ (NSArray<NSString *> *)sortedArray:(NSArray<NSString *> *)array
{
    return [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return NSOrderedDescending;
        } else if ([obj1 integerValue] < [obj2 integerValue]) {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
}

#pragma mark 获取最大值
+ (NSString *)getMaxValueArray:(NSArray<NSString *> *)array
{
    NSArray<NSString *> *sorted_array = [[self class] sortedArray:array];
    return sorted_array.lastObject;
}

#pragma mark 获取最小值
+ (NSString *)getMinValueArray:(NSArray<NSString *> *)array
{
    NSArray<NSString *> *sorted_array = [[self class] sortedArray:array];
    return sorted_array.firstObject;
}


#pragma mark -
#pragma mark 验证字符串是否为数字
+ (BOOL)validateNumberCharacters:(NSString *)value
{
    return [CFCStringMathsUtil validatePureInt:value] || [CFCStringMathsUtil validatePureFloat:value];
}

#pragma mark 验证字符串是否为整形数字
+ (BOOL)validatePureInt:(NSString *)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

#pragma mark 验证字符串是否为浮点数字
+ (BOOL)validatePureFloat:(NSString *)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}


@end



