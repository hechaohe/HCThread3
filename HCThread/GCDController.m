//
//  GCDController.m
//  HCThread
//
//  Created by hc on 2018/4/20.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "GCDController.h"

@interface GCDController ()

@end

@implementation GCDController
const int64_t kDefaultTimeoutLengthInNanoSeconds = 10000000000; // 10 Seconds

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self testSemaphore];
    
    
//    dispatch_main();//串行队列一样，一次只能执行一个，主线程是唯一可用于更新UI的线程。
    
//    global queue
//#define DISPATCH_QUEUE_PRIORITY_HIGH 2
//#define DISPATCH_QUEUE_PRIORITY_DEFAULT 0
//#define DISPATCH_QUEUE_PRIORITY_LOW (-2)
//#define DISPATCH_QUEUE_PRIORITY_BACKGROUND INT16_MIN
    
    
    
    //从主线程到全局线程
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
////        UIImage *overlayImage = [self faceOverlayImageFromImage:_image];
//        dispatch_async(dispat ch_get_main_queue(), ^{ //在主线程更新UI
////            [self fadeInNewImage:overlayImage];
//        });
//    });
    
    
    //延迟一秒执行
//    double delaySeconds = 1.0;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delaySeconds));
//    dispatch_after(popTime, dispatch_get_main_queue(), ^{
//        if (!count) {
//            [self.navigationItem setPrompt:@"Add photos with faces to Googlyify them!"];
//        } else {
//            [self.navigationItem setPrompt:nil];
//        }
//    });
    
    
    
    
    
    
    
    
    //   Dispatch_sync
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        NSLog(@"first log");
//    });
//    NSLog(@"second log");
    
    
    //   Dispatch_async
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        NSLog(@"first log");
//    });
//    NSLog(@"second log");
    
}

//使用dispatch_once实现单利
//+ (instancetype)sharedManager {
//
//    static AAManager *sharedManager = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        sharedManager = [[AAManager alloc] init];
//        AAManager->photoArr = [NSMutableArray array];
//    });
//
//}


// Dispatch Barriers 适用于自定义并发队列
//ddispatch barriers 创建一个读写锁


//- (void)addPhoto:(Photo *)photo {
//
//    dispatch_queue_t concurrentPhotoQueue;
//
//    if (photo) {
//        dispatch_barrier_sync(concurrentPhotoQueue, ^{
//            [_photoArr addobject:photo];  //数组的写入操作
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self postContentAddedNotification];
//            });
//        });
//    }
//
//}

//dispatch_sync 并发队列：这才是做同步工作的好选择，不论是通过调度障碍，或者需要等待一个任务完成才能执行进一步处理的情况

//- (NSArray *)photos {
//    dispatch_queue_t concurrentPhotoQueue;
//
//    concurrentPhotoQueue = dispatch_queue_create("com.abc.aoole.HCThread.photoQueue", DISPATCH_QUEUE_CONCURRENT);
//
//    __block NSArray *array;
//    dispatch_sync(concurrentPhotoQueue, ^{
////        array = [NSArray arrayWithArray:_photoMutableArray];
//    });
//    return array;
//}




//dispatch_group
/*
Dispatch Group 会在整个组的任务都完成时通知你。这些任务可以是同步的，也可以是异步的，即便在不同的队列也行。而且在整个组的任务都完成时，Dispatch Group 可以用同步的或者异步的方式通知你。因为要监控的任务在不同队列，那就用一个 dispatch_group_t 的实例来记下这些不同的任务。

第一种是 dispatch_group_wait ，它会阻塞当前线程，直到组里面所有的任务都完成或者等到某个超时发生。这恰好是你目前所需要的。
 */
- (void)testGroup {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
       
        dispatch_group_t downloadGroup = dispatch_group_create();
        for (NSInteger i = 0; i < 3; i ++) {
            switch (i) {
                case 0:
                    
                    break;
                case 1:
                    
                    break;
                case 2:
                    
                    break;
                    
                default:
                    break;
            }
            dispatch_group_enter(downloadGroup);
            //
            //......
            dispatch_group_leave(downloadGroup);
            //
        }
        
        dispatch_group_wait(downloadGroup, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
           //......
        });
        
    });
    
    
}


//第二种 使用dispatch_group_notify
- (void)testGroupNotify {
    
    dispatch_group_t downloadGroup = dispatch_group_create();
    
    for (NSInteger i = 0; i < 3; i ++) {
        switch (i) {
            case 0:
                
                break;
            case 1:
                
                break;
            case 2:
                
                break;
                
            default:
                break;
        }
        dispatch_group_enter(downloadGroup);
        //
        //......
        dispatch_group_leave(downloadGroup);
        //
    }
    
    dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
       //.......
    });
    
}

//dispatch_apply 表现得就像一个 for 循环，但它能并发地执行不同的迭代。这个函数是同步的，所以和普通的 for 循环一样，它只会在所有工作都完成后才会返回。 意并发的开销
//    要以合适的步长迭代非常大的集合，那才应该考虑使用 dispatch_apply。
- (void)testGroupApply {
    
    dispatch_group_t downloadGroup = dispatch_group_create();
    
    dispatch_apply(3, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(size_t i) {
        switch (i) { //不会按照顺序执行，取决于线程完成的顺序
            case 0:
                
                break;
            case 1:
                
                break;
            case 2:
                
                break;
                
            default:
                break;
        }
        
        dispatch_group_enter(downloadGroup);
        //....
        dispatch_group_leave(downloadGroup);
    });
    
    dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
        //.....
    });
    
}

// 信号量
- (void)testSemaphore {
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    for (int i =0; i < 50000; i ++) {
        NSLog(@"111");
        dispatch_semaphore_signal(semaphore);
    }
    
    
    
    dispatch_time_t timeoutTime = dispatch_time(DISPATCH_TIME_NOW, kDefaultTimeoutLengthInNanoSeconds);
    
    if (dispatch_semaphore_wait(semaphore, timeoutTime)) {
        NSLog(@"time out");
    } else {
        NSLog(@"well done");
    }
    
    
    
    
    
    
    
    
    
    
    
}















@end



