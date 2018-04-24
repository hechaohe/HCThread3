//
//  OperationQueueController.m
//  HCThread
//
//  Created by hc on 2018/4/20.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "OperationQueueController.h"

@interface OperationQueueController ()
@property (nonatomic,strong) UIImageView *imageView;


//- (void(^)(void))completionBlock;
//- (void)setCompletionBlock:(void(^)(void))block;

@end

@implementation OperationQueueController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    /*
    线程：操作系统提供的一种机制，允许多套指令在单个应用程序同事运行。
    进程：一个可执行的代码块，可以由多个线程组成
    */
    
    
    
//    NSBlockOperation
    
//    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(runInBackground) object:nil];
//    [operation start];
    
//    (1)使用NSBlockOperation执行一个操作
//    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//        //....
//    }];
//    [operation start];
    
//    (2)使用addExecutionBlock方法关联多个操作
    
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        //执行操作1
        NSLog(@"1");
    }];
    [operation addExecutionBlock:^{
        //执行操作2
        NSLog(@"2");
    }];
    [operation addExecutionBlock:^{
        //执行操作3
        NSLog(@"3");
    }];
    [operation start];
//    (1)单个NSOperation取消
    [operation cancel];
    
    
    
    
    
    
    
    /*
//    NSOperationQueue
     
//    一个NSOperation对象可以通过调用start方法来执行任务，默认是同步执行的。也可以将NSOperation添加到一个NSOperationQueue(操作队列)中去执行，而且是异步执行的。
    
//    1、创建一个操作队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    2、添加NSOperation到NSOperationQueue中
//    (1)添加一个NSOperation
    [queue addOperation:operation];
//    (2)添加一组NSOperation
//    [queue addOperations:operations waitUntilFinished:NO];
//    (3)添加一个block形式的Operation
    [queue addOperationWithBlock:^{
        //执行一个block的操作
    }];
//    3、设置队列的最大并发操作数量
    queue.maxConcurrentOperationCount = 2;
//    (2)取消NSOperationQueue中的所有操作
    [queue cancelAllOperations];
    */
    
    
    
    
    
    
    //操作依赖  NSOperation之间可以设置依赖来保证执行顺序  比如一定要让操作A执行完后，才能执行b，可以使用
//    [operationB addDependency:operationA];
    //也可以在不同的queue的NSOperation之间创建依赖关系
    
    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download 1---%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download 2----%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download 3 --- %@",[NSThread currentThread]);
    }];
    [op3 addDependency:op1];
    [op3 addDependency:op2];
    //不可以相互依赖 比如A依赖B，B依赖A
    
    NSArray *arr = @[op1,op2,op3];
    
    [queue1 addOperations:arr waitUntilFinished:NO];
    
    
  
    
    
    
    
    
    
    
    
    [self testAddImage];
}

//      线程之间的通信
- (void)testAddImage {
    
    [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
        
        NSLog(@"当前的线程是：%@",[NSThread currentThread]);
        
        NSURL *url = [NSURL URLWithString:@"http://img.pconline.com.cn/images/photoblog/9/9/8/1/9981681/200910/11/1255259355826.jpg"];
        //加载图片
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        UIImage *image = [UIImage imageWithData:data];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.imageView.image = image;
        }];
        
    }];
    
    
}
















- (void)viewDidLayoutSubviews {
    
    self.imageView.frame = CGRectMake(20, 100, 200, 200);
}



- (UIImageView *)imageView {
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:_imageView];
    }
    
    return _imageView;
}





@end


















