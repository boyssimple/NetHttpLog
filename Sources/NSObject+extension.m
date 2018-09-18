//
//  NSObject+extension.m
//  Test
//
//  Created by luowei on 2018/9/3.
//  Copyright © 2018年 luowei. All rights reserved.
//

#import "NSObject+extension.h"
#import <objc/runtime.h>

@implementation NSObject (extension)

/* runtime获取model所有属性 */
- (NSArray*)getAllPropertyName
{
    NSMutableArray* nameArray = [NSMutableArray array];
    unsigned int count = 0;
    objc_property_t *property_t = class_copyPropertyList([self class], &count);
    for (int i=0; i<count; i++) {
        objc_property_t propert = property_t[i];
        const char * propertyName = property_getName(propert);
        [nameArray addObject:[NSString stringWithUTF8String:propertyName]];
    }
    free(property_t);
    return nameArray;
}

/* 获取对象的所有属性和属性内容 */
-(NSDictionary *)getAllPropertiesAndVaules
{
    NSMutableDictionary *propsDic = [NSMutableDictionary dictionary];
    unsigned int outCount;
    objc_property_t *properties =class_copyPropertyList([self class], &outCount);
    for ( int i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) {
            [propsDic setObject:propertyValue forKey:propertyName];
        }
    }
    free(properties);
    return propsDic;
}
@end
