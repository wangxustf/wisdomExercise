//
//  Privilege.m
//  wisdomExercise
//
//  Created by wangxu on 15/11/4.
//  Copyright © 2015年 wangxu. All rights reserved.
//

#import "Privilege.h"
#import "NSDate+Addition.h"
#import "NSString+Addition.h"

NSString *kPrivilegeDomain = @"kPrivilegeDomain";
typedef NS_ENUM(NSInteger, ErrorPrivilegeCode) {
    ErrorPrivilegeBaseCode,
    ErrorPrivilegeDateCode,
    ErrorPrivilegeFullCode,
    ErrorPrivilegeReduceCode
};

@implementation Privilege

+ (Privilege *)privilegeWithString:(NSString *)string error:(NSError *__autoreleasing *)error
{
    NSString *kInfo = @"kInfo";
    NSArray *ErrorPrivilegeInfoArray = @[@{kInfo:@"数据格式不对"}, @{kInfo:@"时间数据格式不对"}, @{kInfo:@"满折扣数据格式不对"}, @{kInfo:@"返折扣数据格式不对"}];
    Privilege *privilege = [[Privilege alloc] init];
    NSArray *array = [string componentsSeparatedByString:@" "];
    if ([array count] != 3) {
        *error = [NSError errorWithDomain:kPrivilegeDomain code:ErrorPrivilegeBaseCode userInfo:ErrorPrivilegeInfoArray[ErrorPrivilegeBaseCode]];
        return nil;
    }
    if (![array[0] isPureDate]) {
        *error = [NSError errorWithDomain:kPrivilegeDomain code:ErrorPrivilegeDateCode userInfo:ErrorPrivilegeInfoArray[ErrorPrivilegeDateCode]];
        return nil;
    }
    privilege.date = [NSDate dateFromString:array[0] dateFormattter:@"yyyy.MM.dd"];
    if (![array[1] isPureNum]) {
        *error = [NSError errorWithDomain:kPrivilegeDomain code:ErrorPrivilegeFullCode userInfo:ErrorPrivilegeInfoArray[ErrorPrivilegeFullCode]];
        return nil;
    }
    privilege.full = [array[1] floatValue];
    if (![array[2] isPureNum]) {
        *error = [NSError errorWithDomain:kPrivilegeDomain code:ErrorPrivilegeReduceCode userInfo:ErrorPrivilegeInfoArray[ErrorPrivilegeReduceCode]];
        return nil;
    }
    privilege.reduce = [array[2] floatValue];
    return privilege;
}

@end
