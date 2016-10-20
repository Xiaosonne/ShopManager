//
//  ZXResponse.h
//  ShopManager
//
//  Created by 鑫 赵 on 16/4/7.
//  Copyright © 2016年 zx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXResponse : NSObject
@property(nonatomic,strong) NSString* success;
@property(nonatomic,strong) NSString* error;
-(instancetype) initWithDic:(NSDictionary*) dic;
@end
