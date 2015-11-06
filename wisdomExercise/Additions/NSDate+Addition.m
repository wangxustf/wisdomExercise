//
//  NSDate+YGNSDate.m
//  DailyYoga
//
//  Created by zhen on 14-9-15.
//  Copyright (c) 2014年 zhen. All rights reserved.
//

#import "NSDate+Addition.h"

@implementation NSDate (Addition)

+ (NSDate *)dateFromString:(NSString *)dateString dateFormattter:(NSString *)dateFormattter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormattter];
    NSDate *date= [dateFormatter dateFromString:dateString];
    return date;
}

@end
