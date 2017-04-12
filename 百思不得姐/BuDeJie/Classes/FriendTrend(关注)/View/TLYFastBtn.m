//
//  TLYFastBtn.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/12.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import "TLYFastBtn.h"

@implementation TLYFastBtn

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.tly_y = 0;
    self.imageView.center_x = self.tly_width*0.5;
    
    self.titleLabel.center_y = self.tly_height-self.titleLabel.tly_height;
    [self.titleLabel sizeToFit];
    
    
    self.titleLabel.center_x =self.tly_width*0.5;

}

@end
