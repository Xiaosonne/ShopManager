//
//  ZXBaseViewController.h
//  ShopManager
//
//  Created by 鑫 赵 on 16/3/28.
//  Copyright © 2016年 zx. All rights reserved.
//

#import <UIKit/UIKit.h> 

#if TARGET_IPHONE_SIMULATOR
    #define baseStr @"http://10.0.1.112:7777"
#else
    #define baseStr @"http://182.92.173.50:7778"
#endif

#define apiUrl         ([baseStr stringByAppendingString:@"/api/User/PostShopData"])
#define apiUpdateUrl    ([baseStr stringByAppendingString:@"/api/User/PostShopUpdate"])
#define apiAuthInfo     ([baseStr stringByAppendingString:@"/api/User/PostAuthInfo"])


typedef NS_ENUM(NSInteger,ZXProcType) {
    ZXProcTypeModify,
    ZXProcTypeCreateNew
};

typedef NS_ENUM(NSInteger,ZXControllerType) {
    ZXFilterController,
    ZXUpdateController
};

typedef void(^dispatch_block_t)(void );
typedef void(^non_args_non_ret_block)(void);
typedef void(^alert_callback)(UIAlertAction * _Nonnull );
@class ShopModel;

@interface ZXBaseViewController : UIViewController
-(void) createNavControllerWithName:(NSString * _Nonnull)name onTabBar:(UITabBarController * _Nonnull) bars;
-(void) fitViewUnderNavAnimated:(BOOL) ani;
-(void) showMessage:(NSString*  _Nonnull ) msg withTitle:(NSString* _Nonnull ) title handler:(_Nullable alert_callback) b;
@end

@protocol ZXControllerClickOKDelegate<NSObject>
-(void) newShopControllerEndEditShopModel:(ShopModel* _Nonnull) model atIndex:(NSInteger) index;
-(void) controllerClick:(id   _Nonnull )controller object:(_Nullable id) obj type:(ZXControllerType) intType;
@end

