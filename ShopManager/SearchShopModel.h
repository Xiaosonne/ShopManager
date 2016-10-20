//
//  SearchShopModel.h
//  ShopManager
//
//  Created by 鑫 赵 on 16/4/6.
//  Copyright © 2016年 zx. All rights reserved.
//


#import "ZXEntity.h"

@interface SearchShopModel:ZXEntity
@property (nonatomic,strong) NSString * _Nonnull username;
@property (nonatomic,strong) NSString * _Nonnull password;
@property (nonatomic,assign) int pagecount;
@property (nonatomic,strong) NSString * _Nonnull min;
@property (nonatomic,strong) NSString * _Nonnull max;
@property (nonatomic,strong) NSString * _Nonnull kw;
@property (nonatomic,strong) NSString * _Nonnull authType;
@end