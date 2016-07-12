//
//  UIView+BMAddition.h
//  zzz
//
//  Created by jashion on 16/7/3.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BMAddition)

@property (nonatomic, assign) CGFloat left;     //self.frame.origin.x
@property (nonatomic, assign) CGFloat top;      //self.frame.origin.y
@property (nonatomic, assign) CGFloat right;    //self.frame.origin.x + self.frame.size.width
@property (nonatomic, assign) CGFloat bottom;   //self.frame.origin.y + self.frame.size.height
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize  size;

@end
