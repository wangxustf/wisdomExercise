//
//  Promotion.h
//  wisdomExercise
//
//  Created by wangxu on 15/11/4.
//  Copyright © 2015年 wangxu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Promotion : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) CGFloat rate;
@property (nonatomic, strong) NSString *category;

+ (Promotion *)promotionWithString:(NSString *)string error:(NSError *__autoreleasing *)error;

@end
