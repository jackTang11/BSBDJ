//
//  UITextField+Placeholder.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/13.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import "UITextField+Placeholder.h"
#import <objc/message.h>

@implementation UITextField (Placeholder)

+(void)load{
    //方法交换
    Method m1 = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method m2 = class_getInstanceMethod(self, @selector(setTly_Placeholder:));
    method_exchangeImplementations(m1, m2);

}


-(UIColor *)placeholderColor{
    return nil;
}


-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    //给系统属性定义
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN);
    UILabel *placeholderLabel =  [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
}



-(void)setTly_Placeholder:(NSString *)placeholder{
    [self setTly_Placeholder:placeholder];
    self.placeholderColor = self.placeholderColor;
}


@end
