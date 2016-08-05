//
//  ViewController.m
//  secondaryPickerView
//
//  Created by xiayong on 16/8/5.
//  Copyright © 2016年 bianguo. All rights reserved.
//

#import "ViewController.h"
#import <UIKit+AFNetworking.h>
#import <XMLDictionary.h>

#import "provinceModel.h"
#import "cityModel.h"
#import "areaModel.h"
#import "AreaPickerView.h"

@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong) NSMutableArray *provinceArray;
@property (nonatomic,strong) NSMutableArray *cityArray;
@property (nonatomic,strong) NSMutableArray *areaArray;

//@property (nonatomic,strong) IBOutlet UIPickerView * pickerView;

@property (nonatomic,strong) AreaPickerView * myPickerView;

@property (nonatomic,strong) IBOutlet UILabel * areaLabel;
@property (nonatomic,strong) NSString * mainStr;//记录当前选择的编码
@property (nonatomic,strong) NSString * area;//记录当前地区
@property (nonatomic,strong) NSString * province;
@property (nonatomic,strong) NSString * city;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _provinceArray = [NSMutableArray array];
    _cityArray = [NSMutableArray array];
    _areaArray = [NSMutableArray array];
   
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPRequestSerializer * requestSerializer = [AFHTTPRequestSerializer serializer];
    AFHTTPResponseSerializer * responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/javascript",@"application/xml", nil];
    manager.responseSerializer = responseSerializer;
    manager.requestSerializer = requestSerializer;
    [manager GET:@"http://www.56page.com:9080/v2016/js/areaDataXml.xml" parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData * data = (NSData *)responseObject;
        NSString *test=  [NSString stringWithCString:[data bytes] encoding:NSUTF8StringEncoding];
        //        NSDictionary *dic =[NSDictionary dictionarywithString:test];
        NSDictionary * dic = [NSDictionary dictionaryWithXMLString:test];
        for (NSDictionary * dic1 in dic[@"province"]) {
            provinceModel * model = [[provinceModel alloc] initWithDictionary:dic1];
            [_provinceArray addObject:model];
        }
        [self.myPickerView.areaPickerView reloadAllComponents];
        NSLog(@"test:%@",dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];

}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component==0) {
        return _provinceArray.count;
    }else if (component==1){
        return _cityArray.count;
    }else{
        return _areaArray.count;
    }
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED{
    if (component==0) {
        provinceModel * model = _provinceArray[row];
        return model._name;
    }else if(component==1){
        cityModel * model = _cityArray[row];
        return model._name;
    }else{
        areaModel * model = _areaArray[row];
        return model._name;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED{
    if (component==0) {
        provinceModel * model = _provinceArray[row];
        [_cityArray removeAllObjects];
        [_areaArray removeAllObjects];
        for (NSDictionary * dic2 in model.city) {
            cityModel * model1 = [[cityModel alloc] initWithDictionary:dic2];
            [_cityArray addObject:model1];
        }
        _province = model._name;
        [self.myPickerView.areaPickerView reloadAllComponents];
    }else if(component==1){
        cityModel * model = _cityArray[row];
        //        for (NSDictionary * dic3 in model.district) {
        //            areaModel * model1 = [[areaModel alloc] initWithDictionary:dic3];
        //            [_areaArray addObject:model1];
        //        }
        //        areaModel * model1 = [[areaModel alloc] initWithDictionary:model.district];
        //        [self.pickerView reloadComponent:2];
        [_areaArray removeAllObjects];
        if ([model.district isKindOfClass:[NSDictionary class]]) {
            areaModel * model1 = [[areaModel alloc] initWithDictionary:model.district];
            [_areaArray addObject:model1];
        }else{
            for (NSDictionary * dic3 in model.district) {
            areaModel * model1 = [[areaModel alloc] initWithDictionary:dic3];
                            [_areaArray addObject:model1];
            }
        }
        _city = model._name;
        [self.myPickerView.areaPickerView reloadAllComponents];
    }else{
                areaModel * model = _areaArray[row];
        _mainStr = model._Areacode;
        _area = model._name;
        NSLog(@"编码-%@",model._Areacode);
    }
}

-(IBAction)chooseAreaBtn:(id)sender{
    _myPickerView = [[[NSBundle mainBundle] loadNibNamed:@"AreaPickerView" owner:nil options:nil] firstObject];
    _myPickerView.frame = self.view.frame;
    _myPickerView.areaPickerView.delegate = self;
    _myPickerView.areaPickerView.dataSource = self;
    [self.view addSubview:_myPickerView];
    [_myPickerView.cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_myPickerView.sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    

}
-(void)cancelBtnClick:(UIButton *)sender{
    [_myPickerView removeFromSuperview];
}
-(void)sureBtnClick:(UIButton *)sender{
    _areaLabel.text = [NSString stringWithFormat:@"当前地区：%@-%@-%@-%@",_province,_city,_area,_mainStr];
    [_myPickerView removeFromSuperview];
}

@end
