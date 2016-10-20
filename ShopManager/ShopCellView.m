//
//  ShopCellView.m
//  ShopManager
//
//  Created by 鑫 赵 on 16/3/30.
//  Copyright © 2016年 zx. All rights reserved.
//
#import "ShopModel.h"
#import "ShopViewModel.h"
#import "ShopCellView.h"
@interface ShopCellView()
@property(nonatomic) BOOL isViewInitial;
@property(nonatomic) CGSize calcSize;
@end

@implementation ShopCellView
-(void) setViewModel:(ShopViewModel *)sv
{
    _viewModel=sv;
    ShopModel * v=sv.shopView;
    self.lbShopName.frame=sv.shopNameFrame;
    self.lbShopName.text=v.shopName;
    self.lbShopName.font=[UIFont systemFontOfSize:shopNameFontSize];
    
    self.lbShopAddress.frame=sv.shopAddressFrame;
    self.lbShopAddress.text=v.shopAddress;
    self.lbShopAddress.font=[UIFont systemFontOfSize:shopAddrFontSize];
    //
    self.lbShopNumber.frame=sv.shopNumberFrame;
    self.lbShopNumber.text=v.shopNumber;
     self.lbShopNumber.font=[UIFont systemFontOfSize:shopNumFontSize];
    
    self.lbShopOwnerName.frame=sv.shopOwnerNameFrame;
    self.lbShopOwnerName.text=v.shopOwnerName;
     self.lbShopOwnerName.font=[UIFont systemFontOfSize:shopOwnerFontSize];
}
-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.lbShopName=[[UILabel alloc] init];
        self.lbShopName.numberOfLines=0;
        [self addSubview:self.lbShopName];
        
        self.lbShopNumber=[[UILabel alloc] init];
        self.lbShopNumber.numberOfLines=0;
        [self addSubview:self.lbShopNumber];
        
        self.lbShopOwnerName=[[UILabel alloc] init];
        self.lbShopOwnerName.numberOfLines=0;
        [self addSubview:self.lbShopOwnerName];
        
        self.lbShopAddress=[[UILabel alloc] init];
        self.lbShopAddress.numberOfLines=0;
        [self addSubview:self.lbShopAddress];
        
    }
    return  self;
}
- (void)awakeFromNib {
    // Initialization code
}

 
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end