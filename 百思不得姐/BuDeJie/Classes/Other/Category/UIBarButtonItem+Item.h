//
//  UIBarButtonItem+Item.h
//  百思不得姐
//
//  Created by jack_tang on 17/4/10.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)

+(UIBarButtonItem *)itemWithImage:(UIImage *)image hightImage:(UIImage *)hightImage target:(nullable id)target action:(SEL)action;
+(UIBarButtonItem *)itemWithImage:(UIImage *)image selectImage:(UIImage *)selectImage target:(nullable id)target action:(SEL)action;

@end
