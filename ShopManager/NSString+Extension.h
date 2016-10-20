//
//  NSString+Extension.h
//  ShopManager
//
//  Created by 鑫 赵 on 16/3/30.
//  Copyright © 2016年 zx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
@class UIFont;

@interface NSString(Extension)
-(CGSize) measureTextWithFont:( UIFont* ) font inSize:(CGSize) maxSize;
@end
