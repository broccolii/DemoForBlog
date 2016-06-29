//
//  ViewController.m
//  GCDDemo
//
//  Created by Broccoli on 16/6/27.
//  Copyright © 2016年 youzan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self foo];
}

- (void)foo {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        __block dispatch_semaphore_t sem = dispatch_semaphore_create(0);
        
        [self doSome:^(NSString *hello) {
            NSLog(@"time: %@ %@",[NSDate date], hello);
            dispatch_semaphore_signal(sem);
        }];
        
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
        
        NSLog(@"time:%@ done", [NSDate date]);
    });
}

- (void)doSome:(void (^)(NSString *hello))block {
    dispatch_sync(dispatch_queue_create([@"broccoliii" UTF8String], NULL), ^{
        sleep(3);
        block(@"hello");
    });
}
@end
