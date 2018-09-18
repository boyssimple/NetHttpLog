//
//  AFURLSessionManager+extension.h
//  Test
//
//  Created by luowei on 2018/9/4.
//  Copyright © 2018年 luowei. All rights reserved.
//

#import <AFNetworking/AFURLSessionManager.h>

@interface AFURLSessionManager (extension)

@property (nonatomic, strong) void(^clickActionBlock)(NSURLResponse *response, id responseObject, NSError *error);
@end
