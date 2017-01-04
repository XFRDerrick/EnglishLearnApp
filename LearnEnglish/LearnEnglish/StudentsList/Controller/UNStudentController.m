//
//  UNStudentController.m
//  LearnEnglish
//
//  Created by universe on 2017/1/3.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNStudentController.h"
#import "TextCheckingTools.h"


@interface UNStudentController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *choiceHeaderButton;
@property (nonatomic, strong) UIImage *headerImage;

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
    self.title = @"学生注册";
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"创建" style:UIBarButtonItemStyleDone target:self action:@selector(creatStudentAccount:)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)creatStudentAccount:(UIBarButtonItem *)item{
    NSLog(@"创建学生账号成功");
    //判断用户名和密码 不能为空 班级至少选择一个
    if (![TextCheckingTools checkingTextField:self.usernameTextField] || ![TextCheckingTools checkingTextField:self.userPasswordTextField] || !self.userRealNameTextfield || self.selectedClasses.count == 0) {
        return;
    }
    
    //新建
    BmobUser *user = [[BmobUser alloc] init];
    user.username = self.usernameTextField.text;
    user.password = self.userPasswordTextField.text;
    [user setObject:self.userRealNameTextfield.text forKey:@"nick"];
    [user setObject:self.selectedClasses forKey:@"classes"];
    [user setObject:@(self.integralTextField.text.intValue) forKey:@"integral"];
    [user setObject:@(self.goldTextField.text.intValue) forKey:@"gold"];
    [user setObject:@(NO) forKey:@"teacher"];
    
    [self.view showHUD];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [user signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                //保存头像
                [self saveHeadImage:user];
                
            }else{
                [self.view showMessage:@"新建失败"];
            }
        }];
        
    });
}

- (void)saveHeadImage:(BmobUser *)user{
    
    //判断是否有图片
    if (self.headerImage) {
        NSData *data = UIImageJPEGRepresentation(self.headerImage, .2);
        [BmobFile filesUploadBatchWithDataArray:@[@{@"filename":@"a.jpg",@"data":data}] progressBlock:^(int index, float progress) {
            
        } resultBlock:^(NSArray *array, BOOL isSuccessful, NSError *error) {
            
            if (isSuccessful) {
                BmobFile *bf = array[0];
                [user setObject:bf.url forKey:@"headPath"];
                [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self successfullCreateStudentAccount];
                    });
                }];
            }
        }];
    }else{
        [self successfullCreateStudentAccount];
    }
}

#pragma mark 成功注册学生信息执行任务
- (void)successfullCreateStudentAccount{
    
    [self.view showMessage:@"创建成功"];
    [WorkTools loginTeacherAccount];
    [NSTimer scheduledTimerWithTimeInterval:1.0 block:^(NSTimer * _Nonnull timer) {
        [self.navigationController popViewControllerAnimated:YES];
    } repeats:NO];
    
}

- (void)setupTableView{
    //设置初始的位置
    self.classesTableView.frame = CGRectMake(0, KScreenSize.height, KScreenSize.width, 200);
    self.classesTableView.tableFooterView = [[UIView alloc] init];
    
}

- (IBAction)choiceHeaderImage:(UIButton *)sender {
    
    UIImagePickerController *imageVC = [[UIImagePickerController alloc] init];
    imageVC.delegate = self;
    imageVC.allowsEditing = YES;
    [self presentViewController:imageVC animated:YES completion:nil];
    
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

#pragma mark 选择图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    [self.choiceHeaderButton setBackgroundImage:image forState:UIControlStateNormal];
    self.headerImage = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
