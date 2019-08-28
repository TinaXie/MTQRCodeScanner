//
//  MTScannerViewController.m
//  MTQRCodeScanner_Example
//
//  Created by xiejc on 2018/12/18.
//  Copyright © 2018 xiejc. All rights reserved.
//

#import "MTScannerViewController.h"

#import "MTScannerView.h"
#import "MTQRScanner.h"
#import "UIImage+MTScanner.h"

#import <MobileCoreServices/MobileCoreServices.h>


#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define StatusBarAndNavigationBarHeight (iPhoneX ? 88.f : 64.f)



@interface MTScannerViewController ()
<UIImagePickerControllerDelegate, UINavigationControllerDelegate,
MTQRScannerDelegate>

@property (nonatomic, strong)  MTQRScanner *scanTool;
@property (nonatomic, strong)  MTScannerView *scanView;


@end

@implementation MTScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"二维码/条码";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(photoBtnClicked)];
    
    //输出流视图
    UIView *preview  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 0)];
    [self.view addSubview:preview];
    
    //构建扫描样式视图
    self.scanView = [[MTScannerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 0)];
    self.scanView.scanRetangleRect = CGRectMake(60, 120, (self.view.frame.size.width - 2 * 60),  (self.view.frame.size.width - 2 * 60));
    self.scanView.colorAngle = [UIColor greenColor];
    self.scanView.photoframeAngleW = 20;
    self.scanView.photoframeAngleH = 20;
    self.scanView.photoframeLineW = 2;
    self.scanView.isNeedShowRetangle = YES;
    self.scanView.colorRetangleLine = [UIColor whiteColor];
    self.scanView.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.scanView.animationImage = [UIImage mt_imageNamed:@"scanLine"];
    
    __block __weak typeof(self) weakSelf = self;
    self.scanView.changeSwitchBlock = ^(BOOL open) {
        [weakSelf.scanTool openFlashSwitch:open];
    };
    [self.view addSubview:self.scanView];
    
    //初始化扫描工具
    self.scanTool = [[MTQRScanner alloc] initWithPreview:preview andScanFrame:self.scanView.scanRetangleRect];
    self.scanTool.delegate = self;
    [self.scanTool sessionStartRunning];
    [self.scanView startScanAnimation];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.scanView startScanAnimation];
    [self.scanTool sessionStartRunning];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.scanView stopScanAnimation];
    [self.scanView finishedHandle];
    [self.scanView showFlashSwitch:NO];
    [self.scanTool sessionStopRunning];
}
#pragma mark -- Events Handle

- (void)photoBtnClicked{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    } else {
        NSLog(@"不支持访问相册");
    }
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message handler:(void (^) (UIAlertAction *action))handler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:handler];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"取消选择图片");
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //如果返回的type等于kUTTypeImage，代表返回的是照片
    if ([type isEqualToString:(NSString *)kUTTypeImage]) {
       //获取照片的原图
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.scanTool scanImageQRCode:image];
    }
}



#pragma mark -

- (void)scanner:(MTQRScanner *)scanner didFinished:(NSString *)scanString {
    NSLog(@"扫描结果 %@",scanString);
    [self.scanView handlingResultsOfScan];
    if (self.scanFinishBlock) {
        self.scanFinishBlock(scanString);
    }
    [self.scanTool sessionStopRunning];
    [self.scanTool openFlashSwitch:NO];
}

- (void)scanner:(MTQRScanner *)scanner monitorLightChanged:(float)brightness {
    
    CGFloat standerBright = 0;
    if (brightness < standerBright) {
        //环境太暗，可以打开闪光灯了
        if (!self.scanTool.isOpenningFlash) {
            NSLog(@"环境太暗，可以打开闪光灯了");
            [self.scanView showFlashSwitch:YES];
        }
    } else {
        // 环境亮度可以
        if(!self.scanTool.isOpenningFlash) {
            NSLog(@"环境亮度可以:%f", brightness);
            [self.scanView showFlashSwitch:NO];
        }
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
