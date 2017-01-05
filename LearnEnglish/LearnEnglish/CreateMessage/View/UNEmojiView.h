//
//  UNEmojiView.h
//  LearnEnglish
//
//  Created by universe on 2017/1/5.
//  Copyright © 2017年 universe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UNEmojiViewDelegate <NSObject>

- (void)didClickEmoji:(NSString *)text;
- (void)didClickDeleteButton;

@end

@interface UNEmojiView : UIView

#pragma mark delegate
@property (nonatomic, weak) id<UNEmojiViewDelegate> delegate;

@end
