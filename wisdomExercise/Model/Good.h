//
//  Good.h
//  wisdomExercise
//
//  Created by wangxu on 15/11/4.
//  Copyright © 2015年 wangxu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Good : NSObject

@property (nonatomic, assign) NSInteger nums;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, strong) NSString *name;

+ (Good *)goodWithString:(NSString *)string error:(NSError *__autoreleasing *)error;

@end
