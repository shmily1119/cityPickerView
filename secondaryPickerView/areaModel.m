//
//  areaModel.m
//  secondaryPickerView
//
//  Created by xiayong on 16/8/5.
//  Copyright © 2016年 bianguo. All rights reserved.
//

#import "areaModel.h"

@implementation areaModel
- (instancetype)initWithDictionary:(NSDictionary* )dictionary
{
    if (self= [super init]) {
        self._Areacode = dictionary[@"_Areacode"];
        self._name = dictionary[@"_name"];
    }
    return self;
    
}
@end
