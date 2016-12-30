//
//  UIView+HUD.h
//  PublicNews
//
//  Created by universe on 2016/12/3.
//  Copyright © 2016年 universe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HUD)

- (void)showHUD;
- (void)hidenHUD;
- (void)showMessage:(NSString *)message;

@end
