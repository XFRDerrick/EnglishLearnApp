//
//  UNSetUpController.m
//  LearnEnglish
//
//  Created by universe on 2016/12/30.
//  Copyright © 2016年 universe. All rights reserved.
//

#import "UNSetUpController.h"
#import "UNSetUpEditController.h"
#import "UNUserLoginRegisterController.h"
@interface UNSetUpController ()

@property (nonatomic, strong) NSArray *titles;

@end

@implementation UNSetUpController

- (NSArray *)titles{

    if (!_titles) {
        _titles = @[@[@"清除缓存"],
                    @[@"修改密码",@"修改名字和头像",@"切换账户"]];
    }
    return _titles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}
- (void)setupUI{
    self.title = @"设置";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *titleArr= self.titles[section];
    return titleArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"setCell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.titles[indexPath.section][indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 54;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 1 && indexPath.row == 0) {
        UNSetUpEditController *edit = [[UNSetUpEditController alloc] initWithNibName:@"UNSetUpEditController" bundle:nil];
        
        [self.navigationController pushViewController:edit animated:YES];
    }
    if (indexPath.row == 2) {
        
        [self cancleLoginAlterAction];
    }
}

- (void)cancleLoginAlterAction{
    
    UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:@"注销" message:@"确认切换账户" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionDone = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [BmobUser logout];
        //显示登录界面
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        UNUserLoginRegisterController *lrVC = [[UNUserLoginRegisterController alloc] init];
        lrVC.enterHidden = NO;
        window.rootViewController = [[UINavigationController alloc] initWithRootViewController:lrVC];
        [window makeKeyAndVisible];
        
        
    }];
    UIAlertAction *actionCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alterVC addAction:actionCancle];
    [alterVC addAction:actionDone];
    [self presentViewController:alterVC animated:YES completion:nil];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
