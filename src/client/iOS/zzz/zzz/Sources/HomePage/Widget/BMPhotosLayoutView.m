//
//  BMPhotosLayoutView.m
//  zzz
//
//  Created by jashion on 16/7/16.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import "BMPhotosLayoutView.h"
#import "UIColorUtils.h"
#import "UIImage+BMAddition.h"

#define inset 1

@interface BMPhotosLayoutView ()

@end

@implementation BMPhotosLayoutView

- (instancetype)initWithFrame:(CGRect)frame photos: (NSArray *)photos layoutType: (BMPhotoLayoutType)layoutType {
    self = [super initWithFrame: frame];
    if (self) {
        _photos = photos;
        _layoutType = layoutType;
        [self buildPhotoLayout];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame photoUrls: (NSArray *)photoUrls layoutType: (BMPhotoLayoutType)layoutType {
    self = [super initWithFrame: frame];
    if (self) {
        _photoUrls = photoUrls;
        _layoutType = layoutType;
        [self buildPhotoLayout];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        _photos = [@[] mutableCopy];
        _photoUrls = [@[] mutableCopy];
    }
    return self;
}

- (UIImageView *)imageViewWithPhoto: (UIImage *)photo photoFrame: (CGRect)photoFrame photoIndex: (NSInteger)photoIndex {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame: photoFrame];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.image = photo;
    imageView.tag = photoIndex;
    imageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
    [imageView addGestureRecognizer: tap];
    return imageView;
}

- (void)buildPhotoLayout {
    self.backgroundColor = [UIColor whiteColor];
    if (self.photos.count < 1 || self.photos.count >9) {
        return;
    }
    
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }

    CAShapeLayer *topLine = [CAShapeLayer layer];
    topLine.backgroundColor = [UIColorUtils graySeparateLineColor].CGColor;
    topLine.frame = CGRectMake(0, 0, self.frame.size.width, onePixel);
    [self.layer insertSublayer: topLine atIndex: 0];
    
    CAShapeLayer *bottomLine = [CAShapeLayer layer];
    bottomLine.backgroundColor = [UIColorUtils graySeparateLineColor].CGColor;
    bottomLine.frame = CGRectMake(0, self.frame.size.height - onePixel, self.frame.size.width, onePixel);
    [self.layer insertSublayer: bottomLine atIndex: 0];
    
    switch (self.photos.count) {
        case BMOnePhotos:
        {
            [self buildOnePhotoLayout];
            break;
        }
        
        case BMTwoPhotos:
        {
            [self buildTwoPhotosLayout];
            break;
        }

        case BMThreePhotos:
        {
            [self buildThreePhotoLayout];
            break;
        }

        case BMFourPhotos:
        {
            [self buildFourPhotosLayout];
            break;
        }

        case BMFivePhotos:
        {
            [self buildFivePhotoLayout];
            break;
        }

        case BMSixPhotos:
        {
            [self buildSixPhotosLayout];
            break;
        }

        case BMSevenPhotos:
        {
            [self buildSevenPhotoLayout];
            break;
        }

        case BMEightPhotos:
        {
            [self buildEightPhotosLayout];
            break;
        }

        case BMNinePhotos:
        {
            [self buildNinePhotoLayout];
            break;
        }
            
        default:
            break;
    }
}

- (void)buildOnePhotoLayout {
    UIImageView *tempImageView = [self imageViewWithPhoto: self.photos[0] photoFrame: self.bounds photoIndex: 0];
    [self addSubview: tempImageView];
}

- (void)buildTwoPhotosLayout {
    CGFloat photoWidth = [self computeBorderValueWithMaxWidth: self.frame.size.width bordersCount: self.photos.count photoInset: inset];
    CGRect photoRect;
    switch (self.layoutType) {
        case BMTwoPhotoTopToBottomLayout:
        {
            for (NSInteger index = 0; index < self.photos.count; index++) {
                photoRect = CGRectMake(0, index * (photoWidth + inset), self.frame.size.width, photoWidth);
                [self addSubview: [self imageViewWithPhoto: self.photos[index] photoFrame: photoRect photoIndex: index]];
            }
            break;
        }
            
        case BMTwoPhotoLeftToRightLayout:
        default:
        {
            for (NSInteger index = 0; index < self.photos.count; index++) {
                photoRect =  CGRectMake(index * (photoWidth + inset), 0, photoWidth, self.frame.size.height);
                [self addSubview: [self imageViewWithPhoto: self.photos[index] photoFrame: photoRect photoIndex: index]];
            }
            break;
        }
    }
}

- (void)buildThreePhotoLayout {
    CGFloat photoWidth = [self computeBorderValueWithMaxWidth: self.frame.size.width bordersCount: 2 photoInset: inset];
    CGRect photoRect;
    switch (self.layoutType) {
        case BMThreePhotoTopToBottomLayout:
        {
            for (NSInteger index = 0; index < self.photos.count; index++) {
                if (index == 0) {
                    photoRect =  CGRectMake(0, 0, self.frame.size.width, photoWidth);
                } else {
                    photoRect =  CGRectMake((index - 1) * (photoWidth + inset), photoWidth + inset, photoWidth, photoWidth);
                }
                [self addSubview: [self imageViewWithPhoto: self.photos[index] photoFrame: photoRect photoIndex: index]];
            }
            break;
        }
            
        case BMThreePhotoLeftToRightLayout:
        default:
        {
            for (NSInteger index = 0; index < self.photos.count; index++) {
                if (index == 0) {
                    photoRect =  CGRectMake(0, 0, photoWidth, self.frame.size.height);
                } else {
                    photoRect =  CGRectMake(photoWidth + inset, (index - 1) * (photoWidth + inset), photoWidth, photoWidth);
                }
                [self addSubview: [self imageViewWithPhoto: self.photos[index] photoFrame: photoRect photoIndex: index]];
            }
            break;
        }
    }
}

- (void)buildFourPhotosLayout {
    CGRect photoRect;
    switch (self.layoutType) {
        case BMFourPhotoLeftToRightLayout:
        {
            CGFloat photoWidth = [self computeBorderValueWithMaxWidth: self.frame.size.width bordersCount: 3 photoInset: inset];
            for (NSInteger index = 0; index < self.photos.count; index++) {
                if (index == 0) {
                    photoRect =  CGRectMake(0, 0, self.frame.size.width - photoWidth - inset, self.frame.size.height);
                } else {
                    photoRect =  CGRectMake(self.frame.size.width - photoWidth, (index - 1) * (photoWidth + inset), photoWidth, photoWidth);
                }
                [self addSubview: [self imageViewWithPhoto: self.photos[index] photoFrame: photoRect photoIndex: index]];
            }
            break;
        }
            
        case BMFourPhotoTopToBottomLayout:
        {
            CGFloat photoWidth = [self computeBorderValueWithMaxWidth: self.frame.size.width bordersCount: 3 photoInset: inset];
            for (NSInteger index = 0; index < self.photos.count; index++) {
                if (index == 0) {
                    photoRect =  CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - photoWidth - inset);
                } else {
                    photoRect =  CGRectMake((index - 1) * (photoWidth + inset), self.frame.size.height - photoWidth, photoWidth, photoWidth);
                }
                [self addSubview: [self imageViewWithPhoto: self.photos[index] photoFrame: photoRect photoIndex: index]];
            }
            break;
        }
            
        case BMFourPhotoPointToPointLayout:
        {
            CGFloat minPhotoWidth = [self computeBorderValueWithMaxWidth: self.frame.size.width bordersCount: 3 photoInset: inset];
            CGFloat maxPhotoWidth = self.frame.size.width - minPhotoWidth - inset;
            for (NSInteger index = 0; index < self.photos.count; index++) {
                if (index == 0) {
                    photoRect =  CGRectMake(0, 0, maxPhotoWidth, maxPhotoWidth);
                } else if (index == 3) {
                    photoRect =  CGRectMake(maxPhotoWidth + inset, maxPhotoWidth + inset, minPhotoWidth, minPhotoWidth);
                } else if (index == 1) {
                    photoRect =  CGRectMake(maxPhotoWidth + inset, 0, minPhotoWidth, maxPhotoWidth);
                } else {
                    photoRect =  CGRectMake(0, maxPhotoWidth + inset, maxPhotoWidth, minPhotoWidth);
                }
                [self addSubview: [self imageViewWithPhoto: self.photos[index] photoFrame: photoRect photoIndex: index]];
            }
            break;
        }
            
        case BMFourPhotoEqualLayout:
        default:
        {
            CGFloat photoWidth = [self computeBorderValueWithMaxWidth: self.frame.size.width bordersCount: 2 photoInset: inset];
            for (NSInteger index = 0; index < self.photos.count; index++) {
                if (index / 2 == 0) {
                    photoRect =  CGRectMake(index * (photoWidth + inset), 0, photoWidth, photoWidth);
                } else {
                    photoRect =  CGRectMake((index - 2) * (photoWidth + inset), photoWidth + inset, photoWidth, photoWidth);
                }
                [self addSubview: [self imageViewWithPhoto: self.photos[index] photoFrame: photoRect photoIndex: index]];
            }
            break;
        }
    }
}

- (void)buildFivePhotoLayout {
    CGFloat minPhotoWidth = [self computeBorderValueWithMaxWidth: self.frame.size.width bordersCount: 3 photoInset: inset];
    CGFloat maxPhotoHeight = self.frame.size.width - minPhotoWidth - inset;
    CGFloat maxPhotoWidth = [self computeBorderValueWithMaxWidth: self.frame.size.width bordersCount: 2 photoInset: inset];
    CGRect photoRect;
    
    switch (self.layoutType) {
        case BMFivePhotoLeftToRightLayout:
        {
            for (NSInteger index = 0; index < self.photos.count; index++) {
                if (index <= 1) {
                    photoRect =  CGRectMake(0, index * (maxPhotoWidth + inset), maxPhotoHeight, maxPhotoWidth);
                } else {
                    photoRect =  CGRectMake(self.frame.size.width - minPhotoWidth, (index - 2) * (minPhotoWidth + inset), minPhotoWidth, minPhotoWidth);
                }
                [self addSubview: [self imageViewWithPhoto: self.photos[index] photoFrame: photoRect photoIndex: index]];
            }
            break;
        }
            
        case BMFivePhotoPointToPointRightLayout:
        {
            for (NSInteger index = 0; index < self.photos.count; index++) {
                if (index == 0) {
                    photoRect =  CGRectMake(0, 0, maxPhotoHeight, maxPhotoHeight);
                } else if (index == 1) {
                    photoRect =  CGRectMake(0, maxPhotoHeight + inset, self.frame.size.width - minPhotoWidth - inset, minPhotoWidth);
                }else {
                    photoRect =  CGRectMake(self.frame.size.width - minPhotoWidth, (index - 2) * (minPhotoWidth + inset), minPhotoWidth, minPhotoWidth);
                }
                [self addSubview: [self imageViewWithPhoto: self.photos[index] photoFrame: photoRect photoIndex: index]];
            }
            break;
        }
            
        case BMFivePhotoPointToPointBottomLayout:
        {
            for (NSInteger index = 0; index < self.photos.count; index++) {
                if (index == 0) {
                    photoRect =  CGRectMake(0, 0, maxPhotoHeight, maxPhotoHeight);
                } else if (index == 1) {
                    photoRect =  CGRectMake(maxPhotoHeight + inset, 0, minPhotoWidth, self.frame.size.height - minPhotoWidth - inset);
                }else {
                    photoRect =  CGRectMake((index - 2) * (minPhotoWidth + inset), self.frame.size.height - minPhotoWidth, minPhotoWidth, minPhotoWidth);
                }
                [self addSubview: [self imageViewWithPhoto: self.photos[index] photoFrame: photoRect photoIndex: index]];
            }
            break;
        }
            
        case BMFivePhotoTopToBottomLayout:
        default:
        {
            for (NSInteger index = 0; index < self.photos.count; index++) {
                if (index <= 1) {
                    photoRect =  CGRectMake(index * (maxPhotoWidth + inset), 0, maxPhotoWidth, maxPhotoHeight);
                } else {
                    photoRect =  CGRectMake((index - 2) * (minPhotoWidth + inset), self.frame.size.height - minPhotoWidth, minPhotoWidth, minPhotoWidth);
                }
                [self addSubview: [self imageViewWithPhoto: self.photos[index] photoFrame: photoRect photoIndex: index]];
            }
            break;
        }
    }
}

- (void)buildSixPhotosLayout {
    CGRect photoRect;
    switch (self.layoutType) {
        case BMSixPhotoEqualHorizontalLayout:
        {
            CGFloat photoWidth = [self computeBorderValueWithMaxWidth: self.frame.size.width bordersCount: 3 photoInset: inset];
            CGFloat photoHeight = [self computeBorderValueWithMaxWidth: self.frame.size.height bordersCount: 2 photoInset: inset];
            for (NSInteger index = 0; index < self.photos.count; index++) {
                photoRect =  CGRectMake((index % 3) * (photoWidth + inset), (index / 3) * (photoHeight + inset), photoWidth, photoHeight);
                [self addSubview: [self imageViewWithPhoto: self.photos[index] photoFrame: photoRect photoIndex: index]];
            }
            break;
        }
            
        case BMSixPhotoEqualVerticalLayout:
        {
            CGFloat photoWidth = [self computeBorderValueWithMaxWidth: self.frame.size.width bordersCount: 2 photoInset: inset];
            CGFloat photoHeight = [self computeBorderValueWithMaxWidth: self.frame.size.height bordersCount: 3 photoInset: inset];
            for (NSInteger index = 0; index < self.photos.count; index++) {
                photoRect =  CGRectMake((index / 3) * (photoWidth + inset), (index % 3) * (photoHeight + inset), photoWidth, photoHeight);
                [self addSubview: [self imageViewWithPhoto: self.photos[index] photoFrame: photoRect photoIndex: index]];
            }
            break;
        }
            
        case BMSixPhotoLayout:
        default:
        {
            CGFloat minPhotoWidth = [self computeBorderValueWithMaxWidth: self.frame.size.width bordersCount: 3 photoInset: inset];
            CGFloat maxPhotoWidth = self.frame.size.width - minPhotoWidth - inset;
            for (NSInteger index = 0; index < self.photos.count; index++) {
                if (index == 0) {
                    photoRect =  CGRectMake(0, 0, maxPhotoWidth, maxPhotoWidth);
                } else if (index == 1 || index == 2) {
                    photoRect =  CGRectMake(maxPhotoWidth + inset, (index - 1) * (minPhotoWidth + inset), minPhotoWidth, minPhotoWidth);
                } else {
                    photoRect =  CGRectMake((index - 3) * (minPhotoWidth + inset), maxPhotoWidth + inset, minPhotoWidth, minPhotoWidth);
                }
                [self addSubview: [self imageViewWithPhoto: self.photos[index] photoFrame: photoRect photoIndex: index]];
            }
            break;
        }
    }
}

- (void)buildSevenPhotoLayout {
    CGFloat middleWidth = [self computeBorderValueWithMaxWidth: self.frame.size.width bordersCount: 3 photoInset: inset];
    CGFloat minWidth = [self computeBorderValueWithMaxWidth: self.frame.size.width bordersCount: 4 photoInset: inset];
    CGFloat maxWidth = middleWidth * 2 + inset;
    CGFloat otherWidth = [self computeBorderValueWithMaxWidth: self.frame.size.width bordersCount: 2 photoInset: inset];
    CGRect photoRect;
    
    switch (self.layoutType) {
        case BMSevenPhotoLeftToRightLayout:
        {
            for (NSInteger index = 0;  index < self.photos.count; index++) {
                if (index >= 0 && index <= 2) {
                    photoRect = CGRectMake(0, index * (middleWidth + inset), otherWidth, middleWidth);
                } else {
                    photoRect = CGRectMake(otherWidth + inset, (index - 3) * (minWidth + inset), otherWidth, minWidth);
                }
                [self addSubview: [self imageViewWithPhoto: self.photos[index] photoFrame: photoRect photoIndex: index]];
            }
            break;
        }
            
        case BMSevenPhotoBigRightLayout:
        {
            for (NSInteger index = 0;  index < self.photos.count; index++) {
                if (index == 0) {
                    photoRect = CGRectMake(0, 0, 3 * minWidth + 2 * inset, maxWidth);
                } else if (index >= 1 && index <= 2) {
                    photoRect = CGRectMake(3 * minWidth + 3 * inset, (index - 1) * (middleWidth + inset), minWidth, middleWidth);
                } else {
                    photoRect = CGRectMake((index - 3) * (minWidth + inset), maxWidth + inset, minWidth, middleWidth);
                }
                [self addSubview: [self imageViewWithPhoto: self.photos[index] photoFrame: photoRect photoIndex: index]];
            }
            break;
        }
            
        case BMSevenPhotoBigBottomLayout:
        {
            for (NSInteger index = 0;  index < self.photos.count; index++) {
                if (index == 0) {
                    photoRect = CGRectMake(0, 0, maxWidth, 3 * minWidth + 2 * inset);
                } else if (index >= 1 && index <= 2) {
                    photoRect = CGRectMake((index - 1) * (middleWidth + inset), 3 * minWidth + 3 * inset, middleWidth, minWidth);
                } else {
                    photoRect = CGRectMake(maxWidth + inset, (index - 3) * (minWidth + inset), middleWidth, minWidth);
                }
                [self addSubview: [self imageViewWithPhoto: self.photos[index] photoFrame: photoRect photoIndex: index]];
            }
            break;
        }
            
        case BMSevenPhotoTopToBottomLayout:
        default:
        {
            for (NSInteger index = 0;  index < self.photos.count; index++) {
                if (index >= 0 && index <= 2) {
                    photoRect = CGRectMake(index * (middleWidth + inset), 0, middleWidth, otherWidth);
                } else {
                    photoRect = CGRectMake((index - 3) * (minWidth + inset), otherWidth + inset, minWidth, otherWidth);
                }
                [self addSubview: [self imageViewWithPhoto: self.photos[index] photoFrame: photoRect photoIndex: index]];
            }
            break;
        }
    }
}

- (void)buildEightPhotosLayout {
    CGFloat minWidth = [self computeBorderValueWithMaxWidth: self.frame.size.width bordersCount: 4 photoInset: inset];
    CGFloat maxWidth = minWidth * 3 + inset * 2;
    CGRect photoRect;
    
    for (NSInteger index = 0; index < self.photos.count; index++) {
        if (index == 0) {
            photoRect = CGRectMake(0, 0, maxWidth, maxWidth);
        } else if (index > 0 && index < 4) {
            photoRect = CGRectMake(maxWidth + inset, (minWidth + inset) * (index - 1), minWidth, minWidth);
        } else {
            photoRect = CGRectMake((minWidth + inset) * (index - 4), maxWidth + inset, minWidth, minWidth);
        }
        [self addSubview: [self imageViewWithPhoto: self.photos[index] photoFrame: photoRect photoIndex: index]];
    }
}

- (void)buildNinePhotoLayout {
    CGFloat minWidth = [self computeBorderValueWithMaxWidth: self.frame.size.width bordersCount: 3 photoInset: inset];
    CGRect photoRect;
    
    for (NSInteger index = 0; index < self.photos.count; index++) {
        photoRect = CGRectMake((minWidth + inset) * (index % 3), (minWidth + inset) * (index / 3), minWidth, minWidth);
        [self addSubview: [self imageViewWithPhoto: self.photos[index] photoFrame: photoRect photoIndex: index]];
    }
}

#pragma mark - Event Response

- (void)handleTapPhotoEvent: (UITapGestureRecognizer *)tap {
    if (self.tapPhotoBlock) {
        self.tapPhotoBlock(self.photos, tap.view.tag, self);
    }
}

#pragma mark - Private Method

- (CGFloat)computeBorderValueWithMaxWidth: (CGFloat)maxWidth bordersCount: (NSInteger)bordersCount photoInset: (CGFloat)photoInset{
    return (maxWidth - photoInset * (bordersCount - 1)) / bordersCount;
}

#pragma mark - Refresh Data

- (void)setUpPhotos: (NSArray *)photos layoutType: (BMPhotoLayoutType)layoutType {
    self.photos = photos;
    self.layoutType = layoutType;
    [self buildPhotoLayout];
}

- (void)setupPhotoUrls: (NSArray *)photoUrls layoutType: (BMPhotoLayoutType)layoutType {
    self.photoUrls = photoUrls;
    self.layoutType = layoutType;
    [self buildPhotoLayout];
}

@end
