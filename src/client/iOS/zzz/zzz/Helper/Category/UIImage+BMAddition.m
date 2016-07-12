//
//  UIImage+BMAddition.m
//  zzz
//
//  Created by jashion on 16/7/2.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import "UIImage+BMAddition.h"

@implementation UIImage (BMAddition)

- (UIImage *)imageByCropToRect: (CGRect)rect {
    rect.origin.x *= self.scale;
    rect.origin.y *= self.scale;
    rect.size.width *= self.scale;
    rect.size.height *= self.scale;
    if (rect.size.width <=0 || rect.size.height <= 0) {
        return nil;
    }
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *image = [UIImage imageWithCGImage: imageRef scale: self.scale orientation: self.imageOrientation];
    CGImageRelease(imageRef);
    return image;
}

- (UIImage *)imageByRoundCornerRadius: (CGFloat)radius
                              corners: (UIRectCorner)corners
                          borderWidth: (CGFloat)borderWidth
                          borderColor: (UIColor *)borderColor
                       borderLineJoin: (CGLineJoin)borderLineJoin {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextScaleCTM(context, 1, - 1);
    CGContextTranslateCTM(context, 0, - rect.size.height);
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
