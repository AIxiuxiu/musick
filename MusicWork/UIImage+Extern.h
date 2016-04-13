//
//  UIImage+Extern.h
//  MusicWork
//
//  Created by mac on 16-3-26.
//  Copyright (c) 2016年 zhiyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extern)

+ (UIImage *)circleImageWithImage:(UIImage *)image size:(CGSize)size borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;

+ (UIColor*)mostColor:(UIImage*)image;

@end
