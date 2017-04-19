//
//  TLYEssenceController.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/4.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import "TLYEssenceController.h"
#import "TLYAllViewController.h"
#import "TLYVideoViewController.h"
#import "TLYPictureViewController.h"
#import "TLYWorldViewController.h"
#import "TLYVoiceViewController.h"


@interface TLYEssenceController ()<UIScrollViewDelegate>
@property (nonatomic,weak) UIButton *preBtn;
@property(nonatomic,weak) UIView *titleview;
@property(nonatomic,weak) UIView *underline;
@property (nonatomic,weak) UIScrollView *scrollView;

@end

@implementation TLYEssenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    [self setupBavBar];
    
    [self addChildViewController];
    
    [self setScrollview];
    
    [self setTitleView];
    
    [self setUnderLine];
    
    [self addChildView];
   
}

/**添加所有自控制器
 */
-(void)addChildViewController{
    
   TLYAllViewController *all = [[TLYAllViewController alloc]init];
    all.tabType =TLYTopicTypeAll;
    [self addChildViewController:all];
    
    TLYAllViewController *Video = [[TLYAllViewController alloc]init];
    Video.tabType =TLYTopicTypeVideo;
    [self addChildViewController:Video];
    
    TLYAllViewController *Voice = [[TLYAllViewController alloc]init];
    Voice.tabType =TLYTopicTypeVoice;
    [self addChildViewController:Voice];
    
    TLYAllViewController *Picture = [[TLYAllViewController alloc]init];
    Picture.tabType =TLYTopicTypePicture;
    [self addChildViewController:Picture];
    
    
    TLYAllViewController *world = [[TLYAllViewController alloc]init];
    world.tabType =TLYTopicTypeWord;
    [self addChildViewController:world];
    
}


/**
 添加ScrollView
 
 */
-(void)setScrollview{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollview = [[UIScrollView alloc]init];
    scrollview.showsVerticalScrollIndicator = NO;
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.backgroundColor = [UIColor redColor];
    scrollview.frame = self.view.bounds;
    scrollview.pagingEnabled = YES;
    scrollview.delegate =self;
    [self.view addSubview:scrollview];
    self.scrollView = scrollview;
    //设置滚动范围
    self.scrollView.contentSize = CGSizeMake(self.childViewControllers.count * TLYScreenW, 0);
}


/**
 设置titleView
 */
-(void)setTitleView{
    UIView *titleview = [[UIView alloc]init];
    self.titleview = titleview;
    titleview.frame = CGRectMake(0, 64, TLYScreenW, 35);
    titleview.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    [self.view addSubview:titleview];
    
    NSArray *titleName = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSInteger titleCount = titleName.count;
    CGFloat w = TLYScreenW/titleCount;
    
    for (int i=0; i<titleCount;i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titleName[i] forState:UIControlStateNormal];
        button.frame = CGRectMake(i*w, 0, w, titleview.tly_height);
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectTitle:) forControlEvents:UIControlEventTouchUpInside];
        [titleview addSubview:button];
    }
}

/**
 设置下划线
 */
-(void)setUnderLine{
    UIButton *btn =  self.titleview.subviews.firstObject;
    UIView *line = [[UIView alloc]init];
    line.tly_height =2 ;
    line.tly_y = self.titleview.tly_height- line.tly_height;
    line.backgroundColor = [btn titleColorForState:UIControlStateSelected];
    [self.titleview addSubview:line];
    self.underline = line;

    self.preBtn = btn;
    btn.selected = YES;
    //重新测量label
    [btn.titleLabel sizeToFit];
    self.underline.tly_width =btn.titleLabel.tly_width+10;
    self.underline.center_x = btn.center_x;
}

//点击title 处理事件
-(void)selectTitle:(UIButton *)btn{
    if(self.preBtn == btn){
        [[NSNotificationCenter defaultCenter] postNotificationName:UITitleClickNotification object:nil];
    }
    
    
    self.preBtn.selected =NO;
    btn.selected =YES;
    self.preBtn = btn;
   
   NSInteger index=  [self.titleview.subviews indexOfObject:btn];
    
    [UIView animateWithDuration:0.3 animations:^{
         self.underline.tly_width = btn.titleLabel.tly_width+10;
        self.underline.center_x = btn.center_x;
        CGFloat offsetx = TLYScreenW * index;
        self.scrollView.contentOffset = CGPointMake(offsetx, self.scrollView.contentOffset.y);
    }completion:^(BOOL finished) {
        [self addChildView];
    } ];
    
    //遍历 如果不是当前显示的控制器,就将scrollsToTop设置为NO
    for(NSInteger i =0 ;i<self.childViewControllers.count;i++){
        UITableViewController *controller = self.childViewControllers[i];
        controller.tableView.scrollsToTop = index==i;
    }
    
}


//使用懒加载的方式 加载view,当选中的时候再去加载
-(void)addChildView{
    NSInteger index = self.scrollView.contentOffset.x /self.scrollView.tly_width;
    UIView *childView =self.childViewControllers[index].view;
    childView.frame = CGRectMake(self.scrollView.contentOffset.x, 0, self.scrollView.tly_width, self.scrollView.tly_height);
//    childView.frame = self.scrollView.bounds;
    [self.scrollView addSubview:childView];
    
    
    
    
}


/**
 设置顶部左右按钮
 */
-(void)setupBavBar{
    
    self.navigationItem.leftBarButtonItem =  [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] hightImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
 
   
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] hightImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:self action:nil];
    
    self.navigationItem.titleView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
}


//当滑动结束时,重新定义title的选中位置
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
   NSInteger index = scrollView.contentOffset.x / self.scrollView.tly_width;
    [self selectTitle:self.titleview.subviews[index]];
}



-(void)game{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
