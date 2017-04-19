//
//  TLYTopicItem.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/17.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import "TLYTopicItem.h"

@implementation TLYTopicItem


-(CGFloat)cellHeight{

    if(_cellHeight) return _cellHeight;
    
    _cellHeight+=55;
    
    NSString *text =self.text;
    CGSize textsize= CGSizeMake(TLYScreenW-TLYMargin*2, MAXFLOAT);
    CGRect rect =[text boundingRectWithSize:textsize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil];
    CGFloat height = rect.size.height+=TLYMargin*2;
     _cellHeight+=height;
    
    //计算图片的frame
    if(self.type !=TLYTopicTypeWord){
        CGFloat x = TLYMargin;
        CGFloat y = _cellHeight;
        CGFloat width = textsize.width;
        CGFloat height = width/self.width * self.height;
        //如果高度大于屏幕高度,说明是长图,设置为height=200
        if(height>=TLYScreenH){
            self.bigPicture = YES;
            height = 200;
        }else{
            self.bigPicture = NO;
        }
        CGRect rect =  CGRectMake(x, y, width, height);
        self.middleFrame = rect;
        _cellHeight+=height;
    }
    
    //加上底部间距和 UIview的高度
    _cellHeight+=35+20;
    
    return height;
}
@end
