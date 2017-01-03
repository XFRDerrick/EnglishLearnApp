//
//  UNStudentCell.m
//  LearnEnglish
//
//  Created by universe on 2017/1/3.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNStudentCell.h"

@interface UNStudentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLable;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *goldLable;
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;



@end

@implementation UNStudentCell

- (void)setStudent:(BmobUser *)student{

    _student = student;
    
    if ([student objectForKey:@"headPath"]) {
        [self.headerImage setImageWithURL:[NSURL URLWithString:[student objectForKey:@"headPath"]] placeholder:[UIImage imageNamed:@"tmpHead"]];
    }else{
    
        [self.headerImage setImage:[UIImage imageNamed:@"tmpHead"]];
    }
    self.userNameLable.text = student.username;
    self.nickName.text = [student objectForKey:@"nick"];
    self.goldLable.text = [NSString stringWithFormat:@"金币:%@",[student objectForKey:@"gold"]];
    
    self.scoreLable.text =  [NSString stringWithFormat:@"积分:%@",[student objectForKey:@"integral"]];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.headerImage.layer.cornerRadius = 20;
    self.headerImage.layer.masksToBounds = YES;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
