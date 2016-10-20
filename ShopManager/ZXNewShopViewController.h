//
//  ZXNewShopViewController.h
//  ShopManager
//
//  Created by 鑫 赵 on 16/3/28.
//  Copyright © 2016年 zx. All rights reserved.
//
#import "ZXBaseViewController.h"
#import <UIKit/UIKit.h> 

@interface ZXNewShopViewController : ZXBaseViewController
@property (nonatomic,weak,nullable) id<ZXControllerClickOKDelegate> delegate;
@property(nonatomic,strong)  ShopModel  * _Nonnull  shopModel;
@property(nonatomic,assign) ZXProcType procType;
@property(nonatomic,assign) NSInteger modelIndex;
@end
