//
//  BMUtility.m
//  zzz
//
//  Created by jashion on 16/7/14.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import "BMUtility.h"

CGSize BMScreenSize() {
    static CGSize size;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        size = [UIScreen mainScreen].bounds.size;
        if (size.height < size.width) {
            CGFloat temp = size.height;
            size.height = size.width;
            size.width = temp;
        }
    });
    return size;
}

CGFloat BMScreenScale() {
    static CGFloat scale;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scale = [UIScreen mainScreen].scale;
    });
    return scale;
}

