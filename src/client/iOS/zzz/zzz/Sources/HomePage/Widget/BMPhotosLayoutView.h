//
//  BMPhotosLayoutView.h
//  zzz
//
//  Created by jashion on 16/7/16.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BMPhotoLayoutType) {
    BMOnePhotoLayout                        =  0,
    BMTwoPhotoLeftToRightLayout             =  1,
    BMTwoPhotoTopToBottomLayout             =  2,
    BMThreePhotoLeftToRightLayout           =  3,
    BMThreePhotoTopToBottomLayout           =  4,
    BMFourPhotoEqualLayout                  =  5,
    BMFourPhotoLeftToRightLayout            =  6,
    BMFourPhotoTopToBottomLayout            =  7,
    BMFourPhotoPointToPointLayout           =  8,
    BMFivePhotoLeftToRightLayout            =  9,
    BMFivePhotoTopToBottomLayout            =  10,
    BMFivePhotoPointToPointRightLayout      =  11,
    BMFivePhotoPointToPointBottomLayout     =  12,
    BMSixPhotoLayout                        =  13,
    BMSixPhotoEqualHorizontalLayout         =  14,
    BMSixPhotoEqualVerticalLayout           =  15
};

typedef void(^handleTapPhotoEvent)(NSArray *photos, NSInteger currentIndex);

@interface BMPhotosLayoutView : UIView

@property (nonatomic, copy) handleTapPhotoEvent tapPhotoBlock;
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, assign) BMPhotoLayoutType layoutType;

- (instancetype)initWithFrame:(CGRect)frame photos: (NSArray *)photos layoutType: (BMPhotoLayoutType)layoutType;
- (void)setUpPhotos: (NSArray *)photos layoutType: (BMPhotoLayoutType)layoutType;

@end
