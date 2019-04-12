//
//  DemoViewController.m
//  CZLoading
//
//  Created by yunshan on 2019/4/12.
//  Copyright © 2019 ChenZhe. All rights reserved.
//

#import "DemoViewController.h"
#import "CZLoading.h"

@interface DemoViewController ()
@property (nonatomic, assign) NSInteger cID;
@property (nonatomic, strong) NSMutableArray * arr;
@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arr = [NSMutableArray array];
//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(hide) userInfo:nil repeats:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[CZLoading shareManager] stopLoading:1];
    });
}

- (IBAction)hideImmediately:(id)sender {
    [CZLoading shareManager].showType = CZLoadingShowTypeImmediately;
    ++self.cID;
    [[CZLoading shareManager] showLoadingText:[NSString stringWithFormat:@"陈哲是个好孩子%ld",(long)self.cID] topSpace:64 bottomSpace:300];
}
- (IBAction)hideQueue:(id)sender {
    ++self.cID;
    NSInteger cID = [[CZLoading shareManager] showLoadingText:[NSString stringWithFormat:@"陈哲是个好孩子%ld",(long)self.cID] topSpace:64 bottomSpace:300];
    [self.arr addObject:@(cID)];
}


- (IBAction)test:(id)sender {
    NSLog(@"测试事件");
    ++self.cID;
    NSInteger cID = [[CZLoading shareManager] showLoadingText:[NSString stringWithFormat:@"陈哲是个好孩子%ld",(long)self.cID] topSpace:64 bottomSpace:300];
    [self.arr addObject:@(cID)];
}
- (IBAction)test2:(id)sender {
    NSLog(@"测试事件2");
    [[CZLoading shareManager] stopLoading:0];
}

-(void)hide
{
    if (self.arr.count <= 0) return;
    int rIndex = arc4random() % self.arr.count;
    rIndex = 0;
    NSInteger cID = [self.arr[rIndex] integerValue];
    [self.arr removeObjectAtIndex:rIndex];
    [[CZLoading shareManager] stopLoading:cID];
}

@end
