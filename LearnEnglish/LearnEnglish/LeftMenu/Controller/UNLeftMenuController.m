//
//  UNLeftMenuController.m
//  LearnEnglish
//
//  Created by universe on 2016/12/30.
//  Copyright © 2016年 universe. All rights reserved.
//

#import "UNLeftMenuController.h"
#import "UNMainTableViewController.h"
#import "UNSetUpController.h"

#import "UNUserLeftHeaderCell.h"
#import "UNUserLoginRegisterController.h"

//user
#import "UNUserInfoController.h"
#import "UNClassListController.h"
#import "UNStudentsListController.h"


@interface UNLeftMenuController ()
@property (strong, readwrite, nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *images;

//可以判断是否登录了
@property (nonatomic, strong) BmobUser *userinfo;
@end

@implementation UNLeftMenuController

- (NSArray *)images{

    if (!_images) {
        _images = @[@"home", @"message", @"friends", @"setup", @"studens",@"classes"];
    }
    return _images;
}
- (NSArray *)titles{

    if (!_titles) {
        _titles = @[@"首页", @"消息", @"好友列表", @"设置", @"班级列表",@"学生列表"];
    }
    return _titles;
}

#pragma mark 获取新的用户信息

- (UITableView *)tableView{

    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 54 * 5 ) / 2.0f - 60, self.view.frame.size.width, 54 * 6 + 60) style:UITableViewStylePlain];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.opaque = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.backgroundView = nil;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.bounces = NO;
        
        [_tableView registerNib:[UINib nibWithNibName:@"UNUserLeftHeaderCell" bundle:nil] forCellReuseIdentifier:@"UNUserLeftHeaderCell"];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    
    UIBlurEffect *eff = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *ve = [[UIVisualEffectView alloc] initWithEffect:eff];
    ve.frame = self.view.bounds;
    [self.view addSubview:ve];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.userinfo = [BmobUser currentUser];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    });
    //    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
}

- (void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBar.hidden = YES;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.userinfo = [BmobUser currentUser];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
 
}
- (void)viewWillDisappear:(BOOL)animated{

    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        return 60;
    }
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    BOOL  isTeacher = [[[BmobUser currentUser] objectForKey:@"teacher"] boolValue];

    if (isTeacher) {
        return self.titles.count + 1;
    }else{
    
        return self.titles.count - 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

     //点击登录
    if (indexPath.row == 0) {
        
        UNUserLeftHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UNUserLeftHeaderCell" forIndexPath:indexPath];
        
        cell.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
        
        if (self.userinfo) {
            [cell.headerImage setImageWithURL:[self.userinfo objectForKey:@"headPath"] placeholder:[UIImage imageNamed:@"icon"]];
            //账户或者昵称
            cell.nickNameLable.text =[self.userinfo objectForKey:@"nick"] != nil ? [self.userinfo objectForKey:@"nick"]:self.userinfo.username;
        }else{
            
            cell.headerImage.image = [UIImage imageNamed:@"icon"];
            cell.nickNameLable.text = @"点击登录";
        }
        
        return cell;
        
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"leftCell"];
            cell.backgroundColor = [UIColor clearColor];
            cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
            cell.selectedBackgroundView = [[UIView alloc] init];
            
        }
        cell.textLabel.text = self.titles[indexPath.row - 1];
        cell.imageView.image = [UIImage imageNamed:self.images[indexPath.row - 1]];
        return cell;
    }
    
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    //点击登录
    if (indexPath.row == 0) {
        //判断是否登录
        if (self.userinfo) {
            UNUserInfoController *infoVC = [[UNUserInfoController alloc] initWithStyle:UITableViewStylePlain];
            
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:infoVC] animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            
        }else{
            
            UNUserLoginRegisterController *lrVC = [[UNUserLoginRegisterController alloc] initWithNibName:@"UNUserLoginRegisterController" bundle:nil];
            lrVC.enterHidden = YES;
            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:lrVC] animated:YES completion:nil];
        }
       
    }
    
    if (indexPath.row == 1) {
        
        UNMainTableViewController *homeVC = [[UNMainTableViewController alloc] initWithStyle:UITableViewStylePlain];
        
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:homeVC] animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    }
    
     //设置
    if (indexPath.row == 4) {
        UNSetUpController *setVC = [[UNSetUpController alloc] initWithStyle:UITableViewStyleGrouped];
        
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:setVC] animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    }
    if (indexPath.row == 5) {
        //UNClassListController.h
        UNClassListController *classList = [[UNClassListController alloc] initWithStyle:UITableViewStylePlain];
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:classList] animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    }
    if (indexPath.row == 6) {
        
        UNStudentsListController *studentList =[[UNStudentsListController alloc] initWithStyle:UITableViewStylePlain];
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:studentList] animated:YES];
        [self.sideMenuViewController hideMenuViewController];
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
