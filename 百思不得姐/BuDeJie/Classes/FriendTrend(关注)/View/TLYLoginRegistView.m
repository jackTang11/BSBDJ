//
//  TLYLoginRegistView.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/12.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import "TLYLoginRegistView.h"

@interface TLYLoginRegistView()


@property (weak, nonatomic) IBOutlet UIButton *loginReginBtn;

@end

@implementation TLYLoginRegistView

+(instancetype)loginView{
    
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil
                                         options:nil]firstObject];

}


+(instancetype)registView{

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];

}



-(void)awakeFromNib{
    [super awakeFromNib];
    UIImage *image = self.loginReginBtn.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
    [self.loginReginBtn setBackgroundImage:image forState:UIControlStateNormal];
    

}

@end
