//
//  YHDownSamplingController.m
//  learnObjective-C
//
//  Created by peng yihan on 2018/6/14.
//  Copyright © 2018年 peng yihan. All rights reserved.
//

#import "YHDownSamplingController.h"

@interface YHDownSamplingController ()
@property(strong,nonatomic)UIImageView *imageView;
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

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithImage:[self testGetImage]];
        _imageView.frame = CGRectMake(0, 100, 200, 100);
    }
    return _imageView;
}

#define origin NO
-(UIImage *)testGetImage{
    if (origin) {
        return [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"png"]];
    }else{
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"png"]];
        UIImage *retImage = [self downsample:url pointSize:CGSizeMake(200, 100) scale:[UIScreen mainScreen].scale];
        return retImage;
    }
}

-(UIImage*)downsample:(NSURL *)imageUrl pointSize:(CGSize)size scale:(CGFloat)scale{
    CFStringRef keys[1];
    keys[0] = kCGImageSourceShouldCache;
    CFNumberRef values[1];
    values[0] = (CFTypeRef)kCFBooleanFalse;
    CFDictionaryRef dicRef = CFDictionaryCreate(kCFAllocatorDefault,
                                                (void*)keys,
                                                (void*)values,
                                                1,
                                                &kCFTypeDictionaryKeyCallBacks,
                                                &kCFTypeDictionaryValueCallBacks);
    CGImageSourceRef imageSource = CGImageSourceCreateWithURL((__bridge CFURLRef)imageUrl, dicRef);
    CGFloat maxDimensionInPixels = MAX(size.width, size.height) * scale;
    
    CFStringRef keys2[4] = {kCGImageSourceCreateThumbnailFromImageAlways,kCGImageSourceShouldCacheImmediately,kCGImageSourceCreateThumbnailWithTransform,kCGImageSourceThumbnailMaxPixelSize};
    CFTypeRef flag1 = kCFBooleanTrue;
    CFTypeRef flag2 = kCFBooleanTrue;
    CFTypeRef flag3 = kCFBooleanTrue;
    CGFloat flag4 = maxDimensionInPixels;
    CFNumberRef values2[4] = {CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &flag1),CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &flag2),CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &flag3),CFNumberCreate(kCFAllocatorDefault, kCFNumberFloat32Type, &flag4)};
    
    CFDictionaryRef optionRef = CFDictionaryCreate(kCFAllocatorDefault,
                                                (void*)keys2,
                                                (void*)values2,
                                                4,
                                                &kCFTypeDictionaryKeyCallBacks,
                                                &kCFTypeDictionaryValueCallBacks);
    CGImageRef imageRef = CGImageSourceCreateImageAtIndex(imageSource, 0, optionRef);
    UIImage* retImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CFRelease(dicRef);
    CFRelease(imageSource);
    CFRelease(optionRef);
    return retImage;
}


//func downsample(imageAt imageURL: URL, to pointSize: CGSize, scale: CGFloat) -> UIImage {
//
//    //生成CGImageSourceRef 时，不需要先解码。
//    let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
//    let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, imageSourceOptions)!
//    let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
//
//    //kCGImageSourceShouldCacheImmediately
//    //在创建Thumbnail时直接解码，这样就把解码的时机控制在这个downsample的函数内
//    let downsampleOptions = [kCGImageSourceCreateThumbnailFromImageAlways: true,
//                                     kCGImageSourceShouldCacheImmediately: true,
//                               kCGImageSourceCreateThumbnailWithTransform: true,
//                                      kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels] as CFDictionary
//    //生成
//    let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions)!
//    return UIImage(cgImage: downsampledImage)
//}



@end
