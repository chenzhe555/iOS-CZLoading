//
//  CZLoading.m
//  CZLoading
//
//  Created by yunshan on 2019/4/12.
//  Copyright © 2019 ChenZhe. All rights reserved.
//

#import "CZLoading.h"
#import <CZCategorys/NSObject+CZCategory.h>
#import <CZConfig/CZConfig.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface CZLoading ()
/**
 @brief 唯一标识
 */
@property (nonatomic, assign) NSInteger uniqueID;
/**
 @brief Loading数据数组
 */
@property (nonatomic, strong) NSMutableArray * loadingArray;
/**
 @brief 当前HUD视图
 */
@property (nonatomic, weak) MBProgressHUD * currentHUD;
@end

@implementation CZLoading

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.uniqueID = 1;
        self.loadingArray = [NSMutableArray array];
        self.showType = CZLoadingShowTypeQueue;
    }
    return self;
}

+(instancetype)shareManager
{
    static CZLoading * loading = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loading = [[CZLoading alloc] init];
        UIWindow * window = [self getMainWindow];
        [window addSubview:loading];
        loading.hidden = YES;
    });
    return loading;
}

-(NSInteger)showLoadingText:(NSString *)text topSpace:(CGFloat)topSpace bottomSpace:(CGFloat)bottomSpace
{
    if (text.length <= 0) return -1;
    
    //暂时先不考虑到 INT_MAX 这么大。。。
    NSInteger uniqueID = self.uniqueID++;
    NSDictionary * dic = @{
                           @"text": text,
                           @"topSpace": @(topSpace),
                           @"bottomSpace": @(bottomSpace),
                           @"uniqueID": @(uniqueID)
                           };
    //控制显示策略
    if (self.showType == CZLoadingShowTypeImmediately) {
        self.loadingArray = [NSMutableArray arrayWithObject:dic];
    } else if (self.showType == CZLoadingShowTypeQueue) {
        [self.loadingArray addObject:dic];
    }
    
    [self showHUD];
    return uniqueID;
}

-(void)showHUD
{
    NSDictionary * dic = self.loadingArray[0];
    NSString * text = dic[@"text"];
    
    //目前只显示菊花+文本
    self.frame = CGRectMake(0, [dic[@"topSpace"] floatValue], SCREENW, SCREENH - [dic[@"topSpace"] floatValue] - [dic[@"bottomSpace"] floatValue]);
    self.hidden = NO;
    if (!self.currentHUD) self.currentHUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
    if (text.length > 0) self.currentHUD.label.text = text;
}

-(void)stopLoading:(NSInteger)uniqueID
{
    if (uniqueID <= 0 || self.showType == CZLoadingShowTypeImmediately) {
        //释放当前 MBProgressHUD 等等操作
        [MBProgressHUD hideHUDForView:self animated:YES];
        self.currentHUD = nil;
        [self.loadingArray removeAllObjects];
        self.hidden = YES;
    } else {
        NSDictionary * dic = nil;
        NSInteger index = -1;
        for (NSInteger i = 0; i < self.loadingArray.count; ++i) {
            dic = self.loadingArray[i];
            if (uniqueID == [dic[@"uniqueID"] integerValue]) {
                index = i;
                break;
            }
        }
        //如果是第一个，隐藏第一个；否则去掉数据源即可
        if (index == 0) {
            [self.loadingArray removeObjectAtIndex:0];
            if (self.loadingArray.count > 0) {
                dic = self.loadingArray[0];
                self.currentHUD.label.text = dic[@"text"];
            }
        } else if (index > 0) {
            [self.loadingArray removeObjectAtIndex:index];
        }
        
        if (self.loadingArray.count <= 0) {
            [self stopLoading:0];
        }
    }
}

@end
