//
//  UIView+BMAddition.h
//  zzz
//
//  Created by jashion on 16/7/3.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BMAddition)

/**
 *  Create a snapshot image of the complete view hierarchy.
 *
 *  @return screen snapshot image
 */
- (UIImage *)snapshotImage;

/**
 *  Create a snapshot image of the complete view hierarchy.
 *
 *  @param afterUpdates if this value is YES, it will return a image after screen update.
 *
 *  @return screen snapshot image
 */
- (UIImage *)snapshotImageAfterScreenUpdates: (BOOL)afterUpdates;

@property (nonatomic, assign) CGFloat left;     //frame.origin.x
@property (nonatomic, assign) CGFloat top;      //frame.origin.y
@property (nonatomic, assign) CGFloat right;    //frame.origin.x + frame.size.width
@property (nonatomic, assign) CGFloat bottom;   //frame.origin.y + frame.size.height
@property (nonatomic, assign) CGFloat width;    //frame.size.width
@property (nonatomic, assign) CGFloat height;   //frame.size.height
@property (nonatomic, assign) CGFloat centerX;  //center.x
@property (nonatomic, assign) CGFloat centerY;  //center.y
@property (nonatomic, assign) CGPoint origin;   //frame.origin
@property (nonatomic, assign) CGSize  size;     //frame.size

@end
