//
//  YHDownSamplingController.m
//  learnObjective-C
//
//  Created by peng yihan on 2018/6/14.
//  Copyright © 2018年 peng yihan. All rights reserved.
//

#import "YHDownSamplingController.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface YHDownSamplingController ()
@property(strong,nonatomic)UIImageView *imageView;
@property(strong,nonatomic)UIImage *image;
@end

@implementation YHDownSamplingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIImageView*)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithImage:[self downsampleImage]];
        _imageView.frame = self.view.bounds;
    }
    return _imageView;
}


-(UIImage *)originImage{
    UIImage *image = [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"png"]];
    return image;
}

-(UIImage *)downsampleImage{
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"png"]];
    UIImage *retImage = [self downsample:url pointSize:CGSizeMake(10, 5) scale:[UIScreen mainScreen].scale];
    return retImage;
}

-(UIImage*)downsample:(NSURL *)imageUrl pointSize:(CGSize)size scale:(CGFloat)scale{
    CFDictionaryRef readOptions = (__bridge CFDictionaryRef) @{(id) kCGImageSourceShouldCache : @NO};
    CGImageSourceRef src = CGImageSourceCreateWithURL((__bridge CFURLRef) imageUrl, readOptions);
    // Create thumbnail options
    
    CGFloat pixels = MAX(size.width, size.height) * scale;
    CFDictionaryRef options = (__bridge CFDictionaryRef) @{
                                                           (id) kCGImageSourceShouldAllowFloat : @YES,
                                                           (id) kCGImageSourceCreateThumbnailWithTransform : @YES,
                                                           (id) kCGImageSourceShouldCacheImmediately: @YES,
                                                           (id) kCGImageSourceCreateThumbnailFromImageAlways : @YES,
                                                           (id) kCGImageSourceThumbnailMaxPixelSize : @(100)
                                                           };
    // Generate the thumbnail
    CGImageRef imageRef = CGImageSourceCreateImageAtIndex(src, 0, options);
    UIImage* retImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CFRelease(src);
    CFRelease(options);
    return retImage;
}



@end
