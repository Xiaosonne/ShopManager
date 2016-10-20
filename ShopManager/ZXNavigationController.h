//
//  ZXNavigationController.h
//  ShopManager
//
//  Created by 鑫 赵 on 16/3/29.
//  Copyright © 2016年 zx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXNavigationController : UINavigationController
-(instancetype) initWithTitle:(NSString*) title andBarName:(NSString*) barname andRootViewController:(UIViewController*) controller;
@end
