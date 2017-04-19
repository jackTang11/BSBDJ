//
//  TLYSquareCell.h
//  百思不得姐
//
//  Created by jack_tang on 17/4/13.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TLYSquareItem;
@interface TLYSquareCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (nonatomic,strong) TLYSquareItem *item;
@end
