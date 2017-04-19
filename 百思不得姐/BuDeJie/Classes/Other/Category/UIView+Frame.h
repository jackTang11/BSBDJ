//
//  UIView+Frame.h
//  百思不得姐
//
//  Created by jack_tang on 17/4/7.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property CGFloat tly_width;
@property CGFloat tly_height;
@property CGFloat tly_x;
@property CGFloat tly_y;
@property CGFloat center_x;
@property CGFloat center_y;

+(instancetype)tly_viewFromNib;
@end
