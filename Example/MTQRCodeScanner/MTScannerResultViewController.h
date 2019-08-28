//
//  MTScannerResultViewController.h
//  MTQRCodeScanner_Example
//
//  Created by xiejc on 2018/12/18.
//  Copyright © 2018 xiejc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTScannerResultViewController : UIViewController

@property (nonatomic, strong, nullable) UIImage * qrImage;
@property (nonatomic, copy, nullable) NSString * qrString;

@end

NS_ASSUME_NONNULL_END
