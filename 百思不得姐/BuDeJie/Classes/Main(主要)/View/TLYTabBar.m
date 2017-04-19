//
//  TLYTabBar.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/7.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import "TLYTabBar.h"

@interface TLYTabBar()
@property (nonatomic,weak) UIButton *plusButton;
@property (nonatomic,weak) UIControl *preButton;

@end


@implementation TLYTabBar

/**
 自定义一个中间按钮
 */
-(UIButton *)plusButton{
    if(_plusButton==nil){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
         [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        [self addSubview:btn];
    
        _plusButton = btn;
    }

    return _plusButton;
}


/**
 动态修改按钮的位置
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSInteger count = self.items.count;
    
    
    CGFloat btnW = self.tly_width/(count+1);
    CGFloat btnH = self.tly_height;
    CGFloat x= 0;
    int i = 0;
    
    for (UIControl *tabbarButton in self.subviews) {
        if([tabbarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            if(i==2){
                i+=1;
            }
            x = i*btnW;
            tabbarButton.frame =CGRectMake(x, 0, btnW, btnH);
            
            
            if(self.preButton == nil && i==0){//记录第一个按钮
                self.preButton = tabbarButton;
            }
            
            [tabbarButton addTarget:self action:@selector(tagClick:) forControlEvents:UIControlEventTouchUpInside];
            i++;
        }
    }
    
    //调整发布按钮的位置
    self.plusButton.center = CGPointMake(self.tly_width*0.5, self.tly_height *0.5);
}


/**
 多次点击tab切换事件
 */
-(void)tagClick:(UIControl *)tabbar{
    if(self.preButton == tabbar){
          [[NSNotificationCenter defaultCenter]postNotificationName:UITabClickNotification object:nil];
    }
    self.preButton = tabbar;
}

@end
