//
//  provinceModel.m
//  secondaryPickerView
//
//  Created by xiayong on 16/8/5.
//  Copyright © 2016年 bianguo. All rights reserved.
//

#import "provinceModel.h"

@implementation provinceModel
- (instancetype)initWithDictionary:(NSDictionary* )dictionary
{
    if (self= [super init]) {
        self._name = dictionary[@"_name"];
        self.city = dictionary[@"city"];
    }
    return self;
    
}

@end
