//
//  TLYSubTagViewCell.h
//  百思不得姐
//
//  Created by jack_tang on 17/4/11.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TLYSubTagItem;
@interface TLYSubTagViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *numView;
@property (nonatomic,strong) TLYSubTagItem *tagItem;

@end
