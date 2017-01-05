//
//  UNEmojiView.m
//  LearnEnglish
//
//  Created by universe on 2017/1/5.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNEmojiView.h"

#define KLinePerCount 8


@interface UNEmojiView ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *emojis;

@end

@implementation UNEmojiView


- (void)awakeFromNib{

    [super awakeFromNib];
    [self addEmojiButton];
}

- (void)addEmojiButton{

    NSString *path = [[NSBundle mainBundle] pathForResource:@"default" ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    self.emojis = arr;
    
    float size = KScreenSize.width / KLinePerCount;
    NSInteger page = arr.count % 31 == 0 ? arr.count / 31 : arr.count / 31 + 1;
    for (int i = 0; i< page; i++) {
        int pageCount = (i + 1) * 31 > arr.count ? arr.count % 31 + 1 : 32;
        for (int j = 0; j < pageCount; j ++) {
            
            CGFloat x = j % KLinePerCount * size + i * KScreenSize.width;
            CGFloat y = j / KLinePerCount * size;
            
//            NSLog(@"%d*31+%d = %d",i,j,(i * 31 + j));

             UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, size, size)];
            [self.scrollView addSubview:btn];
            if (j == pageCount - 1) {
                [btn setImage:[UIImage imageNamed:@"ms_attributes_canlce"] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(deleteEmojiAction:) forControlEvents:UIControlEventTouchUpInside];
                btn.tag = 220;
            }else{
                NSDictionary *emojiDict = arr[i * 31 + j];
                NSString *imageName = emojiDict[@"png"];
                [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(emojiDidTouchAction:) forControlEvents:UIControlEventTouchUpInside];
                btn.tag = i * 31 + j;
            }
            
            
        }
        
        self.scrollView.contentSize = CGSizeMake(page * KScreenSize.width, 0);
    }
}

- (void)emojiDidTouchAction:(UIButton *)sender{
    
    NSLog(@"添加输入emoji");
    NSDictionary *dic = self.emojis[sender.tag];
    NSString *chs = dic[@"chs"];
    [self.delegate didClickEmoji:chs];
}

- (void)deleteEmojiAction:(UIButton *)sender{
    
    NSLog(@"删除输入的emoji");
    [self.delegate didClickDeleteButton];
}



@end
