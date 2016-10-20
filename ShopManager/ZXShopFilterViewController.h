//
//  ZXShopFilterViewController.h
//  ShopManager
//
//  Created by 鑫 赵 on 16/4/6.
//  Copyright © 2016年 zx. All rights reserved.
//

#import "ZXBaseViewController.h" 
@class SearchShopModel;
@interface ZXShopFilterViewController : ZXBaseViewController
@property(nonatomic,weak) SearchShopModel* searchModel;
@property(nonatomic,weak) id<ZXControllerClickOKDelegate> delegate;
@end
