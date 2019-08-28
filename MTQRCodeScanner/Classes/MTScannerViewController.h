//
//  MTScannerViewController.h
//  MTQRCodeScanner_Example
//
//  Created by xiejc on 2018/12/18.
//  Copyright © 2018 xiejc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTScannerViewController : UIViewController

/**
 扫描完成的回调
 @param scanString 扫描出的字符串
 */

@property (nonatomic, copy) void(^scanFinishBlock)(NSString * _Nullable scanString);

@end

NS_ASSUME_NONNULL_END
