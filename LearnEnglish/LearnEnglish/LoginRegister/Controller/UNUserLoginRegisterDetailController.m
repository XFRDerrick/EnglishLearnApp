//
//  UNUserLoginRegisterDetailController.m
//  LearnEnglish
//
//  Created by universe on 2016/12/30.
//  Copyright © 2016年 universe. All rights reserved.
//

#import "UNUserLoginRegisterDetailController.h"

@interface UNUserLoginRegisterDetailController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@property (nonatomic, assign,getter=isLogin) BOOL login;

@end

@implementation UNUserLoginRegisterDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    [self setupsubViewShow];
    [self setupTextField];
    
}

- (void)setupsubViewShow{
    if ([self.title isEqualToString:@"登录"]) {
        self.login = YES;
    }
    if (self.isLogin) {
        [self.actionButton setTitle:@"登     录" forState:UIControlStateNormal];
    }else{
        
        [self.actionButton setTitle:@"注     册" forState:UIControlStateNormal];
    }
}

- (void)setupTextField{

    self.userNameTextField.returnKeyType = UIReturnKeyDone;
    self.userNameTextField.delegate = self;
    self.passWordTextField.returnKeyType = UIReturnKeyDone;
    self.passWordTextField.delegate = self;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.passWordTextField resignFirstResponder];
    [self.userNameTextField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.passWordTextField resignFirstResponder];
    [self.userNameTextField resignFirstResponder];
}



- (IBAction)buttonAction:(UIButton *)sender {
    
    if (self.userNameTextField.text.length > 0 && self.passWordTextField.text.length >0) {
        if (self.isLogin) {//登录界面
            [self oldUserLogin];
        }else{//注册界面
            [self registerNewUser];
        }
    }else{
        [self.view showMessage:@"请输入用户名和密码"];
    }
    
}

- (void)oldUserLogin{
    [self.view showHUD];
    [BmobUser loginInbackgroundWithAccount:self.userNameTextField.text andPassword:self.passWordTextField.text block:^(BmobUser *user, NSError *error) {
        if (user) {
            //登录成功 返回
            [self.view showMessage:@"登录成功"];
            [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
                [self.navigationController popViewControllerAnimated:YES];
            } repeats:NO];
            
        } else {
            NSLog(@"%@",error);
            [self.view showMessage:@"登录失败"];
        }
    }];
    
}

- (void)registerNewUser{

    BmobUser *bUser = [[BmobUser alloc] init];
    [bUser setUsername:self.userNameTextField.text];
    [bUser setPassword:self.passWordTextField.text];
    [self.view showHUD];
    [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
        if (isSuccessful){
            [self.view showMessage:@"注册成功,请登录"];
            [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
                [self.navigationController popViewControllerAnimated:YES];
            } repeats:NO];
            
        } else {
            NSLog(@"%@",error);
            [self.view showMessage:@"注册失败，请重新注册"];
        }
        
    }];
    
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
