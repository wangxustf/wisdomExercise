//
//  Promotion.m
//  wisdomExercise
//
//  Created by wangxu on 15/11/4.
//  Copyright © 2015年 wangxu. All rights reserved.
//

#import "Promotion.h"
#import "NSDate+Addition.h"
#import "NSString+Addition.h"

NSString *kPromotionDomain = @"kPromotionDomain";
typedef NS_ENUM(NSInteger, ErrorPromotionCode) {
    ErrorPromotionBaseCode,
    ErrorPromotionDateCode,
    ErrorPromotionRateCode
};

@implementation Promotion

+ (Promotion *)promotionWithString:(NSString *)string error:(NSError *__autoreleasing *)error
{
    NSString *kInfo = @"kInfo";
    NSArray *ErrorPromotionInfoArray = @[@{kInfo:@"数据格式不对"}, @{kInfo:@"时间数据格式不对"}, @{kInfo:@"折率数据格式不对"}];
    Promotion *promotion = [[Promotion alloc] init];
    NSArray *array = [string componentsSeparatedByString:@"|"];
    if ([array count] != 3) {
        *error = [NSError errorWithDomain:kPromotionDomain code:ErrorPromotionBaseCode userInfo:ErrorPromotionInfoArray[ErrorPromotionBaseCode]];
        return nil;
    }
    if (![array[0] isPureDate]) {
        *error = [NSError errorWithDomain:kPromotionDomain code:ErrorPromotionDateCode userInfo:ErrorPromotionInfoArray[ErrorPromotionDateCode]];
        return nil;
    }
    promotion.date = [NSDate dateFromString:array[0] dateFormattter:@"yyyy.MM.dd"];
    if (![array[1] isPureNum]) {
        *error = [NSError errorWithDomain:kPromotionDomain code:ErrorPromotionRateCode userInfo:ErrorPromotionInfoArray[ErrorPromotionRateCode]];
        return nil;
    }
    promotion.rate = [array[1] floatValue];
    promotion.category = [array[2] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return promotion;
}

@end
