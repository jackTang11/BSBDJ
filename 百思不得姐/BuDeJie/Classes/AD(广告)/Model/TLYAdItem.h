//
//  TLYAdItem.h
//  百思不得姐
//
//  Created by jack_tang on 17/4/11.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLYAdItem : NSObject
//跳转链接
@property (nonatomic,copy) NSString *ori_curl;
//广告地址
@property (nonatomic,copy) NSString *w_picurl;

@property (nonatomic,assign) CGFloat h;
@property (nonatomic,assign) CGFloat w;

@end
