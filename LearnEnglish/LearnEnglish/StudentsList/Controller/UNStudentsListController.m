//
//  UNStudentsListController.m
//  LearnEnglish
//
//  Created by universe on 2017/1/3.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNStudentsListController.h"
#import "UNStudentController.h"

@interface UNStudentsListController ()
@property (nonatomic, strong) NSMutableArray *students;
@end

@implementation UNStudentsListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupStudentNav];
    self.title = @"学生列表";
    [self addMjRefresh];
    //    self.view.backgroundColor = [UIColor redColor];
    
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
                self.students = [array mutableCopy];
                [self.tableView reloadData];
                NSLog(@"Count:%lu",(unsigned long)self.students.count);
            }];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.view showMessage:@"加载成功"];
            });
        });
    }];
}

- (void)setupStudentNav{
    
    UIBarButtonItem *newItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addStudentAction:)];
    self.navigationItem.rightBarButtonItem = newItem;
}
- (void)addStudentAction:(UIBarButtonItem *)sender{

    UNStudentController *stuVC = [[UNStudentController alloc] init];
    [self.navigationController pushViewController:stuVC animated:YES];
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
