//
//  YYNetHttpLogConfig.h
//  AFNetworking
//
//  Created by yanyu on 2019/5/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYNetHttpLogConfig : NSObject

+ (YYNetHttpLogConfig *)share;
@property (nonatomic, assign) BOOL enabled; //是否开起日志
@end

NS_ASSUME_NONNULL_END
