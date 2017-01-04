//
//  WorkTools.m
//  LearnEnglish
//
//  Created by universe on 2017/1/3.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "WorkTools.h"

@implementation WorkTools

+ (void)loginTeacherAccount{

    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    
    //登录回教室账号
    [BmobUser loginWithUsernameInBackground:username password:password block:^(BmobUser *user, NSError *error) {
        if (user) {
            NSLog(@"登录回教室账号");
        }
    }];
    
}

@end
