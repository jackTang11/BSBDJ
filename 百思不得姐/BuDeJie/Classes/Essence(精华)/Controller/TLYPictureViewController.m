//
//  TLYPictureViewController.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/14.
//  Copyright © 2017年 jack_tang. All rights reserved.
//
static NSString * const ID = @"cell";
#import "TLYPictureViewController.h"

@interface TLYPictureViewController ()

@end

@implementation TLYPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TLYRandomColor;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    self.tableView.contentInset = UIEdgeInsetsMake(TLYNavMaxY+TLYTitleViewH, 0, TLYTabBarH, 0);
    
    
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabClick) name:UITabClickNotification object:nil];
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleClick) name:UITitleClickNotification object:nil];
}



-(void)titleClick{
    [self tabClick];
    
}

/**
 重新刷新的通知
 */
-(void)tabClick{
    if(self.view.window==nil)return ;
    
    if(self.tableView.scrollsToTop == NO)return;//是否是点击的当前view刷新
    
    TLYFunc;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

/**
 移除接受通知
 */
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if(cell ==nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor =[UIColor clearColor];
        
    }
    cell.textLabel.text = [NSString stringWithFormat:@"这是%ld",(long)indexPath.item];
    return cell;
}



@end
