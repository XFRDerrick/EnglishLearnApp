//
//  UIColor+RandomColor.m
//  day01_startProcess
//
//  Created by universe on 2016/10/31.
//  Copyright © 2016年 universe. All rights reserved.
//

#import "UIColor+RandomColor.h"

@implementation UIColor (RandomColor)
+ (UIColor *)randomColor:(float)alpha{
    
    double red = arc4random() % 256 * 1.0/ 255;
    double green = arc4random() % 256 * 1.0/ 255;
    double blue = arc4random() % 256 * 1.0/ 255;
    
    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return randomColor;
}
@end
