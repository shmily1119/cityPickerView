//
//  cityModel.m
//  secondaryPickerView
//
//  Created by xiayong on 16/8/5.
//  Copyright © 2016年 bianguo. All rights reserved.
//

#import "cityModel.h"

@implementation cityModel

- (instancetype)initWithDictionary:(NSDictionary* )dictionary
{
    if (self= [super init]) {
        self._name = dictionary[@"_name"];
        self.district = dictionary[@"district"];
    }
    return self;
    
}

@end
