//
//  AreaPickerView.h
//  secondaryPickerView
//
//  Created by xiayong on 16/8/5.
//  Copyright © 2016年 bianguo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AreaPickerView : UIView

@property (nonatomic,strong)IBOutlet UILabel * mainLabel;
@property (nonatomic,strong)IBOutlet UIButton * cancelBtn;
@property (nonatomic,strong)IBOutlet UIButton * sureBtn;

//@property (nonatomic,strong)IBOutlet UIView * bgView;

@property (nonatomic,strong) IBOutlet UIPickerView * areaPickerView;

@end
