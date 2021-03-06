//
//  LogUtils.m
//  Test
//
//  Created by luowei on 2018/9/4.
//  Copyright © 2018年 luowei. All rights reserved.
//

#import "LogUtils.h"

@implementation LogUtils


+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    if([window subviews].count > 0){
        
        UIView *frontView = [[window subviews] objectAtIndex:0];
        id nextResponder = [frontView nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]])
            result = nextResponder;
        else
            result = window.rootViewController;
    }
    
    return result;
}


+ (NSString*)getVCName{
    UIViewController *vc = [LogUtils getCurrentVC];
    NSString *name;
    if([vc isKindOfClass:[UINavigationController class]]){
        UINavigationController *nav = (UINavigationController *)vc;
        if(nav){
            if(nav.viewControllers.count > 0){
                UIViewController *lvc = [nav.viewControllers lastObject];
                NSLog(@"----%@",NSStringFromClass(lvc.class));
                name = NSStringFromClass(lvc.class);
            }
        }
    }else{
        name = NSStringFromClass([vc class]);
    }
    return name;
}
@end
