//
//  NSString+Addition.m
//  wisdomExercise
//
//  Created by wangxu on 15/11/5.
//  Copyright © 2015年 wangxu. All rights reserved.
//

#import "NSString+Addition.h"

@implementation NSString (Additon)

//判断是否为整形
- (BOOL)isPureInt
{
    NSScanner *scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点型
- (BOOL)isPureFloat
{
    NSScanner *scan = [NSScanner scannerWithString:self];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

- (BOOL)isPureNum
{
    NSString *string = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([string isPureFloat] || [string isPureInt]) {
        return YES;
    } else {
        return NO;
    }
}

//判断是否为yyyy.MM.dd时间格式
- (BOOL)isPureDate
{
    NSString *dateString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSArray *array = [dateString componentsSeparatedByString:@"."];
    if ([array count] != 3) {
        return NO;
    }
    if (![array[0] isPureInt] || ![array[1] isPureInt] || ![array[2] isPureInt]) {
        return NO;
    }
    if (((NSString *)array[0]).length != 4) {
        return NO;
    }
    if ((((NSString *)array[1]).length != 2) && (((NSString *)array[1]).length != 1)) {
        return NO;
    }
    if ((((NSString *)array[2]).length != 2) && (((NSString *)array[2]).length != 1)) {
        return NO;
    }
    return YES;
}

@end
