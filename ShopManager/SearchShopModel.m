//
//  SearchShopModel.m
//  ShopManager
//
//  Created by 鑫 赵 on 16/4/6.
//  Copyright © 2016年 zx. All rights reserved.
//

#import "SearchShopModel.h"

@implementation SearchShopModel
-(instancetype) init
{
    if(self=[super init]){
        self.min=@"0";
        self.max=@"0";
        self.pagecount=@"0";
        self.username=@"-";
        self.password=@"-";
        self.kw=@"";
        self.authType=@"modify";
    }
    return self;
}
@end