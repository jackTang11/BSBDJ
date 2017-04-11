//
//  UIBarButtonItem+Item.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/10.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)

+(UIBarButtonItem *)itemWithImage:(UIImage *)image hightImage:(UIImage *)hightImage target:(nullable id)target action:(SEL)action {
    
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:hightImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *addview = [[UIView alloc]initWithFrame:btn.bounds];
    [addview addSubview:btn];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithCustomView:addview];
    return barButton;
}

+(UIBarButtonItem *)itemWithImage:(UIImage *)image selectImage:(UIImage *)selectImage target:(nullable id)target action:(SEL)action {
    
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selectImage forState:UIControlStateSelected];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *addview = [[UIView alloc]initWithFrame:btn.bounds];
    [addview addSubview:btn];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithCustomView:addview];
    return barButton;
}

+(UIBarButtonItem *)backWithImage:(UIImage *)image hightImage:(UIImage *)hightImage target:(nullable id)target action:(SEL)action title:(NSString *)title{
    
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:hightImage forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    

    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
 
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return barButton;
}
@end
