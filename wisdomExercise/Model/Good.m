//
//  Good.m
//  wisdomExercise
//
//  Created by wangxu on 15/11/4.
//  Copyright © 2015年 wangxu. All rights reserved.
//

#import "Good.h"
#import "NSDate+Addition.h"
#import "NSString+Addition.h"

NSString *kGoodDomain = @"kGoodDomain";
typedef NS_ENUM(NSInteger, ErrorGoodCode) {
    ErrorGoodBaseCode,
    ErrorGoodNumCode,
    ErrorGoodRateCode
};

@implementation Good

+ (Good *)goodWithString:(NSString *)string error:(NSError *__autoreleasing *)error
{
    NSString *kInfo = @"kInfo";
    NSArray *ErrorGoodInfoArray = @[@{kInfo:@"数据格式不对"}, @{kInfo:@"数量数据格式不对"}, @{kInfo:@"价格数据格式不对"}];
    Good *good = [[Good alloc] init];
    NSArray *array = [string componentsSeparatedByString:@"*"];
    if ([array count] != 2) {
        *error = [NSError errorWithDomain:kGoodDomain code:ErrorGoodBaseCode userInfo:ErrorGoodInfoArray[ErrorGoodBaseCode]];
        return nil;
    }
    if (![array[0] isPureInt]) {
        *error = [NSError errorWithDomain:kGoodDomain code:ErrorGoodNumCode userInfo:ErrorGoodInfoArray[ErrorGoodNumCode]];
        return nil;
    }
    good.nums = [array[0] intValue];
    NSArray *array1 = [array[1] componentsSeparatedByString:@":"];
    if ([array1 count] != 2) {
        *error = [NSError errorWithDomain:kGoodDomain code:ErrorGoodBaseCode userInfo:ErrorGoodInfoArray[ErrorGoodBaseCode]];
        return nil;
    }
    good.name = [array1[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![array1[1] isPureNum]) {
        *error = [NSError errorWithDomain:kGoodDomain code:ErrorGoodRateCode userInfo:ErrorGoodInfoArray[ErrorGoodRateCode]];
        return nil;
    }
    good.price = [array1[1] floatValue];
    return good;
}

@end
