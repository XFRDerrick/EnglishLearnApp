//
//  UNUserLoginRegisterController.m
//  LearnEnglish
//
//  Created by universe on 2016/12/30.
//  Copyright © 2016年 universe. All rights reserved.
//

#import "UNUserLoginRegisterController.h"
#import "UNUserLoginRegisterDetailController.h"
@interface UNUserLoginRegisterController ()
@property (weak, nonatomic) IBOutlet UIButton *cancleButton;
@property (weak, nonatomic) IBOutlet UIButton *enterButton;

@end

@implementation UNUserLoginRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.enterButton.hidden = self.enterHidden;
    self.cancleButton.hidden = !self.enterButton.hidden;
    
}
- (IBAction)enterButtonAction:(UIButton *)sender {
    //修改window。root
    AppDelegate *appdel = [[AppDelegate alloc] init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [appdel setWindowRootVCWithMain];
    [window makeKeyAndVisible];
    
    
    
}
- (IBAction)cancleAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)loginRegisterAction:(UIButton *)sender {
    
    UNUserLoginRegisterDetailController *detailVC = [[UNUserLoginRegisterDetailController alloc] initWithNibName:@"UNUserLoginRegisterDetailController" bundle:nil];
    
    if (sender.tag == 0) {
        //登录
        detailVC.title = @"登录";
    }
    if (sender.tag == 1) {
        //注册
        detailVC.title = @"注册";
    }
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden = YES;
   
    if (self.enterHidden) {
        //判断是否登录
        BmobUser *bUser = [BmobUser currentUser];
        if (bUser) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            //对象为空时，可打开用户注册界面
        }
    }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
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
