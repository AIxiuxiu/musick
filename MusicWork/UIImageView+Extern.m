//
//  UIImageView+Extern.m
//  MusicWork
//
//  Created by mac on 16-3-26.
//  Copyright (c) 2016年 zhiyou. All rights reserved.
//

#import "UIImageView+Extern.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Extern.h"
@implementation UIImageView (Extern)

- (void)loadImageUrlStr:(NSString *)urlStr placeHolderImageName:(NSString *)placeHolderStr radius:(CGFloat)radius {
    //something
    //这里有针对不同需求的处理，我就没贴出来了
    
    NSURL *url;
    
    if (placeHolderStr == nil) {
        placeHolderStr = @"你通用的占位图地址";
    }
    
    //这里传CGFLOAT_MIN，就是默认以图片宽度的一半为圆角
    if (radius == CGFLOAT_MIN) {
        radius = self.frame.size.width/2.0;
    }
    
    url = [NSURL URLWithString:urlStr];
    
    if (radius != 0.0) {
        //头像需要手动缓存处理成圆角的图片
        NSString *cacheurlStr = [urlStr stringByAppendingString:@"radiusCache"];
        UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheurlStr];
        if (cacheImage) {
            self.image = cacheImage;
        }
        else {
            [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:placeHolderStr] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (!error) {
                    //UIImage *radiusImage = [UIImage createRoundedRectImage:image size:self.frame.size radius:radius];
                    UIImage *radiusImage = [UIImage circleImageWithImage:image size:self.frame.size borderWidth:10 borderColor:[[UIColor blueColor] colorWithAlphaComponent:0.4]];
                    self.image = radiusImage;
                    [[SDImageCache sharedImageCache] storeImage:radiusImage forKey:cacheurlStr];
                    //清除原有非圆角图片缓存
                    [[SDImageCache sharedImageCache] removeImageForKey:urlStr];
                }
            }];
        }
    }
    else {
        [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:placeHolderStr] completed:nil];
    }
}

@end
