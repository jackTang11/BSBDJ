//
//  TLYSubTagViewCell.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/11.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import "TLYSubTagViewCell.h"
#import "TLYSubTagItem.h"
#import <SDWebImage/UIImageView+WebCache.h>



@implementation TLYSubTagViewCell



-(void)setFrame:(CGRect)frame{
    frame.size.height-=1;
    [super setFrame:frame];
}




-(void)setTagItem:(TLYSubTagItem *)tagItem{
    _tagItem = tagItem;
    self.nameView.text = tagItem.theme_name;
    self.numView.text = tagItem.sub_number;
    
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:tagItem.image_list] placeholderImage:
     [UIImage imageNamed:@"defaultUserIcon"] options:SDWebImageLowPriority completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
         
         
         UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
         [path addClip];
        
         [image drawAtPoint:CGPointZero];
         
       image =  UIGraphicsGetImageFromCurrentImageContext();
         
         UIGraphicsEndImageContext();
         self.iconImage.image = image;
         
     }];
    
    
    NSInteger numer = tagItem.sub_number.integerValue;
    NSString *numStr = [NSString stringWithFormat:@"%@人订阅",tagItem.sub_number];
    if(numer>10000){
        CGFloat num = numer / 10000.0;
        numStr = [NSString stringWithFormat:@"%.1f万人订阅",num];
        numStr = [numStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    self.numView.text = numStr;
    

}

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.iconImage.layer.cornerRadius = self.iconImage.frame.size.width*0.5;
//    self.iconImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
