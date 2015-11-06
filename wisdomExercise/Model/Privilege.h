//
//  Privilege.h
//  wisdomExercise
//
//  Created by wangxu on 15/11/4.
//  Copyright © 2015年 wangxu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Privilege : NSObject

@property (nonatomic, assign) CGFloat full;
@property (nonatomic, assign) CGFloat reduce;
@property (nonatomic, strong) NSDate *date;

+ (Privilege *)privilegeWithString:(NSString *)string error:(NSError *__autoreleasing *)error;

@end
