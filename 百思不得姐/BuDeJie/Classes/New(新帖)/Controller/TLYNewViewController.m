//
//  TLYNewViewController.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/4.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import "TLYNewViewController.h"
#import "TLYSubTagViewController.h"

@interface TLYNewViewController ()

@end

@implementation TLYNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    [self setupNavBar];
}

-(void)setupNavBar{
    // 左边按钮
    // 把UIButton包装成UIBarButtonItem.就导致按钮点击区域扩大
    self.navigationItem.leftBarButtonItem =  [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] hightImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(tagClick)];
    // titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];


}

//点击订阅
-(void)tagClick{
    TLYSubTagViewController *tag = [[TLYSubTagViewController alloc]init];
    [self.navigationController pushViewController:tag animated:YES];

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
