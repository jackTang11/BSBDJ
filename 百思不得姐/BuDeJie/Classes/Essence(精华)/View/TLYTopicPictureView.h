//
//  TLYTopicPictureView.h
//  百思不得姐
//
//  Created by jack_tang on 17/4/18.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TLYTopicItem;
@interface TLYTopicPictureView : UIView
@property (nonatomic,strong) TLYTopicItem *item;
@property (weak, nonatomic) IBOutlet UIImageView *imageBg;
@property (weak, nonatomic) IBOutlet UIButton *seeBigBtn;
@property (weak, nonatomic) IBOutlet UIImageView *gifBtn;

@end
