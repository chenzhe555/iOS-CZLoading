//
//  CZLoading.h
//  CZLoading
//
//  Created by yunshan on 2019/4/12.
//  Copyright © 2019 ChenZhe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 @brief CZLoading 显示策略
 */
typedef NS_ENUM(NSInteger, CZLoadingShowType) {
    /** 前面的立即消失 */
    CZLoadingShowTypeImmediately = 1,
    /** 依次消失 */
    CZLoadingShowTypeQueue
};

/**
 @brief 加载视图Loading,基于MBProgressHUD
 */
@interface CZLoading : UIView
#pragma mark 属性
/**
 @brief CZLoading 显示策略，默认依次显示
 @see CZLoadingShowType
 */
@property (nonatomic, assign) CZLoadingShowType showType;

#pragma mark 对外提供方法
/**
 @brief 获取当前实例
 */
+(instancetype)shareManager;

/**
 @brief 显示Loading 自定义顶底部可操作高度

 @param topSpace 顶部预留可操作高度
 @param bottomSpace 底部预留可操作高度
 */
-(NSInteger)showLoadingText:(NSString *)text topSpace:(CGFloat)topSpace bottomSpace:(CGFloat)bottomSpace;


/**
 @brief 隐藏Loading视图

 @param uniqueID showLoadingText会返回唯一ID，如果传0，则立即隐藏
 */
-(void)stopLoading:(NSInteger)uniqueID;
@end

NS_ASSUME_NONNULL_END
