//
//  UIView+HUD.m
//  PublicNews
//
//  Created by universe on 2016/12/3.
//  Copyright © 2016年 universe. All rights reserved.
//

#import "UIView+HUD.h"

@implementation UIView (HUD)

- (void)showHUD{

    [self hidenHUD];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    
    [hud hideAnimated:YES afterDelay:30];

}

- (void)hidenHUD{
    [MBProgressHUD hideHUDForView:self animated:YES];
//    [MBProgressHUD hideAllHUDsForView:self animated:YES];
}

- (void)showMessage:(NSString *)message{

    [self hidenHUD];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    [hud hideAnimated:YES afterDelay:1.0];
//    [hud hide:YES afterDelay:1.0];
    
}


@end
