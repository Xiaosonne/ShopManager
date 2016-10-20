//
//  ZXNavigationController.m
//  ShopManager
//
//  Created by 鑫 赵 on 16/3/29.
//  Copyright © 2016年 zx. All rights reserved.
//

#import "ZXNavigationController.h"

@interface ZXNavigationController ()

@end

@implementation ZXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view. 
}
-(instancetype) initWithTitle:(NSString*) title andBarName:(NSString*) barname andRootViewController:(UIViewController*) controller  {
    if(self=[super initWithRootViewController:controller]){
        UITabBarItem * item=[[UITabBarItem alloc] initWithTitle:barname image:nil tag:1];
        controller.title=title;
        self.tabBarItem=item;
        
    }
    return  self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL) prefersStatusBarHidden{
    return YES;
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
