//
//  ZXAuthViewController.m
//  ShopManager
//
//  Created by 鑫 赵 on 16/3/28.
//  Copyright © 2016年 zx. All rights reserved.
//

#import "ZXAuthViewController.h"
#import "ZXNetwork.h"
#import "ZXResponse.h"
#import "AppDelegate.h"
#import "ZXTabBarController.h"
@interface ZXAuthViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtusername;
@property (weak, nonatomic) IBOutlet UITextField *txtpassword;
@property (nonatomic,strong) ZXNetwork * netrequest;
@property (weak, nonatomic) IBOutlet UIButton *btnClickbutton;

@end

@implementation ZXAuthViewController
-(void)networkGetResultData:(NSData *  _Nullable) data Response:(NSURLResponse * _Nullable) response Error:( NSError * _Nullable) error{

    NSError * err;
    NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
    if(dic!=nil){
        ZXResponse * resp=[[ZXResponse alloc]  initWithDic:dic];
        if([resp.success isEqualToString:@"true"]==YES){
            alert_callback block=^(UIAlertAction * act){
                ZXTabBarController *tabbar=[[ZXTabBarController alloc] init];
                 self.modalPresentationStyle=UIModalPresentationOverFullScreen;
                 [self presentViewController:tabbar animated:YES completion:nil];
                //[self.navigationController pushViewController:tabbar animated:YES];
            };
            [AppDelegate authInfoSet:self.txtusername.text Password:self.txtpassword.text];
            [self showMessage:@"登录成功" withTitle:@"消息" handler:block];
        }else {
            alert_callback call=^(UIAlertAction * act)
            {
                self.btnClickbutton.enabled=YES;
            };
            [self showMessage:@"登录失败" withTitle:@"消息" handler:call];
        }
    }
   
}

-(void)networkUpdateResult:(NSData *  _Nullable) data Response:(NSURLResponse * _Nullable) response Error:( NSError * _Nullable) error  object:(id _Nullable ) param{
}
- (IBAction)btnLoginClick:(id)sender
{
    self.btnClickbutton.enabled=NO;
    [self.netrequest requestPostFormUrlEncoded:[NSString stringWithFormat:@"username=%@&password=%@",self.txtusername.text,self.txtpassword.text] forUrlStr:apiAuthInfo requestType:ZXAuthInfo object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.netrequest=[[ZXNetwork alloc] init];
    self.netrequest.delegate=self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
