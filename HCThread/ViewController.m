//
//  ViewController.m
//  HCThread
//
//  Created by hc on 2018/4/20.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "ViewController.h"

#import "PThreadController.h"
#import "NSThreadController.h"
#import "GCDController.h"
#import "OperationQueueController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

- (IBAction)pushToPThread:(UIButton *)sender {
    
    [self.navigationController pushViewController:[PThreadController new] animated:YES];
    
}

- (IBAction)pushToNSThread:(id)sender {
    [self.navigationController pushViewController:[NSThreadController new] animated:YES];
}

- (IBAction)pushToGCD:(id)sender {
    [self.navigationController pushViewController:[GCDController new] animated:YES];
}


- (IBAction)pushToOperation:(id)sender {
    [self.navigationController pushViewController:[OperationQueueController new] animated:YES];
}


@end
