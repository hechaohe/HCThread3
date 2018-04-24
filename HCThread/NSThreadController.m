//
//  NSThreadController.m
//  HCThread
//
//  Created by hc on 2018/4/20.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "NSThreadController.h"

@interface NSThreadController ()

@end

@implementation NSThreadController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:0];
    btn.frame = CGRectMake(20, 100, 100, 30);
    [btn setTitle:@"NSThread" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnAction1) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(method1:) object:@{@"key":@"value"}];
    [thread start];
    
//    NSThread *newThread = [[NSThread alloc] initWithTarget:self selector:@selector(test1) object:nil];
//    newThread.threadPriority = 1.0;
//    newThread.qualityOfService = NSQualityOfServiceUserInteractive;
//    [newThread start];
    
}

- (void)btnAction1 {
    
    NSThread *newThread = [[NSThread alloc] initWithTarget:self selector:@selector(test1) object:nil];
    newThread.threadPriority = 1.0;
    newThread.qualityOfService = NSQualityOfServiceUserInteractive;
    [newThread start];
    
    self.view.backgroundColor = [UIColor brownColor];
    
}

- (void)test1 {
    NSLog(@"%@",[NSThread currentThread]);
    
    for (int i = 0; i < 50000; i ++) {
        NSString *str = [NSString stringWithFormat:@"i = %d",i];
        NSLog(str,nil);
    }
    
   
}


- (void)method1:(NSDictionary *)str {
    NSThread *thread = [NSThread currentThread];
    NSLog(@"%@--%@",thread,str);
}





@end
