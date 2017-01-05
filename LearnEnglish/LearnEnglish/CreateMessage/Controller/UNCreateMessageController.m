//
//  UNCreateMessageController.m
//  LearnEnglish
//
//  Created by universe on 2017/1/4.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNCreateMessageController.h"
#import "UNEmojiView.h"

@interface UNCreateMessageController ()<YYTextViewDelegate,UNEmojiViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *toolBarView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyBoardHeaderConstraint;
@property (weak, nonatomic) IBOutlet UIButton *showHidenKeyBoardButton;
@property (weak, nonatomic) IBOutlet UILabel *imagesCountLable;

@property (weak, nonatomic) IBOutlet YYTextView *titleTextView;
@property (weak, nonatomic) IBOutlet YYTextView *contentTextView;
@property (nonatomic, strong) YYTextView *currentTextView;

//
@property (nonatomic, strong) UNEmojiView *emojiView;

@end

@implementation UNCreateMessageController


- (void)textViewDidBeginEditing:(YYTextView *)textView{
    self.currentTextView = textView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupUI];
 
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}


#pragma mark -
#pragma mark 有关键盘的设置
- (void)keyboardFrameChange:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat y = keyboardRect.origin.y;
    //判断键盘的收 关
    if (y == KScreenSize.height) {
        self.showHidenKeyBoardButton.selected = NO;
        [UIView animateWithDuration:[self getKeyBoardAnimationDuration:notification] animations:^{
             self.toolBarView.transform = CGAffineTransformIdentity;
        }];
    }else{
        self.showHidenKeyBoardButton.selected = YES;
        [UIView animateWithDuration:[self getKeyBoardAnimationDuration:notification] animations:^{
            self.toolBarView.transform = CGAffineTransformMakeTranslation(0, -keyboardRect.size.height );
        }];
        
    }
}
- (IBAction)hiddenKeyBoard:(UIButton *)sender {
    
    if (self.showHidenKeyBoardButton.selected) {
        [self.view endEditing:YES];
    }
    
}
- (NSTimeInterval)getKeyBoardAnimationDuration:(NSNotification *)notification{
    
    NSDictionary *userInfo = [notification userInfo];
    NSValue *durationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [durationValue getValue:&animationDuration];

    return animationDuration;
}


#pragma mark -
#pragma mark 界面和导航栏设置
- (void)setupUI{

    self.title = @"新建消息";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(sendAction)];
    
    self.titleTextView.delegate = self;
    self.contentTextView.delegate = self;
    [self.titleTextView becomeFirstResponder];
    
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
#pragma mark -
#pragma mark 添加表情键盘

- (UNEmojiView *)emojiView{

    if (!_emojiView) {
        _emojiView = [[[NSBundle mainBundle] loadNibNamed:@"UNEmojiView" owner:self options:0] firstObject];
        _emojiView.delegate = self;
        //让界面中文本输入框 进行表情匹配
        [WorkTools emojiMappingWithText:self.titleTextView];
        [WorkTools emojiMappingWithText:self.contentTextView];
        
    }
    return _emojiView;
}

- (IBAction)emojiButtonDidTouch:(UIButton *)sender {
    //self.currentTextView.inputView? nil :
    self.currentTextView.inputView = self.emojiView;
    [self.currentTextView reloadInputViews];
    
}

//代理实现点击事件
- (void)didClickDeleteButton{

    [self.currentTextView deleteBackward];
}

- (void)didClickEmoji:(NSString *)text{
    [self.currentTextView insertText:text];
    
}



#pragma mark -
#pragma mark 图片选择器
- (IBAction)pictureSelectDidTouch:(UIButton *)sender {
}



#pragma mark -
#pragma mark 语音
- (IBAction)voiceButtonDidTouch:(UIButton *)sender {
}



#pragma mark -
#pragma mark 系统键盘
- (IBAction)systemButtonDidTouch:(UIButton *)sender {
    
    self.currentTextView.inputView = nil;
    [self.currentTextView reloadInputViews];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];
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
