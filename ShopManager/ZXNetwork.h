//
//  ZXNetwork.h
//  ShopManager
//
//  Created by 鑫 赵 on 16/4/5.
//  Copyright © 2016年 zx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSData.h>
typedef NS_ENUM(NSInteger,ZXRequestType) {
    ZXUpdateShop,
    ZXGetShopInfo,
    ZXAuthInfo
};
@protocol ZXNetworkDelegate<NSObject>
-(void)networkGetResultData:(NSData *  _Nullable) data Response:(NSURLResponse * _Nullable) response Error:( NSError * _Nullable) error;
-(void)networkUpdateResult:(NSData *  _Nullable) data Response:(NSURLResponse * _Nullable) response Error:( NSError * _Nullable) error  object:(id _Nullable ) param;
@end

@interface ZXNetwork : NSObject
@property(nonatomic,weak,nullable) id<ZXNetworkDelegate> delegate;
-(void) requestPostData:(NSDictionary*  _Nonnull) postData andData:(NSData*  _Nonnull) data forUrlStr:(NSString*  _Nonnull) str ;
//application/x-www-form-urlencoded
-(void) requestPostFormUrlEncoded:(NSString * _Nonnull )postData  forUrlStr:(NSString *  _Nonnull)str requestType:(ZXRequestType) type object:(id _Nullable ) param;

@end
