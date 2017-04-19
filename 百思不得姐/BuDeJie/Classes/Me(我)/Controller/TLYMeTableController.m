//
//  TLYMeTableController.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/4.
//  Copyright © 2017年 jack_tang. All rights reserved.
//
#import "TLYSettingTableController.h"
#import "TLYMeTableController.h"
#import "TLYSquareCell.h"
#import <MJExtension/MJExtension.h>
#import <AFNetworking/AFNetworking.h>
#import "TLYSquareItem.h"

static NSString* const ID = @"ID";
static NSInteger const cols = 4;
static CGFloat const margin = 1;
#define itemW (TLYScreenW - (cols-1) *margin)/cols

@interface TLYMeTableController ()<UICollectionViewDataSource>
@property (nonatomic,weak) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation TLYMeTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    
    [self setupNarBar];
    
    [self setupFootView];
    
    [self loadData];

    
    
}

-(void)loadData{
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    [session GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       _dataArray = [TLYSquareItem mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        
        //重新设置高度
        NSInteger count = _dataArray.count;
        NSInteger rows = (count-1)/cols+1;
        self.collectionView.tly_height = rows*itemW + rows*margin;
        self.tableView.tableFooterView = self.collectionView;
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}


-(void)setupFootView{
    
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    flowlayout.itemSize = CGSizeMake(itemW, itemW);
    flowlayout.minimumLineSpacing = margin;
    flowlayout.minimumInteritemSpacing = margin;
    
    UICollectionView *collection= [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:flowlayout];
    
    _collectionView  =collection;
     collection.backgroundColor =self.tableView.backgroundColor;
    
    self.tableView.tableFooterView = _collectionView;
    
    _collectionView.dataSource =self;
    _collectionView.scrollEnabled = NO;
    
    
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TLYSquareCell class]) bundle:nil] forCellWithReuseIdentifier:ID];


}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TLYSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.item = self.dataArray[indexPath.item];

    return cell;
}


-(void)setupNarBar{
    
   UIBarButtonItem *settingBtn = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] hightImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];
    
    UIBarButtonItem *nightItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selectImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(night:)];
    
    self.navigationItem.rightBarButtonItems = @[settingBtn,nightItem];
    
    self.navigationItem.title = @"我的";
}


-(void)setting{
    
    TLYSettingTableController *settingControll = [[TLYSettingTableController alloc]init];
    settingControll.hidesBottomBarWhenPushed = YES;//这个属性必须要在跳转之前设置
    [self.navigationController pushViewController:settingControll animated:YES];
    
}

-(void)night:(UIButton *)button{
    button.selected = !button.selected;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
