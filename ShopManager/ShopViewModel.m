//
//  ShopViewModel.m
//  ShopManager
//
//  Created by 鑫 赵 on 16/4/6.
//  Copyright © 2016年 zx. All rights reserved.
//

#import "ShopViewModel.h"
#import "ShopModel.h"
@implementation ShopViewModel
-(float) rowHeight
{
    float height=0;
    if(_shopView!=nil){
        height=viewBottom(self.shopAddressFrame)+10;
    }
    //NSLog(@"get row  height %@",height);
    return  height;
}
-(void) setShopView:(ShopModel *)sv
{
    //if(_shopView==nil){
    _shopView=sv;
    NSInteger marginTop=10;
    NSInteger marginLeft=10;
    NSInteger rowMargin=5;
    
    
    CGSize shopnameSize= viewSize(_shopView.shopName, shopNameFontSize, shopNameWidth);
    shopnameSize.width=shopNameWidth;
    self.shopNameFrame=rect(marginLeft, marginTop, shopnameSize);
    
    CGSize shopnumerbSize=viewSize(_shopView.shopNumber, shopNumFontSize, shopNumWidth);
    float shopNumTop=(self.shopNameFrame.size.height-shopnumerbSize.height)/2+marginTop;
    self.shopNumberFrame=rect(viewRight(self.shopNameFrame)+5,shopNumTop, shopnumerbSize);
    
    CGSize shopOwnerSize=viewSize(_shopView.shopOwnerName, shopOwnerFontSize, shopOwnerWidth);
    self.shopOwnerNameFrame=rect(marginLeft, viewBottom(self.shopNameFrame)+rowMargin, shopOwnerSize);
    
    CGSize shopaddressSize=viewSize(_shopView.shopAddress, shopAddrFontSize, shopAddrWidth);
    self.shopAddressFrame=rect(marginLeft, viewBottom(self.shopOwnerNameFrame)+rowMargin, shopaddressSize);
    //}
}
@end