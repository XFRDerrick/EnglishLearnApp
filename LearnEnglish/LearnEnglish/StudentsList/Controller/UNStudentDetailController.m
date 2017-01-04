//
//  UNStudentDetailController.m
//  LearnEnglish
//
//  Created by universe on 2017/1/3.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNStudentDetailController.h"

#import "UserinfoHeaderCell.h"

@interface UNStudentDetailController ()

@property (nonatomic, strong) NSArray *titles;

@end

@implementation UNStudentDetailController

- (NSArray *)titles{

    if (!_titles) {
        _titles = @[@[@"头像",@"账户名",@"姓名"],@[@"职位",@"金币",@"积分"],@[@"课程"]];
    }
    return _titles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"学员信息";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"UserinfoHeaderCell" bundle:nil] forCellReuseIdentifier:@"userInfoCell"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray *subtitles = self.titles[section];
    return subtitles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *titleArr = self.titles[indexPath.section];
    if (indexPath.section == 0 && indexPath.row == 0) {
        
     UserinfoHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userInfoCell" forIndexPath:indexPath];
//        cell.headerImageIV
        
        if ([self.student objectForKey:@"headPath"]) {
            [cell.headerImageIV setImageWithURL:[NSURL URLWithString:[self.student objectForKey:@"headPath"]] placeholder:[UIImage imageNamed:@"tmpHead"]];
        }else{
            
            [cell.headerImageIV setImage:[UIImage imageNamed:@"tmpHead"]];
        }
        return cell;
        
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
        }
        
        cell.textLabel.text = titleArr[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //根据传值显示
        if (indexPath.section == 0) {
            if (indexPath.row == 1) {
                cell.detailTextLabel.text = self.student.username;
                cell.accessoryType = UITableViewCellAccessoryNone;
            }else if (indexPath.row == 2){
                cell.detailTextLabel.text = [self.student objectForKey:@"nick"];
            }else{
                
            }
        }else if (indexPath.section == 1){
            if (indexPath.row == 0) {
                cell.detailTextLabel.text = @"学员";
                cell.accessoryType = UITableViewCellAccessoryNone;
            }else if (indexPath.row == 1){
                //金币
                cell.detailTextLabel.text = [NSString stringWithFormat:@"金币:%@",[self.student objectForKey:@"gold"]];
            }else{
                cell.detailTextLabel.text = [NSString stringWithFormat:@"积分:%@",[self.student objectForKey:@"integral"]];
            }
        }else if (indexPath.section == 2){
            NSArray *course = [self.student objectForKey:@"classes"];
            NSMutableString *str = [NSMutableString string];
            for (NSString *co in course) {
                NSLog(@"%@",co);
                [str appendFormat:@" %@",co];
            }
            NSLog(@"%@",str);
            cell.detailTextLabel.text = str.copy;
        }

       return cell;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0 && indexPath.row == 0) {
        return 80;
    }else{
        return 45;
    }
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
