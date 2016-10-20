//
//  ShopModel.h
//  ShopManager
//
//  Created by 鑫 赵 on 16/4/6.
//  Copyright © 2016年 zx. All rights reserved.
//

#import "ZXEntity.h"

@interface ShopModel:ZXEntity
@property(nonatomic,strong) NSString* shopName;
@property(nonatomic,strong) NSString* shopOwnerName;
@property(nonatomic,strong) NSString* shopAddress;
@property(nonatomic,strong) NSString* shopNumber;
@property(nonatomic,strong) NSString* shopPhone;
@property(nonatomic,strong) NSString* shopCity;
@property(nonatomic,strong) NSString* shopDistrict;
@property(nonatomic,strong) NSString* shopMarket;
@property(nonatomic,strong) NSString* shopFloor;
@property(nonatomic,strong) NSString* passWord;
@end