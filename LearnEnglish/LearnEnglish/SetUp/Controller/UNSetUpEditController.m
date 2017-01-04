//
//  UNSetUpEditController.m
//  LearnEnglish
//
//  Created by universe on 2017/1/4.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNSetUpEditController.h"

@interface UNSetUpEditController ()
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@property (weak, nonatomic) IBOutlet UITextField *oldpassword;

@end

@implementation UNSetUpEditController
- (IBAction)saveCode:(UIButton *)sender {
    
    BmobUser *user = [BmobUser currentUser];
    [user updateCurrentUserPasswordWithOldPassword:self.oldpassword.text newPassword:self.codeTextField.text block:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            //用新密码登录incorrect
            [BmobUser loginInbackgroundWithAccount:user.username andPassword:self.codeTextField.text block:^(BmobUser *user, NSError *error) {
                if (error) {
                    [self.view showMessage:@"新密码登录失败，请重新登录"];
                } else {
                    [self.view showMessage:@"新密码登录成功"];
                }
            }];
        } else {
//            NSLog(@"change password error:%@",error);
            [self.view showMessage:@"密码修改失败"];
        }
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
