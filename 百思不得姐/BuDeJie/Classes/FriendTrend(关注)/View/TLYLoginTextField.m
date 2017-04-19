//
//  TLYLoginTextField.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/13.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import "TLYLoginTextField.h"
#import "UITextField+Placeholder.h"

@implementation TLYLoginTextField

-(void)awakeFromNib{
    [super awakeFromNib];
    self.tintColor = [UIColor whiteColor];
    
    
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    self.placeholderColor =[UIColor lightGrayColor];

}



-(void)textBegin{
    self.placeholderColor =[UIColor whiteColor];
}


-(void)textEnd{
    self.placeholderColor =[UIColor lightGrayColor];
}


@end
