//
//  ZXNetwork.m
//  ShopManager
//
//  Created by 鑫 赵 on 16/4/5.
//  Copyright © 2016年 zx. All rights reserved.
//

#import "ZXNetwork.h"
#import <Foundation/NSURLSession.h>
@implementation ZXNetwork

//application/x-www-form-urlencoded
-(void) requestPostFormUrlEncoded:(NSString *)postData  forUrlStr:(NSString *)urlstr  requestType:(ZXRequestType) type object:(id _Nullable ) param{
    NSMutableURLRequest * req=[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlstr]];
    [req setHTTPMethod:@"POST"];
    NSString * contentType=@"application/x-www-form-urlencoded";
    [req addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [req addValue: @"*/*" forHTTPHeaderField:@"Accept"];
    [req addValue:@"IOS CLIENT" forHTTPHeaderField: @"User-Agent" ];
    NSMutableData * postBody =[[NSMutableData alloc] init];
    [postBody appendData:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    [req setHTTPBody:postBody];
    NSURLSession * session=  [NSURLSession  sharedSession ];
    NSURLSessionDataTask * task=  [session dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        switch (type) {
            case ZXGetShopInfo:
            case ZXAuthInfo:
                if ([self.delegate respondsToSelector:@selector(networkGetResultData:Response:Error:)])
                {
                    [self.delegate networkGetResultData:data Response:response Error:error];
                }
                break;
            case ZXUpdateShop:
                if ([self.delegate respondsToSelector:@selector(networkUpdateResult:Response:Error:object:)])
                {
                    [self.delegate networkUpdateResult:data Response:response Error:error object:param];
                }
                break;
            default:
                break;
        }
       
    }];
    [task resume];
}
-(void) requestPostData:(NSDictionary*) postData andData:(NSData*) filedata forUrlStr:(NSString*) urlstr
{
    NSString* dataFileName=@"filename";
    NSMutableURLRequest * req=[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlstr]];
    [req setHTTPMethod:@"POST"];
    NSString * stringBoundary= [NSString stringWithFormat:@"0xKhTmLbOuNdArY"];
    NSString * contentType=[NSString stringWithFormat:@"multipart/form-data;boundry=%@", stringBoundary ];
    [req addValue:contentType   forHTTPHeaderField: @"Content-Type"];
    [req addValue:@"*/*"        forHTTPHeaderField:@"Accept"];
    [req addValue:@"IOS CLIENT" forHTTPHeaderField: @"User-Agent" ];
    //*******************   append post formdata body               *******************//
    
    NSMutableData * postBody =[[NSMutableData alloc] init];
    if(postData!=nil){
        NSEnumerator * keys= [postData keyEnumerator];
        for ( NSString*  key in keys) {
            
            NSData * p1= [[NSString stringWithFormat:@"Content-Disposition:form-data;name=\"%@\"\r\n",key]dataUsingEncoding:NSUTF8StringEncoding];
            NSData * data=[[NSString stringWithFormat:@"%@",[ postData objectForKey:key ]] dataUsingEncoding:NSUTF8StringEncoding];
            NSData* bodyBoundry = [[NSString stringWithFormat:@"\r\n%@\r\n", stringBoundary ] dataUsingEncoding:NSUTF8StringEncoding];
            [postBody appendData: p1];
            [postBody appendData:data];
            [postBody appendData:bodyBoundry];
        }
    } 
    if(filedata!=nil){
        NSData * p1= [[NSString stringWithFormat:@"Content-Disposition:form-data;name=\"%@\";filename=\"%@.jpg\";\r\nContent-Type:image/jpeg\r\n",dataFileName,dataFileName] dataUsingEncoding:NSUTF8StringEncoding];
        NSData* bodyBoundry = [[NSString stringWithFormat:@"\r\n%@\r\n", stringBoundary ] dataUsingEncoding:NSUTF8StringEncoding];
        [postBody appendData: p1];
        [postBody appendData:filedata];
        [postBody appendData:bodyBoundry];
    }
    [req setHTTPBody:postBody];
    
    //*******************    send post request    *******************//
    NSURLSession * session=  [NSURLSession  sharedSession ];
    NSURLSessionDataTask * task=  [session dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if ([self.delegate respondsToSelector:@selector(networkGetResultData:Response:Error:)])
        {
            [self.delegate networkGetResultData:data Response:response Error:error];
        }
    }];
    [task resume];
}
@end


