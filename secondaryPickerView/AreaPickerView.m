//
//  AreaPickerView.m
//  secondaryPickerView
//
//  Created by xiayong on 16/8/5.
//  Copyright © 2016年 bianguo. All rights reserved.
//

#import "AreaPickerView.h"

@implementation AreaPickerView

-(void)layoutSubviews{

    self.cancelBtn.layer.borderWidth = 1;
    self.cancelBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.cancelBtn.layer.cornerRadius = 5;
    
    self.sureBtn.layer.borderWidth = 1;
    self.sureBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.sureBtn.layer.cornerRadius = 5;
    
}

@end
