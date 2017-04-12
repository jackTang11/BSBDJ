//
//  TLYLoginRegisterViewController.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/12.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import "TLYLoginRegisterViewController.h"
#import "TLYLoginRegistView.h"
#import "TLYFastLoginView.h"

@interface TLYLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *middle;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic,strong)  TLYLoginRegistView *loginView;
@property (nonatomic,strong)  TLYLoginRegistView *registView;
@property (nonatomic,strong)  TLYFastLoginView *fastLoginView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadCons;

@end

@implementation TLYLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginView =[TLYLoginRegistView loginView];
    [self.middle addSubview:self.loginView];
    
    
    self.registView =[TLYLoginRegistView registView];
    [self.middle addSubview:self.registView];
    
    
    self.fastLoginView = [TLYFastLoginView loginView];
    [self.bottomView addSubview:self.fastLoginView];
    
}


-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
   TLYLoginRegistView *loginView = self.middle.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.middle.tly_width*0.5, loginView.tly_height);
    
   TLYLoginRegistView *registView = self.middle.subviews[1];
    registView.frame = CGRectMake(self.middle.tly_width*0.5, 0, self.middle.tly_width*0.5, loginView.tly_height);
    

}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)loginOrRegist:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    
    
    self.leadCons.constant = _leadCons.constant == 0 ? -self.middle.tly_width*0.5 : 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
