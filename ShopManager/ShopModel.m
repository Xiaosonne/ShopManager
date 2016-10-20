//
//  ShopModel.m
//  ShopManager
//
//  Created by 鑫 赵 on 16/4/6.
//  Copyright © 2016年 zx. All rights reserved.
//

#import "ShopModel.h"

@implementation ShopModel
-(instancetype) init{
    if(self=[super init]){
        self.shopAddress=@"";
        self.shopCity=@"";
        self.shopDistrict=@"";
        self.shopFloor=@"";
        self.shopName=@"";
        self.shopNumber=@"";
        self.shopOwnerName=@"";
        self.shopPhone=@"";
        self.shopMarket=@"";
    }
    return self;
}
@end
