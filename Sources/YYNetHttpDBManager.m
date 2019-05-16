//
//  YYNetHttpDBManager.m
//  AFNetworking
//
//  Created by yanyu on 2019/5/16.
//

#import "YYNetHttpDBManager.h"
#import <CommonCrypto/CommonCrypto.h>
#define YYNetHttpLogTable @"YYNetHttpLogTable"

@implementation YYNetHttpDBManager

+ (YYNetHttpDBManager *)share {
    static YYNetHttpDBManager *_ds = nil;
    static dispatch_once_t pisPatch;
    dispatch_once(&pisPatch, ^{
        _ds = [[YYNetHttpDBManager alloc] initDBWithName:@"datastore.db"];
    });
    return _ds;
}


/**
 查询数据库是不有记录，如果有则返回

 @param itemKey key
 @return 返回缓存的数据
 */
- (id)aliveDataInDB:(NSString *)itemKey {
    NSString *key = [self md5:itemKey];
    YYDataStoreItem *item = [self getYTKKeyValueItemById:key fromTable:YYNetHttpLogTable];
    return item.itemObject;
}


/**
 保存数据

 @param object 数据
 @param itemKey key
 */
- (void)saveDataToTable:(id)object withItemKey:(NSString *)itemKey {
    NSString *key = [self md5:itemKey];
    [self deleteObjectById:key fromTable:YYNetHttpLogTable];
    [self createTableWithName:YYNetHttpLogTable];
    [self putObject:object withId:key intoTable:YYNetHttpLogTable];
}

- (NSString *)md5:(nullable NSString *)str {
    if (!str) return nil;
    
    const char *cStr = str.UTF8String;
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    NSMutableString *md5Str = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; ++i) {
        [md5Str appendFormat:@"%02x", result[i]];
    }
    return md5Str;
}
@end
