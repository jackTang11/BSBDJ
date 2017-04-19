//
//  UIView+Frame.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/7.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

-(void)setTly_height:(CGFloat)tly_height{
    CGRect rect = self.frame;
    rect.size.height =tly_height;
    self.frame =rect;
}

-(CGFloat)tly_height{
    return self.frame.size.height;

}

+(instancetype)tly_viewFromNib{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

-(void)setTly_width:(CGFloat)tly_width{
    CGRect  rect = self.frame;
    rect.size.width = tly_width;
    self.frame =rect;
}


-(CGFloat)tly_width{
    return self.frame.size.width;
}

-(void)setTly_x:(CGFloat)tly_x{

    CGRect rect = self.frame;
    rect.origin.x =tly_x;
    self.frame =rect;

}

-(CGFloat)tly_x{

    return  self.frame.origin.x;
}



-(void)setTly_y:(CGFloat)tly_y{

    CGRect rect = self.frame;
    rect.origin.y = tly_y;
    self.frame =rect;
    
}

-(CGFloat)tly_y{
    return self.frame.origin.y;
}

-(void)setCenter_x:(CGFloat)center_x{
   CGPoint point = self.center;
    point.x = center_x;
    self.center = point;
}


-(CGFloat)center_x{
    return self.center.x;

}


-(void)setCenter_y:(CGFloat)center_y{
   CGPoint point = self.center;
    point.y =center_y;
    self.center=point;

}

-(CGFloat)center_y{
    return self.center.y;
}




@end
