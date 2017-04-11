//
//  TLYAdViewController.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/10.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import "TLYAdViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "TLYAdItem.h"
#import <MJExtension/MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "TLYTabBarController.h"



#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@interface TLYAdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UIView *contentPlacholder;
@property (weak, nonatomic) IBOutlet UIButton *jump;
@property (weak,nonatomic)  IBOutlet UIImageView *adimageview;
@property (nonatomic,strong) TLYAdItem *adItem;
@property (nonatomic,weak) NSTimer *timer;

@end

@implementation TLYAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLauchImage];
    
    [self loadImage];
    
   _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    
}


//倒计时
-(void)timeFireMethod{
    
    static int i = 3;
    
    if(i==0){
        [self clickJump:nil];
    }
    i--;
    [ self.jump setTitle:[NSString stringWithFormat:@"跳过(%d)",i] forState:UIControlStateNormal];
    
}


//点击跳过
- (IBAction)clickJump:(id)sender {
    TLYTabBarController *tab =[[TLYTabBarController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tab;
    [self.timer invalidate];
}


//懒加载view
-(UIImageView *)adimageview{
    if(_adimageview==nil){
        UIImageView *im = [[UIImageView alloc]init];
        
        UITapGestureRecognizer *gen = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [im addGestureRecognizer:gen];
        
        im.userInteractionEnabled =YES;
        
        _adimageview= im;
        
        [self.contentPlacholder addSubview:im];
    }
    return _adimageview;
}


-(void)tap{
    NSURL *url= [NSURL URLWithString:self.adItem.w_picurl];
    UIApplication *app = [UIApplication sharedApplication];
    if([app canOpenURL:url]){
        [app openURL:url];
    }
    
}

//加载广告也数据
-(void)loadImage{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"code2"] =code2;
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    
    [manager GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *adDict = [responseObject[@"ad"]lastObject];
        self.adItem = [TLYAdItem mj_objectWithKeyValues:adDict];
        
        CGFloat h = TLYScreenW / self.adItem.w * self.adItem.h;
        
        self.adimageview.frame = CGRectMake(0, 0, TLYScreenW, h);
        
        [self.adimageview sd_setImageWithURL:[NSURL URLWithString:self.adItem.w_picurl]];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          NSLog(@"%@",error);
    }];

}

//设置启动页
-(void)setLauchImage{
    if(inphone6p){
        self.imageview.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }else if(inphone6){
        self.imageview.image = [UIImage imageNamed:@"LaunchImage-800-667h"];

    }else if(inphone5){
        self.imageview.image = [UIImage imageNamed:@"LaunchImage-568h"];

    }else if(inphone4){
        self.imageview.image = [UIImage imageNamed:@"LaunchImage-700"];

    }

    
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
