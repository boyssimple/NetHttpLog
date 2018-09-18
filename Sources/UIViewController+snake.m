//
//  UIViewController+snake.m
//  Test
//
//  Created by luowei on 2018/9/4.
//  Copyright © 2018年 luowei. All rights reserved.
//

#import "UIViewController+snake.h"
#import <objc/runtime.h>
#import "VCNetHTTPList.h"
#import "LogUtils.h"

@implementation UIViewController (snake)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL systemSel = @selector(viewWillAppear:);
        SEL swizzSel = @selector(swiz_viewWillAppear:);
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


- (void)swiz_viewWillAppear:(BOOL)animated{
    [self swiz_viewWillAppear:animated];
    NSString *name = self.navigationItem.title;
    if(!name){
        name = self.title;
    }
    if(!name){
        name = @"";
    }
    NSLog(@"当前控制器：%@ -- %@",self.class,name);
}

- (BOOL)canBecomeFirstResponder{
    return TRUE;
}


#pragma mark - 摇动

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    
    
    if (motion == UIEventSubtypeMotionShake) {
        
        NSLog(@"start shake");
        
    }
    
}



- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    
    
    NSLog(@"stop shake");
    [self openNetList];
}



- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    
    
    NSLog(@"cancel shake");
    
}

- (void)openNetList{
    
    UIViewController *vc = [LogUtils getCurrentVC];
    if(vc){
        VCNetHTTPList *netVC = [[VCNetHTTPList alloc]init];
        [vc presentViewController:[[UINavigationController alloc] initWithRootViewController:netVC] animated:TRUE completion:nil];
    }
}


@end
