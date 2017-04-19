//
//  TLYTopicVoiceView.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/18.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import "TLYTopicVoiceView.h"
#import "TLYTopicItem.h"
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface TLYTopicVoiceView()
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UILabel *playCountLable;
@property (weak, nonatomic) IBOutlet UILabel *voiceTime;

@end

@implementation TLYTopicVoiceView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask =NO;
}

- (void)setItem:(TLYTopicItem *)item{
    _item =item;
   
    AFNetworkReachabilityManager *manager =[AFNetworkReachabilityManager sharedManager];
    if (manager.isReachableViaWiFi) {
        NSURL *url =[NSURL URLWithString:item.image1];
        [self.bgImage sd_setImageWithURL:url];
    }else {
        NSURL *url =[NSURL URLWithString:item.image0];
        [self.bgImage sd_setImageWithURL:url];
    }
    
    
    if(item.playcount>10000){
    self.playCountLable.text =  [NSString stringWithFormat:@"%.1f万播放",item.playcount/10000.0];
    }else{
    self.playCountLable.text =  [NSString stringWithFormat:@"%ld播放",item.playcount];}
    
    
    
    self.voiceTime.text =  [NSString stringWithFormat:@"%02zd: %02zd",item.voicetime/60,item.voicetime%60];
    
    
    
    
}



@end
