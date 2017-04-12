//
//  TLYFriendTrendController.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/4.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import "TLYFriendTrendController.h"
#import "TLYLoginRegisterViewController.h"

@interface TLYFriendTrendController ()

@end

@implementation TLYFriendTrendController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupBavBar];
}
- (IBAction)loginAction:(id)sender {
    TLYLoginRegisterViewController *login = [[TLYLoginRegisterViewController alloc]init];
    [self.navigationController presentViewController:login animated:YES completion:nil];
    
}


-(void)setupBavBar{
    self.navigationItem.title= @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] hightImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(friendRecomment)];
}


-(void)friendRecomment{
    

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
