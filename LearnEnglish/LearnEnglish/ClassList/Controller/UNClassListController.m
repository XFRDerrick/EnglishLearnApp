//
//  UNClassListController.m
//  LearnEnglish
//
//  Created by universe on 2017/1/3.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNClassListController.h"

@interface UNClassListController ()

@property (nonatomic, strong) NSMutableArray *classes;

@end

@implementation UNClassListController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupClassNav];
    self.title = @"班级列表";
    [self addMjRefresh];
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)addMjRefresh{
    [self.view showHUD];
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            BmobQuery *bq = [BmobQuery queryWithClassName:@"Classes"];
                [bq includeKey:@"byUser"];
            [bq findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                [self.tableView.mj_header endRefreshing];
                self.classes = [array mutableCopy];
                 [self.tableView reloadData];
                NSLog(@"Count:%lu",(unsigned long)self.classes.count);
            }];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.view showMessage:@"加载成功"];
            });
        });
    }];
}

- (void)setupClassNav{

    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addClassAction:)];
    self.navigationItem.rightBarButtonItems = @[self.navigationItem.rightBarButtonItem,addItem];
    
}


- (void)addClassAction:(UIBarButtonItem *)sender{

    UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:@"创建班级" message:@"请输入班级名称" preferredStyle:UIAlertControllerStyleAlert];
    
    [alterVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       textField.placeholder = @"班级名称";
        
    }];
    
    UIAlertAction *actionDone = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.view showHUD];
        BmobObject *obj = [BmobObject objectWithClassName:@"Classes"];
        [obj setObject:alterVC.textFields[0].text forKey:@"name"];
        [obj setObject:[BmobUser currentUser] forKey:@"byUser"];
        [obj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                [self.view showMessage:@"创建成功"];
                [self LoadClasses];
            }
        }];
        
    }];
    
    UIAlertAction *alterCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alterVC addAction:alterCancle];
    [alterVC addAction:actionDone];
    [self presentViewController:alterVC animated:YES completion:nil];
}

- (void)LoadClasses{

    BmobQuery *bq = [BmobQuery queryWithClassName:@"Classes"];
    [bq includeKey:@"byUser"];
    [bq findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        self.classes = [array mutableCopy];
        [self.tableView reloadData];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.classes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
    }
    
    BmobObject *obj = self.classes[indexPath.row];
    
    cell.textLabel.text = [obj objectForKey:@"name"];
    BmobUser *user = [obj objectForKey:@"byUser"];
    
    cell.detailTextLabel.text = user.username ;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //删除数据
        BmobObject *obj = self.classes[indexPath.row];
        [obj deleteInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                [self.view showMessage:@"班级解散"];
            }
        }];
        
        [self.classes removeObject:obj];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
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
