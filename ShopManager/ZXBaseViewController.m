//
//  ZXBaseViewController.m
//  ShopManager
//
//  Created by 鑫 赵 on 16/3/28.
//  Copyright © 2016年 zx. All rights reserved.
//

#import "ZXBaseViewController.h"

typedef void(^blockFit)(void);
@interface ZXBaseViewController ()

@end

@implementation ZXBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void) createNavControllerWithName:(NSString *)name onTabBar:(UITabBarController*) bars
{
    UINavigationController * nav=[[UINavigationController alloc] initWithRootViewController:self];
    nav.tabBarItem.title=name;
    [bars addChildViewController:nav];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) showMessage:(NSString *) msg withTitle :(NSString *)title handler:(_Nullable alert_callback) b;{
    dispatch_block_t block=^{
        UIAlertController * alert= [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * act=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:b];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    };
    dispatch_async(dispatch_get_main_queue(), block);
    
}
-(void) fitViewUnderNavAnimated:(BOOL) ani{
    blockFit block=^(void){
        CGRect sel=self.view.frame;
        self.view.frame=CGRectMake(0, sel.origin.y+64, sel.size.width, sel.size.height);
    };
    if(ani){
        [UIView animateWithDuration:0.1 animations:block];
    }else {
        block();
    }
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
