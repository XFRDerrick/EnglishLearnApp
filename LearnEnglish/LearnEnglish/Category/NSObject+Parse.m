//
//  NSObject+Parse.m
//  PublicNews
//
//  Created by universe on 2016/12/2.
//  Copyright © 2016年 universe. All rights reserved.
//

#import "NSObject+Parse.h"

@implementation NSObject (Parse)

+ (id)parse:(id)JSON{
 
    if ([JSON isKindOfClass:[NSDictionary class]]) {
        return  [self modelWithJSON:JSON];
    }
    if ([JSON isKindOfClass:[NSArray class]]) {
        return [NSArray modelArrayWithClass:[self class] json:JSON];
    }
    return JSON;
    
}

@end
