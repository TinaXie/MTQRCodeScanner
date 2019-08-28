//
//  MTQRScanner.h
//  MTQRCodeScanner_Example
//
//  Created by xiejc on 2018/12/18.
//  Copyright © 2018 xiejc. All rights reserved.
//

@import UIKit;
@import AVFoundation;

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MTQRScanner;

@protocol MTQRScannerDelegate <NSObject>

/**
 扫描完成的回调

 @param scanner 扫描器
 @param scanString 扫描出的字符串
 */
- (void)scanner:(MTQRScanner *)scanner didFinished:(NSString *)scanString;


/**
  监听环境光感的回调,如果 != nil 表示开启监测环境亮度功能

 @param scanner 扫描器
 @param brightness 亮度值
 */
- (void)scanner:(MTQRScanner *)scanner monitorLightChanged:(float)brightness;

@end


@interface MTQRScanner : NSObject

@property (nonatomic, assign) id<MTQRScannerDelegate> delegate;

/**
 闪光灯的状态,不需要设置，仅供外边判断状态使用
 */
@property (nonatomic, assign) BOOL isOpenningFlash;

/**
 初始化 扫描工具
 @param preview 展示输出流的视图
 @param scanFrame 扫描中心识别区域范围
 */
- (instancetype )initWithPreview:(UIView *)preview andScanFrame:(CGRect)scanFrame;

/**
 闪光灯开关
 */
- (void)openFlashSwitch:(BOOL)open;

- (void)sessionStartRunning;

- (void)sessionStopRunning;

/**
 识别图中二维码
 */
- (void)scanImageQRCode:(UIImage *_Nullable)imageCode;

/**
 生成自定义样式二维码
 注意：有些颜色结合生成的二维码识别不了
 @param codeString 字符串
 @param size 大小
 @param backColor 背景色
 @param frontColor 前景色
 @param centerImage 中心图片
 @return image二维码
 */
+ (UIImage *)createQRCodeImageWithString:(nonnull NSString *)codeString size:(CGSize)size backColor:(nullable UIColor *)backColor frontColor:(nullable UIColor *)frontColor centerImage:(nullable UIImage *)centerImage centerImageWidth:(CGFloat)centerImgWidth;


@end

NS_ASSUME_NONNULL_END
