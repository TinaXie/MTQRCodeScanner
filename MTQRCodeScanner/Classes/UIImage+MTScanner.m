//
//  UIImage+MTScanner.m
//  MTScannerLock
//
//  Created by xiejc on 2018/12/13.
//

#import "UIImage+MTScanner.h"

@implementation UIImage (MTScanner)

+ (UIImage *)mt_imageNamed:(NSString *)name {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"MTQRScanner" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];

    UIImage *img = [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];
    return img;
}


@end
