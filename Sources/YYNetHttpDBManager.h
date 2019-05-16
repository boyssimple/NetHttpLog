//
//  YYNetHttpDBManager.h
//  AFNetworking
//
//  Created by yanyu on 2019/5/16.
//

#import <Foundation/Foundation.h>
#import <LWOCKit/LWOCKitConfig.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYNetHttpDBManager : YYDatastore 

+ (YYNetHttpDBManager *)share;

/**
 查询数据库是不有记录，如果有则返回
 
 @param itemKey key
 @return 返回缓存的数据
 */
- (id)aliveDataInDB:(NSString *)itemKey;

/**
 保存数据
 
 @param object 数据
 @param itemKey key
 */
- (void)saveDataToTable:(id)object withItemKey:(NSString *)itemKey;

@end

NS_ASSUME_NONNULL_END
