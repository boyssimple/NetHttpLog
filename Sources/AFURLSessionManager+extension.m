//
//  AFURLSessionManager+extension.m
//  Test
//
//  Created by luowei on 2018/9/4.
//  Copyright © 2018年 luowei. All rights reserved.
//

#import "AFURLSessionManager+extension.h"
#import <objc/runtime.h>
#import "NSObject+extension.h"
#import "LogUtils.h"
#import "SYUnicode.h"

@implementation AFURLSessionManager (extension)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL systemSel = @selector(dataTaskWithRequest:uploadProgress:downloadProgress:completionHandler:);
        SEL swizzSel = @selector(swiz_dataTaskWithRequest:uploadProgress:downloadProgress:completionHandler:);
        Method systemMethod = class_getInstanceMethod([self class], systemSel);
        Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
        
        BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
        if (isAdd) {
            class_replaceMethod(self, swizzSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
        }else{
            method_exchangeImplementations(systemMethod, swizzMethod);
        }
    });
}

- (void)setClickActionBlock:(void (^)(NSURLResponse *response, id responseObject, NSError *error))clickActionBlock{
    objc_setAssociatedObject(self, @"clickActionBlock", clickActionBlock, OBJC_ASSOCIATION_RETAIN);
}

- (void(^)(NSURLResponse *response, id responseObject, NSError *error))clickActionBlock{
    return (void(^)(NSURLResponse *response, id responseObject, NSError *error))objc_getAssociatedObject(self, @"clickActionBlock");
}

- (NSURLSessionDataTask *)swiz_dataTaskWithRequest:(NSURLRequest *)request
                                    uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgressBlock
                                  downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                                 completionHandler:(nullable void (^)(NSURLResponse *response, id _Nullable responseObject,  NSError * _Nullable error))completionHandler{
    NSLog(@"开始.....");
    NSDate *start = [NSDate date];
    NSString *clsName;
    id param;
    NSDictionary *dic = [request getAllPropertiesAndVaules];
    NSLog(@"%@",dic);
    if(dic){
        
        NSError *error;
        NSData *body = [dic objectForKey:@"HTTPBody"];
        if(body){
            
            param = [NSJSONSerialization JSONObjectWithData:body
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
        }
        if(!error){
            NSLog(@"%@",param);
            
        }else{
            if(body){
                
                NSString *receiveStr = [[NSString alloc]initWithData:body encoding:NSUTF8StringEncoding];
                if(receiveStr){
                    param = receiveStr;
                }
            }
            
            
        }
        clsName = [LogUtils getVCName];
    }
    
    self.clickActionBlock = ^(NSURLResponse *response, id responseObject, NSError *error) {
        
        if (completionHandler) {
            completionHandler(response,responseObject,error);
            NSLog(@"完成.....");
            NSString *result;
            if(error){
                result = error.localizedDescription;
            }else{
                result = responseObject;
            }
            
            
            NSURL *url = [dic objectForKey:@"URL"];
            CGFloat timeDistance = [[NSDate date] timeIntervalSinceDate:start];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
            
            NSDictionary *data = @{
                                   @"url":url.absoluteString,
                                   @"param":param?param:@"无",
                                   @"start":[formatter stringFromDate:start],
                                   @"end":[formatter stringFromDate:[NSDate date]],
                                   @"time":[NSString stringWithFormat:@"%.3fms",timeDistance],
                                   @"result":result
                                   };
            
            if(clsName){
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                NSArray *arr = [user objectForKey:clsName];
                
                if(arr){
                    NSMutableArray *newArr = [arr mutableCopy];
                    [newArr addObject:data];
                    [user setObject:newArr forKey:clsName];
                }else{
                    NSMutableArray *newArr = [NSMutableArray array];
                    [newArr addObject:data];
                    [user setObject:newArr forKey:clsName];
                }
                
                
                [user synchronize];
                NSString *str = [NSString stringWithFormat:@"请求地址:%@请求参数：%@开始时间：%@完成时间：%@使用时长：%.2fms",url,param,start,[NSDate date],timeDistance];
                NSLog(@"%@",str);
            }
            
        }
    };
    
    return [self swiz_dataTaskWithRequest:request uploadProgress:uploadProgressBlock downloadProgress:downloadProgressBlock completionHandler:self.clickActionBlock];
}

@end
