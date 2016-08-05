//
//  provinceModel.h
//  secondaryPickerView
//
//  Created by xiayong on 16/8/5.
//  Copyright © 2016年 bianguo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface provinceModel : NSObject
- (instancetype)initWithDictionary:(NSDictionary* )dictionary;

@property (nonatomic,strong) NSString *_name;
@property (nonatomic,strong) NSArray * city;

@end
