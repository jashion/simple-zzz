//
//  UIImage+BMAddition.h
//  zzz
//
//  Created by jashion on 16/7/2.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BMAddition)

- (UIImage *)imageByCropToRect: (CGRect)rect;
- (UIImage *)imageByRoundCornerRadius: (CGFloat)radius corners: (UIRectCorner)corners borderWidth: (CGFloat)borderWidth borderColor: (UIColor *)borderColor borderLineJoin: (CGLineJoin)borderLineJoin;

@end
