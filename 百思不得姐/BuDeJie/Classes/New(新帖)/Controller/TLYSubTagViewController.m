//
//  TLYSubTagViewController.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/11.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import "TLYSubTagViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "TLYSubTagItem.h"
#import <MJExtension/MJExtension.h>
#import "TLYSubTagViewCell.h"
#import <SVProgressHUD/SVProgressHUD.h>



static NSString * const ID = @"cell";


@interface TLYSubTagViewController ()
@property (nonatomic,strong) NSArray *subTags;
@property (nonatomic,strong) AFHTTPSessionManager *manager;
@end

@implementation TLYSubTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新帖";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TLYSubTagViewCell" bundle:nil] forCellReuseIdentifier:ID];
    
    [self loadData];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = TLYColor(220, 220, 221);
    
   
    
}


-(void)loadData{
    [SVProgressHUD showWithStatus:@"加载中"];
    _manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"]= @"tag_recommend";
    parameters[@"action"]= @"sub";
    parameters[@"c"]= @"topic";
    [_manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray*  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        self.subTags = [TLYSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];

    }];
    
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    [_manager.tasks makeObjectsPerformSelector:@selector(cancel)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.subTags.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TLYSubTagViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.tagItem = self.subTags[indexPath.row];

    
    return  cell;

}



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
