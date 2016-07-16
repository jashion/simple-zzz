//
//  UIColorUtils.h
//  zzz
//
//  Created by jashion on 16/7/14.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIColor.h>

#define RGB(r, g, b, a) [UIColor colorWithRed: r / 255.f green: g / 255.f blue: b / 255.f alpha: a]

@interface UIColorUtils : NSObject

+ (UIColor *)contentTextColor;
+ (UIColor *)commentTextColor;
+ (UIColor *)checkMoreCommentTextColor;

+ (UIColor *)graySeparateLineColor;

+ (UIColor *)randomColor;

@end
