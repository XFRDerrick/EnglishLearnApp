//
//  UNMessageController.m
//  LearnEnglish
//
//  Created by universe on 2017/1/4.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNMessageController.h"
#import "UNCreateMessageController.h"
@interface UNMessageController ()

@end

@implementation UNMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMessageNav];

    
}

- (void)setupMessageNav{

    self.title = @"消息列表";
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(messageAddAction)];
    self.navigationItem.rightBarButtonItems = @[self.navigationItem.rightBarButtonItem,addItem];
    
}
- (void)messageAddAction{

    [self messageAlterAction];
}


- (void)messageAlterAction{
    
    
    if (KIsTeacher) {
        UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:@"消息" message:@"选择操作" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *actionFriends = [UIAlertAction actionWithTitle:@"发盆友圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self presentToCreatMessageVC];
            
        }];
        UIAlertAction *actionWorks = [UIAlertAction actionWithTitle:@"发布作业" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        
        UIAlertAction *actionCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alterVC addAction:actionCancle];
        [alterVC addAction:actionFriends];
        [alterVC addAction:actionWorks];
        [self presentViewController:alterVC animated:YES completion:nil];
    }else{//学生登录
        [self presentToCreatMessageVC];
        
    }
    
    
    
    
}
#pragma mark -
#pragma mark 推出到新建message的控制器
- (void)presentToCreatMessageVC{

    UNCreateMessageController *creatmVC = [[UNCreateMessageController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:creatmVC];
    
    [self presentViewController:nav animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
