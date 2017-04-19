//
//  UIImage+Image.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/4.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

+(instancetype)originalImagewithName:(NSString *)name{
    UIImage *image = [UIImage imageNamed:name];
    return  [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

-(instancetype)cicrleImage{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    [path addClip];
    [self drawAtPoint:CGPointZero];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  image;
}
@end
