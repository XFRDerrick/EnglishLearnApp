//
//  TextCheckingTools.m
//  LearnEnglish
//
//  Created by universe on 2017/1/3.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "TextCheckingTools.h"

@implementation TextCheckingTools

+ (BOOL)checkingTextField:(UITextField *)textField{
    
    NSString *inStr = textField.text;
    //去掉文本两端空格和换行符
    inStr = [inStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (inStr.length == 0) {
        return NO;
    }
    return YES;
}


@end

