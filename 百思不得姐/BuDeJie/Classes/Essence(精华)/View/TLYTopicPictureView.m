//
//  TLYTopicPictureView.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/18.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import "TLYTopicPictureView.h"
#import "TLYTopicItem.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "TLYSeeBigViewController.h"

@implementation TLYTopicPictureView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.autoresizingMask =NO;
    
    self.imageBg.userInteractionEnabled = YES;

    
    [self.imageBg addGestureRecognizer: [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeBigPicture)]];
    
}

-(void)seeBigPicture{
    
    TLYSeeBigViewController *see = [[TLYSeeBigViewController alloc]init];
    see.item = self.item;
    [self.window.rootViewController presentViewController:see animated:YES completion:nil];
}


-(void)setItem:(TLYTopicItem *)item{
    _item = item;
    
    self.gifBtn.hidden = !item.is_gif;
    
    
    [self.imageBg sd_setImageWithURL:[NSURL URLWithString:item.image1]];

    //处理长图
    if(item.isBigPicture){
        self.seeBigBtn.hidden =NO;
        self.imageBg.contentMode = UIViewContentModeTop;
         self.imageBg.clipsToBounds =YES;
        if(self.imageBg.image){//裁剪长途
            CGFloat imageW = item.middleFrame.size.width;
            CGFloat imageH = imageW*item.height/item.width;
        
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
            [self.imageBg.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.imageBg.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
    }else{
        self.seeBigBtn.hidden =YES;
        self.imageBg.contentMode = UIViewContentModeScaleToFill;
        self.imageBg.clipsToBounds =NO;
    }
    
    
    
    
}

@end
  
