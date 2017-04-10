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

@end


@implementation TLYTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
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


-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSInteger count = self.items.count;
    
    
    CGFloat btnW = self.tly_width/(count+1);
    CGFloat btnH = self.tly_height;
    CGFloat x= 0;
    int i = 0;
    
    for (UIView *tabbarButton in self.subviews) {
        if([tabbarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            if(i==2){
                i+=1;
            }
            x = i*btnW;
            tabbarButton.frame =CGRectMake(x, 0, btnW, btnH);
            i++;
        }
    }
    
    //调整发布按钮的位置
    self.plusButton.center = CGPointMake(self.tly_width*0.5, self.tly_height *0.5);

}

@end
