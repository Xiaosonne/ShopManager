//
//  ShopCellView.h
//  ShopManager
//
//  Created by 鑫 赵 on 16/3/30.
//  Copyright © 2016年 zx. All rights reserved.
//

#import <UIKit/UIKit.h> 
@class ShopViewModel;
@interface ShopCellView : UITableViewCell
@property(nonatomic,strong) UILabel* lbShopName;
@property(nonatomic,strong) UILabel* lbShopNumber;
@property(nonatomic,strong) UILabel* lbShopOwnerName;
@property(nonatomic,strong) UILabel* lbShopAddress;
@property (nonatomic,strong) ShopViewModel* viewModel;
@end
