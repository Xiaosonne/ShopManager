//
//  ZXNewShopViewController.m
//  ShopManager
//
//  Created by 鑫 赵 on 16/3/28.
//  Copyright © 2016年 zx. All rights reserved.
//

#import "ZXNewShopViewController.h"
#import "ShopModel.h"
#import "ZXNetwork.h"
#import <Foundation/Foundation.h>
#import "ZXResponse.h"
#import "SearchShopModel.h"
#import "AppDelegate.h"
@interface ZXNewShopViewController ()<ZXNetworkDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView1;
@property (weak, nonatomic) IBOutlet UITextField *txtShopNum;
@property (weak, nonatomic) IBOutlet UITextField *txtShopName;
@property (weak, nonatomic) IBOutlet UITextField *txtShopOwnerName;
@property (weak, nonatomic) IBOutlet UITextField *txtShopPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtShopAddr;
@property (weak, nonatomic) IBOutlet UITextField *txtShopMarket;
@property (weak, nonatomic) IBOutlet UITextField *txtShopDistrict;
@property (weak, nonatomic) IBOutlet UITextField *txtShopFloor;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (nonatomic,assign) NSString* lastValue;
@property (nonatomic,strong) ZXNetwork* netrequest;
@end

@implementation ZXNewShopViewController 
-(void) setShopModel:(ShopModel *)shopModel
{
    _shopModel=shopModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.netrequest=[[ZXNetwork alloc] init];
    self.netrequest.delegate=self;
    if (self.shopModel!=nil) {
        
       
    }else {
        self.shopModel=[[ShopModel alloc] init];
    }
    self.lastValue=@"";
    [self uiSetShopModel];
    switch (self.procType) {
        case ZXProcTypeModify:
            {
                self.title=@"修改信息";
            }
            break;
        case ZXProcTypeCreateNew:
            {
                self.navigationItem.title=@"添加店铺";
            }
            break;
    }
}
//-(void) viewDidAppear:(BOOL)animated
//{
//    [self fitViewUnderNavAnimated:YES];
//}

-(void) uiSetShopModel
{
    self.txtShopNum.text=self.shopModel.shopNumber;
    self.txtShopOwnerName.text=self.shopModel.shopOwnerName;
    self.txtShopAddr.text=self.shopModel.shopAddress;
    self.txtShopName.text=self.shopModel.shopName;
    self.txtShopPhone.text=self.shopModel.shopPhone;
    self.txtShopFloor.text=self.shopModel.shopFloor;
    self.txtShopMarket.text=self.shopModel.shopMarket;
    self.txtShopAddr.text=self.shopModel.shopCity;
    self.txtShopDistrict.text=self.shopModel.shopDistrict;
    self.txtPassword.text=self.shopModel.passWord;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [ _txtShopNum  resignFirstResponder ];
    [ _txtShopName  resignFirstResponder ];
    [ _txtShopOwnerName  resignFirstResponder ];
    [ _txtShopPhone  resignFirstResponder ];
    [ _txtShopAddr  resignFirstResponder ];
    [ _txtShopMarket  resignFirstResponder ];
    [ _txtShopDistrict  resignFirstResponder ];
    [ _txtShopFloor  resignFirstResponder ];
    [_txtPassword resignFirstResponder];
}
- (IBAction)txtShopNumEnd:(UITextField *)sender
{
    
    if(self.procType==ZXProcTypeCreateNew){
        //此次查询的店铺号和上一次的一样
        if([self.lastValue isEqualToString:sender.text]==true)
        {
            
        }else
        {
            self.lastValue=sender.text;
            SearchShopModel * ssm=[[SearchShopModel alloc] init];
            ssm.username=[AppDelegate authInfoGetUsername];
            ssm.password=[AppDelegate authInfoGetPassword];
            ssm.pagecount=0;
            ssm.min=sender.text;
            ssm.max=sender.text; 
            [self.netrequest requestPostFormUrlEncoded:[ssm toPostData] forUrlStr:apiUrl requestType:ZXGetShopInfo object:nil];
            
        }
    }
    
}

-(void)networkGetResultData:(NSData *  _Nullable) data Response:(NSURLResponse * _Nullable) response Error:( NSError * _Nullable) error{
    NSError *err;
    NSArray *dic = [NSJSONSerialization
                    JSONObjectWithData:data
                    options:NSJSONReadingMutableContainers
                    error:&err];
    if(dic.count==0){
        {
            dispatch_block_t b=^{
                self.shopModel=[[ShopModel alloc] init];
                [self showMessage:@"没有获取到店铺信息" withTitle:@"消息" handler:nil];
                [self uiSetShopModel];
            };
            dispatch_sync(dispatch_get_main_queue(), b);
        }
        return;
    }
    NSDictionary* key=[dic objectAtIndex:0];
    self.shopModel=[[ShopModel alloc] init];
    for (NSString* k in [key keyEnumerator])
    {
        [ self.shopModel setValue:[key valueForKey:k] forKey:k];
    }
    {
        dispatch_block_t b=^{ 
            [self uiSetShopModel];
        };
        dispatch_sync(dispatch_get_main_queue(), b);
    }
   
}
-(void)networkUpdateResult:(NSData *  _Nullable) data Response:(NSURLResponse * _Nullable) response Error:( NSError * _Nullable) error  object:(id _Nullable ) param{
    NSError * err;
    NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
    if(dic!=nil){
        ZXResponse * resp=[[ZXResponse alloc]  initWithDic:dic];
        if([resp.success isEqualToString:@"true"]==YES){
            [self showMessage:[NSString stringWithFormat:@"更新成功,%@",resp.error] withTitle:@"消息" handler:nil];
        }else {
           [self showMessage:[NSString stringWithFormat:@"更新失败,%@",resp.error] withTitle:@"消息" handler:nil];
        }
    }
}
- (IBAction)btnOkClick:(UIButton *)sender
{
    bool change=false;
    if([self.shopModel.shopNumber isEqualToString: self.txtShopNum.text]==false){
        change=true;
        self.shopModel.shopNumber=self.txtShopNum.text;
    }
    if([self.shopModel.shopOwnerName isEqualToString: self.txtShopOwnerName.text]==false){
        change=true;
        self.shopModel.shopOwnerName=self.txtShopOwnerName.text;
    }
    if([self.shopModel.shopName isEqualToString: self.txtShopName.text]==false){
        change=true;
        self.shopModel.shopName=self.txtShopName.text;
    }
    if([self.shopModel.shopPhone isEqualToString: self.txtShopPhone.text]==false){
        change=true;
        self.shopModel.shopPhone=self.txtShopPhone.text;
    }
    if([self.shopModel.shopFloor isEqualToString: self.txtShopFloor.text]==false){
        change=true;
        self.shopModel.shopFloor=self.txtShopFloor.text;
    }
    if([self.shopModel.shopMarket isEqualToString: self.txtShopMarket.text]==false){
        change=true;
        self.shopModel.shopMarket=self.txtShopMarket.text;
    }
    if([self.shopModel.shopCity isEqualToString: self.txtShopAddr.text]==false){
        change=true;
        self.shopModel.shopCity=self.txtShopAddr.text;
    }
    if([self.shopModel.shopDistrict isEqualToString: self.txtShopDistrict.text]==false){
        change=true;
        self.shopModel.shopDistrict=self.txtShopDistrict.text;
    }
    self.shopModel.shopAddress=[NSString stringWithFormat:@"%@%@%@%@",_shopModel.shopCity,_shopModel.shopDistrict,_shopModel.shopMarket,_shopModel.shopFloor];
    if(change==false){
        [self showMessage:@"未修改任何信息" withTitle:@"消息" handler:nil];
        return;
    }
    switch (self.procType) {
        case ZXProcTypeModify:
            if ([self.delegate respondsToSelector:@selector(newShopControllerEndEditShopModel:atIndex:)])
            {
                [self.delegate newShopControllerEndEditShopModel:self.shopModel atIndex:self.modelIndex];
            }
            break;
        case ZXProcTypeCreateNew:
            {
                [self.netrequest requestPostFormUrlEncoded:[self.shopModel toPostData] forUrlStr:apiUpdateUrl requestType:ZXUpdateShop object:nil];
            }
            break;
    }
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
