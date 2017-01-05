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

//做textView的表情匹配
+ (void)emojiMappingWithText:(YYTextView *)textView{

    YYTextSimpleEmoticonParser *parser = [[YYTextSimpleEmoticonParser alloc] init];
    NSMutableDictionary *mapperDict = [NSMutableDictionary dictionary];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"default" ofType:@"plist"];
    NSArray *emojiArr = [NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *emojDic in emojiArr) {
        NSString *imageName = emojDic[@"png"];
        NSString *text = emojDic[@"chs"];
        [mapperDict setObject:[UIImage imageNamed:imageName] forKey:text];
    }
    parser.emoticonMapper = mapperDict;
    textView.textParser = parser;
}


@end
