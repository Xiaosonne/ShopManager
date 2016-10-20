//
//  ZXShopFilterViewController.m
//  ShopManager
//
//  Created by 鑫 赵 on 16/4/6.
//  Copyright © 2016年 zx. All rights reserved.
//

#import "ZXShopFilterViewController.h"
#import "SearchShopModel.h"
@interface ZXShopFilterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtStartNum;
@property (weak, nonatomic) IBOutlet UITextField *txtEndNum;
@property (weak, nonatomic) IBOutlet UITextField *txtKeywords;
@property (weak, nonatomic) IBOutlet UIButton *txtBtnOk;

@end

@implementation ZXShopFilterViewController

-(instancetype) init{
    if (self=[super initWithNibName:@"ShopFilterView" bundle:nil] )
    {
        
    }
    return  self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"店铺搜索";
    self.txtEndNum.text=self.searchModel.min;
    self.txtStartNum.text=self.searchModel.max;
    self.txtKeywords.text=self.searchModel.kw;
    
}
//-(void) viewDidAppear:(BOOL)animated {
//    [self fitViewUnderNavAnimated:YES];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnOKClick:(id)sender
{
    self.searchModel.min=self.txtStartNum.text;
    self.searchModel.max=self.txtEndNum.text;
    self.searchModel.kw=self.txtKeywords.text;
    if ([self.delegate respondsToSelector:@selector(controllerClick:object:type:)]) {
        [self.delegate controllerClick:self object:self.searchModel type:ZXFilterController];
    }
}
-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_txtEndNum resignFirstResponder];
    [_txtKeywords resignFirstResponder];
    [_txtStartNum resignFirstResponder];
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
