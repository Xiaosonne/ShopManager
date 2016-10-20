//
//  ShopViewModel.h
//  ShopManager
//
//  Created by 鑫 赵 on 16/4/6.
//  Copyright © 2016年 zx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#import "NSString+Extension.h"
@class ShopModel;

#define fontWithSize(size) [UIFont systemFontOfSize:size]
#define size(w,h) CGSizeMake(w,h)
#define rect(x,y,size) CGRectMake(x,y,size.width,size.height)
//根据字段字符长度与高度
#define viewSize(name,fsize,w) [name measureTextWithFont:fontWithSize(fsize) inSize:size(w, MAXFLOAT)];
//算出frame在水平方向最大值
#define viewRight(frame) (frame.size.width+frame.origin.x)
//算出frame在垂直方向最大值
#define viewBottom(frame) (frame.size.height+frame.origin.y)


static float shopNameFontSize=20;
static float shopOwnerFontSize=15;
static float shopAddrFontSize=15;
static float shopNumFontSize=15;

static float shopNameWidth=150;
static float shopNumWidth=80;
static float shopPhoneWidth=120;
static float shopAddrWidth=320;
static float shopOwnerWidth=50;

@interface ShopViewModel : NSObject
@property(nonatomic,assign) CGRect shopNameFrame;
@property(nonatomic,assign) CGRect shopOwnerNameFrame;
@property(nonatomic,assign) CGRect shopAddressFrame;
@property(nonatomic,assign) CGRect shopNumberFrame;
@property(nonatomic,strong) ShopModel* shopView;
-(float) rowHeight;
@end
