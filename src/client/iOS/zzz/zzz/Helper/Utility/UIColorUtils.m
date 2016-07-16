//
//  UIColorUtils.m
//  zzz
//
//  Created by jashion on 16/7/14.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import "UIColorUtils.h"

@implementation UIColorUtils


+ (UIColor *)contentTextColor {
	return [UIColor colorWithRed:0.282 green:0.271 blue:0.196 alpha:1.000];
}

+ (UIColor *)commentTextColor {
    return [UIColor colorWithRed:0.282 green:0.271 blue:0.196 alpha:1.000];
}

+ (UIColor *)checkMoreCommentTextColor {
    return [UIColor colorWithRed:0.761 green:0.753 blue:0.706 alpha:1.000];
}

+ (UIColor *)graySeparateLineColor {
    return [UIColor colorWithRed:0.839 green:0.835 blue:0.816 alpha:1.000];
}

+ (UIColor *)randomColor {
	int redValue = arc4random() % 256;
    int greenValue = arc4random() % 256;
    int blueValue = arc4random() % 256;
    return [UIColor colorWithRed: redValue / 255.f green: greenValue / 255.f blue: blueValue / 255.f alpha: 1];
}

@end
