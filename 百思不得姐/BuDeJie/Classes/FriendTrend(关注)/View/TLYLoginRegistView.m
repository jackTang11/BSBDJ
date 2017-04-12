//
//  TLYLoginRegistView.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/12.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import "TLYLoginRegistView.h"

@implementation TLYLoginRegistView

+(instancetype)loginView{
    
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil
                                         options:nil]firstObject];

}


+(instancetype)registView{

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];

}




@end
