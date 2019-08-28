//
//  MTViewController.m
//  MTQRCodeScanner
//
//  Created by xiejc on 12/03/2018.
//  Copyright (c) 2018 xiejc. All rights reserved.
//

#import "MTViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MTScannerResultViewController.h"
#import "MTScannerViewController.h"
#import "MTQRScanner.h"


@interface MTViewController ()

@end


@implementation MTViewController

- (IBAction)goToScanner:(id)sender {
    MTScannerViewController *scannerVC = [[MTScannerViewController alloc] init];
    
    __block typeof(self) weakSelf = self;
    scannerVC.scanFinishBlock = ^(NSString * _Nullable scanString) {
        [weakSelf showResult:scanString];
    };
    [self.navigationController pushViewController:scannerVC animated:YES];
}

- (void)showResult:(NSString *)scanString {
    MTScannerResultViewController *createQRCodeController = [[MTScannerResultViewController alloc] init];
    createQRCodeController.qrString = scanString;
    if (scanString == nil) {
        createQRCodeController.qrImage = nil;
    } else {
        createQRCodeController.qrImage = [MTQRScanner createQRCodeImageWithString:scanString size:CGSizeMake(250, 250) backColor:[UIColor whiteColor] frontColor:[UIColor orangeColor] centerImage:nil centerImageWidth:0];
    }
    NSMutableArray *vcList = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [vcList removeLastObject];
    [vcList addObject:createQRCodeController];
    [self.navigationController setViewControllers:vcList animated:YES];
}

- (IBAction)goToMyQR:(id)sender {
    //点击我的二维码
    MTScannerResultViewController *createQRCodeController = [[MTScannerResultViewController alloc] init];
    createQRCodeController.qrImage = [MTQRScanner createQRCodeImageWithString:@"https://www.jianshu.com/u/e15d1f644bea" size:CGSizeMake(250, 250) backColor:[UIColor whiteColor] frontColor:[UIColor orangeColor] centerImage:[UIImage imageNamed:@"head"] centerImageWidth:100];
    createQRCodeController.qrString = @"我的二维码";
    [self.navigationController pushViewController:createQRCodeController animated:YES];
}


@end

