//
//  TLYTopicVideoView.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/18.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import "TLYTopicVideoView.h"
#import "TLYTopicItem.h"

@implementation TLYTopicVideoView


-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.autoresizingMask =NO;
}


-(void)setItem:(TLYTopicItem *)item{
    _item =item;
}

@end
