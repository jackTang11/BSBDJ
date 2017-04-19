//
//  TLYSquareCell.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/13.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import "TLYSquareCell.h"
#import "TLYSquareItem.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation TLYSquareCell


-(void)setItem:(TLYSquareItem *)item{
    _item =item;
    self.nameLable.text = item.name;
    
    NSURL *url = [NSURL URLWithString:item.icon];
    
    [self.iconImage sd_setImageWithURL:url];
  
}

@end
