//
//  UNUserLeftHeaderCell.m
//  LearnEnglish
//
//  Created by universe on 2016/12/30.
//  Copyright © 2016年 universe. All rights reserved.
//

#import "UNUserLeftHeaderCell.h"

@implementation UNUserLeftHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.headerImage.layer.cornerRadius = 25;
    self.headerImage.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
