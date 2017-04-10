//
//  TLYNavigationController.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/10.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import "TLYNavigationController.h"

@interface TLYNavigationController ()

@end

@implementation TLYNavigationController


+(void)load{

   UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self , nil];
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [navBar setTitleTextAttributes:dict];
    
    //设置导航条背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
