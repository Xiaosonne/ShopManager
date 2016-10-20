//
//  ZXEntity.m
//  ShopManager
//
//  Created by 鑫 赵 on 16/4/6.
//  Copyright © 2016年 zx. All rights reserved.
//

#import "ZXEntity.h"

#import <objc/objc.h>
#import <objc/runtime.h>

#define LoadInitialDic(CLASS) [CLASS objDicInit] 

@implementation ZXEntity
static NSMutableDictionary * allPropertyCache;
+(void) objDicInit{
        NSString * className=NSStringFromClass([self class]);
        if(allPropertyCache==nil){
            allPropertyCache=[NSMutableDictionary dictionary];
        }
        NSMutableArray * arrtemp=[allPropertyCache objectForKey:className];
        if(arrtemp==nil){
            NSMutableArray* arr1=[[NSMutableArray alloc] init];
            Class c=[self class];
            u_int count=0;
            objc_objectptr_t * plist= (objc_objectptr_t *)class_copyPropertyList(c,&count);
            for (int i=0; i<count; i++) {
                const char * name=property_getName((objc_property_t)plist[i]);
                [arr1 addObject:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
            }
            [allPropertyCache setObject:arr1 forKey:className];
            arrtemp=arr1;
        }
}
-(NSString*) toPostData
{
    @try {
        NSMutableArray * arrtemp=[allPropertyCache objectForKey:NSStringFromClass([self class])];
        if(arrtemp==nil){
            LoadInitialDic([self class]);
            arrtemp=[allPropertyCache objectForKey:NSStringFromClass([self class])];
        }
        if(arrtemp!=nil)
        {
            NSMutableString* str=[[NSMutableString alloc] init];
            
            for (int i=0; i<arrtemp.count; i++) {
                NSString* key=[arrtemp objectAtIndex:i];
                id value=[self valueForKey:key];
                [str appendString:[NSString stringWithFormat:@"%@=%@&",key,value]];
            }
            return  [str substringToIndex:str.length-1];
        }
        return @"";
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
}
@end