//
//  TLYTabBarController.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/4.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import "TLYTabBarController.h"
#import "TLYEssenceController.h"
#import "TLYMeTableController.h"
#import "TLYNewViewController.h"
#import "TLYPublishController.h"
#import "TLYFriendTrendController.h"
#import "UIImage+Image.h"
#import "TLYTabBar.h"
#import "TLYNavigationController.h"

@interface TLYTabBarController ()

@end

@implementation TLYTabBarController


+(void)load{
  UITabBarItem *item =  [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:dict forState:UIControlStateSelected];
    
    //设置尺寸: 只有设置正常状态下,才会有效果
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    dict1[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:dict1 forState:UIControlStateNormal];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    //设置子控制器
    [self setupAllChildViewController];
    //设置tabbar上的按钮内容
    [self setAllTitleButton];
    
    [self setupTabBar];
}



-(void)setupTabBar{
    TLYTabBar *tabbar = [[TLYTabBar alloc]init];
    [self setValue:tabbar forKey:@"tabBar"];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)setAllTitleButton{
    TLYNavigationController *nav1 =  self.childViewControllers[0];
    nav1.tabBarItem.title= @"精华";
    nav1.tabBarItem.image =  [UIImage imageNamed:@"tabBar_essence_icon"];
    nav1.tabBarItem.selectedImage = [UIImage originalImagewithName:@"tabBar_essence_click_icon"];
    
    TLYNavigationController *nav2 =  self.childViewControllers[1];
    nav2.tabBarItem.title= @"新帖";
    nav2.tabBarItem.image =  [UIImage imageNamed:@"tabBar_new_icon"];
    nav2.tabBarItem.selectedImage = [UIImage originalImagewithName:@"tabBar_new_click_icon"];
    
//    UIViewController *nav3 =  self.childViewControllers[2];
//    nav3.tabBarItem.title= @"发布";
//    nav3.tabBarItem.image =  [UIImage imageNamed:@"tabBar_publish_icon"];
//    nav3.tabBarItem.selectedImage = [UIImage originalImagewithName:@"tabBar_publish_click_icon"];
    
    TLYNavigationController *nav4 =  self.childViewControllers[2];
    nav4.tabBarItem.title= @"关注";
    nav4.tabBarItem.image =  [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    nav4.tabBarItem.selectedImage = [UIImage originalImagewithName:@"tabBar_friendTrends_click_icon"];
    
    TLYNavigationController *nav5 =  self.childViewControllers[3];
    nav5.tabBarItem.title= @"我";
    nav5.tabBarItem.image =  [UIImage imageNamed:@"tabBar_me_icon"];
    nav5.tabBarItem.selectedImage = [UIImage originalImagewithName:@"tabBar_me_click_icon"];
    
    

}

-(void)setupAllChildViewController{
    //精华
   TLYEssenceController *essence = [[TLYEssenceController alloc]init];
    [self addChildViewController:[[TLYNavigationController alloc]initWithRootViewController:essence]];

    
    //新帖
    TLYNewViewController *newVc = [[TLYNewViewController alloc]init];
    [self addChildViewController:[[TLYNavigationController alloc]initWithRootViewController:newVc]];
    
    //发布
//    TLYPublishController *publishVc = [[TLYPublishController alloc]init];
//    [self addChildViewController:publishVc];
    
    //关注
    TLYFriendTrendController *friendVc = [[TLYFriendTrendController alloc]init];
    [self addChildViewController:[[TLYNavigationController alloc]initWithRootViewController:friendVc]];
    //我的

    TLYMeTableController *meVc = [[UIStoryboard storyboardWithName:@"TLYMeTableController" bundle:nil] instantiateInitialViewController];
    [self addChildViewController:[[TLYNavigationController alloc]initWithRootViewController:meVc]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
