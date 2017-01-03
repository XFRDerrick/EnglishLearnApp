//
//  UNStudentController.m
//  LearnEnglish
//
//  Created by universe on 2017/1/3.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNStudentController.h"

@interface UNStudentController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userRealNameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *integralTextField;
@property (weak, nonatomic) IBOutlet UITextField *goldTextField;

@property (weak, nonatomic) IBOutlet UITableView *classesTableView;
@property (nonatomic, strong) NSArray *classes;
@property (weak, nonatomic) IBOutlet UIButton *choiceClassesButton;
@property (nonatomic, strong) NSMutableArray *selectedClasses;

@end

@implementation UNStudentController

- (NSMutableArray *)selectedClasses{

    if (!_selectedClasses) {
        _selectedClasses = [NSMutableArray array];
    }
    return _selectedClasses;
}

- (NSArray *)classes{

    if (!_classes) {
        _classes = [NSArray array];
        BmobQuery *bq = [BmobQuery queryWithClassName:@"Classes"];
        [bq includeKey:@"byUser"];
        [bq findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            _classes = array;
            [self.classesTableView reloadData];
        }];
    }
    return _classes;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupTableView];
    [self setupViewsInit];
}

- (void)setupViewsInit{
    self.choiceClassesButton.selected = NO;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"创建" style:UIBarButtonItemStyleDone target:self action:@selector(creatStudentAccount:)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)creatStudentAccount:(UIBarButtonItem *)item{
    NSLog(@"创建学生账号成功");
}

- (void)setupTableView{
    //设置初始的位置
    self.classesTableView.frame = CGRectMake(0, KScreenSize.height, KScreenSize.width, 200);
    self.classesTableView.tableFooterView = [[UIView alloc] init];
    
}

- (IBAction)choiceHeaderImage:(UIButton *)sender {
    
    
}
- (IBAction)choiceClasses:(UIButton *)sender {
    CGRect frame = self.classesTableView.frame;
    
    if (!self.choiceClassesButton.selected) {
        frame.origin.y -= 200;
        
    }else{
        frame.origin.y += 200;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.classesTableView.frame = frame;
    }];
    self.choiceClassesButton.selected = !self.choiceClassesButton.selected;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableView DataScource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 45;
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
   
    BmobObject *obj = self.classes[indexPath.row];
    cell.textLabel.text = [obj objectForKey:@"name"];
    
    if ([self.selectedClasses containsObject:[obj objectForKey:@"name"]]) {
       cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    BmobObject *obj = self.classes[indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType != UITableViewCellAccessoryCheckmark) {
        [self.selectedClasses addObject:[obj objectForKey:@"name"]];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
    
        [self.selectedClasses removeObject:[obj objectForKey:@"name"]];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
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
