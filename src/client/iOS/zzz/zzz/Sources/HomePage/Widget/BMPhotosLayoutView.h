//
//  BMPhotosLayoutView.h
//  zzz
//
//  Created by jashion on 16/7/16.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BMPhotoLayoutType) {
    BMOnePhotoLayout        =  0,
    BMTwoPhotoLayout        =  1,
    BMThreePhotoLayout      =  2,
    BMFourPhotoLayout       =  3,
    BMFivePhotoLayout       =  4,
    BMSixPhotoLayout        =  5
};

@interface BMPhotosLayoutView : UIView

- (instancetype)initWithMaxWidth: (CGFloat)maxWidth photos: (NSArray *)photos layoutType: (BMPhotoLayoutType)layoutType;

@end
