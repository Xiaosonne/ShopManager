//
//  NSString+Extension.m
//  ShopManager
//
//  Created by 鑫 赵 on 16/3/30.
//  Copyright © 2016年 zx. All rights reserved.
//

#import "NSString+Extension.h"
#import <UIKit/UIKit.h>
@implementation NSString(Extension)
-(CGSize)measureTextWithFont:( UIFont* ) font inSize:(CGSize) maxSize{
    NSDictionary * attr=@{NSFontAttributeName:font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}
@end
