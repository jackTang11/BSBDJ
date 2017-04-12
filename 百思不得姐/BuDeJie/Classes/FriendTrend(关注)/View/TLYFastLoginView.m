//
//  TLYFastLoginView.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/12.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import "TLYFastLoginView.h"

@implementation TLYFastLoginView


+(instancetype)loginView{

    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
@end
