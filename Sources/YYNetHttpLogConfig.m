//
//  YYNetHttpLogConfig.m
//  AFNetworking
//
//  Created by yanyu on 2019/5/16.
//

#import "YYNetHttpLogConfig.h"

@implementation YYNetHttpLogConfig

+ (YYNetHttpLogConfig *)share
{
    static YYNetHttpLogConfig * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YYNetHttpLogConfig alloc] init];
    });
    
    return instance;
}
@end
