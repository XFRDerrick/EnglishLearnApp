//
//  UNCreateMessageController.m
//  LearnEnglish
//
//  Created by universe on 2017/1/4.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNCreateMessageController.h"

@interface UNCreateMessageController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyBoardHeaderConstraint;

@end

@implementation UNCreateMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupUI];
    
}
- (void)setupUI{

    self.title = @"新建消息";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(sendAction)];
    
}

- (void)backAction{

    UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定返回首页吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionFriends = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    UIAlertAction *actionCancle = [UIAlertAction actionWithTitle:@"点错了" style:UIAlertActionStyleCancel handler:nil];
    [alterVC addAction:actionCancle];
    [alterVC addAction:actionFriends];
    [self presentViewController:alterVC animated:YES completion:nil];
    
    
    
}

- (void)sendAction{

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
