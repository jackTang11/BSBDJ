//
//  TLYAllViewController.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/14.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import "TLYAllViewController.h"
#import "TLYTopicViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import "TLYTopicItem.h"
#import <MJExtension/MJExtension.h>
#import "TLYTopicItem.h"
#import <MJRefresh/MJRefresh.h>
static NSString * const ID = @"cell";
@interface TLYAllViewController ()

@property (nonatomic,strong)  AFHTTPSessionManager *manager;
@property (nonatomic,strong) NSMutableArray<TLYTopicItem *> *cellData;
/** 当前最后一条帖子数据的描述信息，专门用来加载下一页数据 */
@property (nonatomic, copy) NSString *maxtime;
@end

@implementation TLYAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = TLYRandomColor;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    self.tableView.contentInset = UIEdgeInsetsMake(TLYNavMaxY+TLYTitleViewH, 0, TLYTabBarH, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.estimatedRowHeight = 200;
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([TLYTopicViewCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:ID];
    
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabClick) name:UITabClickNotification object:nil];
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleClick) name:UITitleClickNotification object:nil];
    
    self.tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.tableView.mj_header beginRefreshing];
}


-(AFHTTPSessionManager *)manager{
    if(_manager ==nil){
        AFHTTPSessionManager *manager =  [AFHTTPSessionManager manager];
        _manager =manager;
    }
    return _manager;
}

/**
 加载数据
 **/
-(void)loadData{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.tabType);
    [self.manager GET:TLYCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
      self.cellData = [TLYTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
      [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [self.tableView.mj_header endRefreshing];
 
    }];
}


/**
 加载数据
 **/
-(void)loadMoreData{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.tabType);
    parameters[@"maxtime"] = self.maxtime;

    [self.manager GET:TLYCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        [self.cellData addObjectsFromArray:[TLYTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]]];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
    
    
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
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellData.count;
}

/**
 计算每个cell 内容的高度
 **/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TLYTopicItem *item = self.cellData[indexPath.item];
    return item.cellHeight;
}

/**
 移除接受通知
 */
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TLYTopicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.item = self.cellData[indexPath.item];
    return cell;
}




@end
