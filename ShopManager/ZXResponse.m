//
//  ZXResponse.m
//  ShopManager
//
//  Created by 鑫 赵 on 16/4/7.
//  Copyright © 2016年 zx. All rights reserved.
//

#import "ZXResponse.h"

@implementation ZXResponse
-(instancetype) initWithDic:(NSDictionary*) dic
{
    if(self=[super init])
    {
        self.success=[dic objectForKey:@"success"];
        self.error=[dic objectForKey:@"error"];
    }
    return self;
}
@end
