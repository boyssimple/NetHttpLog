//
//  LogUtils.h
//  Test
//
//  Created by luowei on 2018/9/4.
//  Copyright © 2018年 luowei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LogUtils : NSObject
+ (UIViewController *)getCurrentVC;
+ (NSString*)getVCName:(UIViewController*)vc;
+ (NSString*)getVCName;
@end
