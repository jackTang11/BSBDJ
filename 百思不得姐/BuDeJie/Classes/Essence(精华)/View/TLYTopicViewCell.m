//
//  TLYTopicViewCell.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/17.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import "TLYTopicViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "TLYTopicItem.h"
#import "UIImage+Image.h"
#import "TLYTopicVideoView.h"
#import "TLYTopicPictureView.h"
#import "TLYTopicVoiceView.h"

@interface TLYTopicViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerimg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak,nonatomic) TLYTopicPictureView *pictureView;
@property (weak,nonatomic) TLYTopicVideoView *voidView;
@property (weak,nonatomic) TLYTopicVoiceView *voiceView;
@end


@implementation TLYTopicViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}


/**
 懒加载图片xib
 */
-(TLYTopicPictureView *)pictureView{
    if(_pictureView==nil){
       TLYTopicPictureView *picView = [TLYTopicPictureView tly_viewFromNib];
        _pictureView= picView;
        [self.contentView addSubview:_pictureView];
    }
    return _pictureView;
}





/**
 懒加载视频xib
 */
-(TLYTopicVideoView *)voidView{

    if(_voidView == nil){
        TLYTopicVideoView *voidView = [TLYTopicVideoView tly_viewFromNib];
        _voidView = voidView;
        [self.contentView addSubview:_voidView];
    }
    return _voidView;
}
/**
 懒加载声音xib
 */
-(TLYTopicVoiceView *)voiceView{
    if(_voiceView == nil){
        TLYTopicVoiceView *voiceView = [TLYTopicVoiceView tly_viewFromNib];
        _voiceView = voiceView;
        [self.contentView addSubview:_voiceView];
    }
    return _voiceView;
}



-(void)layoutSubviews{
    [super layoutSubviews];
    
    if(self.item.type == TLYTopicTypePicture){
     self.pictureView.frame =self.item.middleFrame;
    }else if(self.item.type == TLYTopicTypeVoice){
    self.voiceView.frame = self.item.middleFrame;
    }else if(self.item.type == TLYTopicTypeVideo){
         self.voidView.frame = self.item.middleFrame;
    }
    
   
    
   
}

-(void)setFrame:(CGRect)frame{
    frame.size.height-=10;
    [super setFrame:frame];
}

-(void)setItem:(TLYTopicItem *)item{
    _item = item;
    
    NSURL *url = [NSURL URLWithString:item.profile_image];
    
    self.nameLabel.text = item.name;
    self.timeLable.text = item.passtime;
    self.contentLable.text = item.text;
    [self.headerimg sd_setImageWithURL:url];
    
    [self.headerimg sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
      self.headerimg.image = [image cicrleImage];
    }];
    
    
    if(item.type == TLYTopicTypePicture){//图片
        self.pictureView.hidden =NO;
        self.voidView.hidden =YES;
        self.voiceView.hidden =YES;
         self.pictureView.item = _item;
    }else if(item.type == TLYTopicTypeVideo){//视频
        self.voidView.hidden =NO;
        self.pictureView.hidden =YES;
        self.voiceView.hidden =YES;
        self.voidView.item = _item;
    }else if(item.type == TLYTopicTypeVoice){//声音
        self.pictureView.hidden =YES;
        self.voidView.hidden =YES;
        self.voiceView.hidden =NO;
        self.voiceView.item = _item;
    }else if(item.type == TLYTopicTypeWord){//段子
        self.pictureView.hidden =YES;
        self.voidView.hidden =YES;
        self.voiceView.hidden =YES;
    }
    
    
    
}

@end
