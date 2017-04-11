//
//  TLYNavigationController.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/10.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import "TLYNavigationController.h"

@interface TLYNavigationController ()<UIGestureRecognizerDelegate>

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
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    
    pan.delegate = self;
    self.interactivePopGestureRecognizer.enabled = NO;
    
    
/**
 <UIScreenEdgePanGestureRecognizer: 0x7fa4d2f04960; state = Possible; delaysTouchesBegan = YES; 
 view = <UILayoutContainerView 0x7fa4d2d0a1e0>; 
 target= <(action=handleNavigationTransition:, 
  target=<_UINavigationInteractiveTransition 0x7fa4d2f04820>)>>
 */
    
}


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{

    return self.childViewControllers.count>1;
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if( self.childViewControllers.count>0){
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backWithImage: [UIImage imageNamed:@"navigationButtonReturn"] hightImage: [UIImage imageNamed:@"navigationButtonReturnClick"] target:self action:@selector(backAction) title:@"返回"];
         NSLog(@"%@",self.interactivePopGestureRecognizer);
    }
     [super pushViewController:viewController animated:animated];
   
}


-(void)backAction{

    [self  popViewControllerAnimated:YES];
}

@end
