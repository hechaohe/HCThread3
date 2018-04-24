//
//  PThreadController.m
//  HCThread
//
//  Created by hc on 2018/4/20.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "PThreadController.h"
#import <pthread.h>
@interface PThreadController ()

@end

@implementation PThreadController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:0];
    btn.frame = CGRectMake(20, 100, 100, 30);
    [btn setTitle:@"pthread" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)btnAction {
    
//    把耗时操作放在子线程中，pthread的函数中执行
//    for (int i = 0; i < 50000; i ++) {
//        NSString *str = [NSString stringWithFormat:@"i = %d",i];
//        NSLog(str,nil);
//    }
    
    
    NSThread *thread = [NSThread currentThread];
    NSLog(@"主线程:%@",thread);
    
    pthread_t threadId;
    pthread_create(&threadId, NULL, ThreadFunc, NULL);
    
    
    self.view.backgroundColor = [UIColor brownColor];
}
void *ThreadFunc (void *pParam) {
    
   
    NSThread *thread = [NSThread currentThread];
    thread.name = @"我的线程";
    NSLog(@"子线程 %@",thread);
    
    for (int i = 0; i < 50000; i ++) {
        NSString *str = [NSString stringWithFormat:@"i = %d",i];
        NSLog(str,nil);
    }
    pthread_exit((void *)0);
    return NULL;
}






@end
