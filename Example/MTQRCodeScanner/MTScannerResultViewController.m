//
//  MTScannerResultViewController.m
//  MTQRCodeScanner_Example
//
//  Created by xiejc on 2018/12/18.
//  Copyright © 2018 xiejc. All rights reserved.
//

#import "MTScannerResultViewController.h"

@interface MTScannerResultViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation MTScannerResultViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"生成二维码";
    self.view.backgroundColor = [UIColor whiteColor];

    CGFloat imgX = 20.0;
    CGFloat imgY = 100.0;
    CGFloat imgW = CGRectGetWidth(self.view.frame) - imgX * 2.0;
    CGFloat imgH = imgW;
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imgX, imgY, imgW, imgH)];
    self.imageView.image = self.qrImage;
    
    [self.view addSubview:self.imageView];
    
    CGFloat descLabelX = CGRectGetMinX(self.imageView.frame);
    CGFloat descLabelY = CGRectGetMaxY(self.imageView.frame) + 20.0;
    CGFloat descLabelW = CGRectGetWidth(self.view.frame) - descLabelX * 2.0;
    CGFloat descLabelH = 60.0;
    
    self.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(descLabelX, descLabelY, descLabelW, descLabelH)];
    self.descLabel.numberOfLines = 0;
    [self.view addSubview:self.descLabel];
    
    if (self.qrString == nil) {
        self.descLabel.text = @"未扫描到二维码";
        self.descLabel.textAlignment = NSTextAlignmentCenter;
    } else {
        self.descLabel.text = [NSString stringWithFormat:@"扫描结果：%@ ",self.qrString];
        self.descLabel.textAlignment = NSTextAlignmentLeft;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
