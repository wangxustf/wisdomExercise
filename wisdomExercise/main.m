//
//  main.m
//  wisdomExercise
//
//  Created by wangxu on 15/11/4.
//  Copyright © 2015年 wangxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+Addition.h"
#import "NSString+Addition.h"
#import "Promotion.h"
#import "Good.h"
#import "Privilege.h"
/*
2013.11.11 | 0.7 | 电子

1 * ipad : 2399.00
1 * 显示器 : 1799.00
12 * 啤酒 : 25.00
5 * 面包 : 9.00

2013.11.11
2014.3.2 1000 200
*/
//3683.60
/*
3 * 蔬菜 : 5.98
8 * 餐巾纸 : 3.20

2014.01.01
*/
//43.54

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        if (argc != 2) {
            NSLog(@"%s输入参数有误\n输入格式应为:%s 输入文件名", argv[0], argv[0]);
            return -1;
        }
        NSString *fileName = [[NSString alloc] initWithCString:argv[1] encoding:NSASCIIStringEncoding];
        NSFileHandle *inFile = [NSFileHandle fileHandleForReadingAtPath:fileName];
        if (!inFile) {
            NSLog(@"输入数据所在文件打开错误");
            return -1;
        }
        
        NSArray *promotionArray = nil;
        NSArray *goodsArray = nil;
        Privilege *privilege = nil;
        NSDate *closeDate = nil;
        
        NSDictionary *infoDictionary = @{@"电子":@[@"ipad", @"iphone", @"显示器", @"笔记本电脑", @"键盘"],
                                         @"食品":@[@"面包", @"饼干", @"蛋糕", @"牛肉", @"鱼", @"蔬菜"],
                                         @"日用品":@[@"餐巾纸", @"收纳箱", @"咖啡杯", @"雨伞"],
                                         @"酒类":@[@"啤酒", @"白酒", @"伏特加"]};
        
        NSString *txtContent = [[NSString alloc] initWithData:[inFile readDataToEndOfFile] encoding:NSUTF8StringEncoding];
        [inFile closeFile];
        NSArray *infoArray = [txtContent componentsSeparatedByString:@"\n\n"];
        NSString *promotionString = nil;
        NSString *goodsString = nil;
        NSString *dateString = nil;
        BOOL hasPrivilege = NO;
        BOOL hasPromotion = NO;
        if ([infoArray count] == 3) {
            hasPromotion = YES;
            promotionString = infoArray[0];
            goodsString = infoArray[1];
            dateString = infoArray[2];
        } else if ([infoArray count] == 2) {
            goodsString = infoArray[0];
            dateString = infoArray[1];
        } else {
            NSLog(@"数据输入格式不对");
            return -1;
        }
        
        if (hasPromotion) {
            NSMutableArray *array = [NSMutableArray array];
            NSArray *pArray = [promotionString componentsSeparatedByString:@"\n"];
            for (NSString *pString in pArray) {
                NSError *error = nil;
                Promotion *promotion = [Promotion promotionWithString:pString error:&error];
                if (error) {
                    NSLog(@"%@", error);
                    return -1;
                }
                [array addObject:promotion];
                
            }
            promotionArray = array;
        }
        
        {
            NSMutableArray *array = [NSMutableArray array];
            NSArray *pArray = [goodsString componentsSeparatedByString:@"\n"];
            for (NSString *pString in pArray) {
                NSError *error = nil;
                Good *good = [Good goodWithString:pString error:&error];
                if (error) {
                    NSLog(@"%@", error);
                    return -1;
                }
                [array addObject:good];
            }
            goodsArray = array;
        }
        
        {
            NSArray *pArray = [dateString componentsSeparatedByString:@"\n"];
            if ([pArray count] <= 0) {
                NSLog(@"结算日期没有");
                return -1;
            }
            if (![pArray[0] isPureDate]) {
                NSLog(@"结算日期格式不对");
                return -1;
            }
            closeDate = [NSDate dateFromString:pArray[0] dateFormattter:@"yyyy.MM.dd"];
            if (pArray.count > 1) {
                NSError *error = nil;
                privilege = [Privilege privilegeWithString:pArray[1] error:&error];
                if (error) {
                    NSLog(@"%@", error);
                    return -1;
                }
                hasPrivilege = YES;
            }
        }
        
        CGFloat totalPrice = 0;
        for (Good *good in goodsArray) {
            CGFloat price = good.nums * good.price;
            if (hasPromotion) {
                for (Promotion *promotion in promotionArray) {
                    if ([infoDictionary[promotion.category] containsObject:good.name] && [closeDate isEqualToDate:promotion.date]) {
                        price *= promotion.rate;
                        break;
                    }
                }
            }
            totalPrice += price;
        }
        
        if ([closeDate compare:privilege.date] == NSOrderedAscending) {
            if (totalPrice >= privilege.full) {
                totalPrice -= privilege.reduce;
            }
        }
        
        NSLog(@"%.2f", totalPrice);
    }
    return 0;
}
