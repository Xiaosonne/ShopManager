//
//  ZXTabBarViewController.m
//  ShopManager
//
//  Created by 鑫 赵 on 16/3/28.
//  Copyright © 2016年 zx. All rights reserved.
//

#import "ZXTabBarController.h"
#import "ZXNewShopViewController.h"
#import "ZXAuthViewController.h"
#import "ZXModifyInfoViewController.h"
#import "ZXPersonalInfoViewController.h"
#import "ZXNavigationController.h"
@interface ZXTabBarController ()

@end

@implementation ZXTabBarController

-(instancetype) init{
    if(self=[super init]){
        ZXPersonalInfoViewController* person=[[ZXPersonalInfoViewController alloc] init];
        ZXNewShopViewController* newshop= [[ZXNewShopViewController alloc] initWithNibName:@"NewShopView" bundle:nil];
        newshop.procType=ZXProcTypeCreateNew;
        ZXModifyInfoViewController* mod=[[ZXModifyInfoViewController alloc] init];
        mod.authType=@"modify";
          ZXModifyInfoViewController* modnotuse=[[ZXModifyInfoViewController alloc] init];
        modnotuse.authType=@"notuse";
        ZXNavigationController * nav1=[[ZXNavigationController alloc] initWithTitle:@"添加店铺" andBarName:@"新建" andRootViewController:newshop];
        [self addChildViewController:nav1];
        
        ZXNavigationController * nav2=[[ZXNavigationController alloc] initWithTitle:@"修改信息" andBarName:@"更新" andRootViewController:mod];
        [self addChildViewController:nav2];
        
        ZXNavigationController * nav4=[[ZXNavigationController alloc] initWithTitle:@"修改信息" andBarName:@"未使用" andRootViewController:modnotuse];
        [self addChildViewController:nav4];
        
        ZXNavigationController * nav3=[[ZXNavigationController alloc] initWithTitle:@"我的" andBarName:@"个人" andRootViewController:person];
        [self addChildViewController:nav3];
    }
    return  self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
-(BOOL) prefersStatusBarHidden{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
