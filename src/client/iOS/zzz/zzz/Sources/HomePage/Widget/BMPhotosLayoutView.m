//
//  BMPhotosLayoutView.m
//  zzz
//
//  Created by jashion on 16/7/16.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import "BMPhotosLayoutView.h"
#import "UIColorUtils.h"
#import "BMUtility.h"
#import "UIImage+BMAddition.h"

#define inset onePixel

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

- (void)buildPhotoLayout {
    self.backgroundColor = [UIColor whiteColor];
    if (self.photos.count <= 0) {
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

    if (self.photos.count == 1) {
        UIImageView *photo = [[UIImageView alloc] initWithFrame: self.bounds];
        photo.contentMode = UIViewContentModeScaleAspectFill;
        photo.clipsToBounds = YES;
        photo.image = self.photos[0];
        photo.tag = 0;
        photo.userInteractionEnabled = YES;
        [self addSubview: photo];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
        [photo addGestureRecognizer: tap];
        return;
    }
    
    if (self.photos.count == 2) {
        CGFloat photoWidth = [self computeBorderValueWithMaxWidth: self.frame.size.width bordersCount: self.photos.count photoInset: inset];
        switch (self.layoutType) {
            case BMTwoPhotoTopToBottomLayout:
            {
                for (NSInteger index = 0; index < self.photos.count; index++) {
                    CGRect photoRect = CGRectMake(0, index * (photoWidth + inset), self.frame.size.width, photoWidth);
                    UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                    photo.contentMode = UIViewContentModeScaleAspectFill;
                    photo.clipsToBounds = YES;
                    photo.image = self.photos[index];
                    photo.tag = index;
                    photo.userInteractionEnabled = YES;
                    [self addSubview: photo];
                    
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                    [photo addGestureRecognizer: tap];
                }
                break;
            }
             
            BMTwoPhotoLeftToRightLayout:
            default:
            {
                for (NSInteger index = 0; index < self.photos.count; index++) {
                    CGRect photoRect =  CGRectMake(index * (photoWidth + inset), 0, photoWidth, self.frame.size.height);
                    UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                    photo.contentMode = UIViewContentModeScaleAspectFill;
                    photo.clipsToBounds = YES;
                    photo.image = self.photos[index];
                    photo.tag = index;
                    photo.userInteractionEnabled = YES;
                    [self addSubview: photo];
                    
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                    [photo addGestureRecognizer: tap];
                }
                break;
            }
        }
        return;
    }

    if (self.photos.count == 3) {
        CGFloat photoWidth = [self computeBorderValueWithMaxWidth: self.frame.size.width bordersCount: 2 photoInset: inset];
        switch (self.layoutType) {
            case BMThreePhotoTopToBottomLayout:
            {
                for (NSInteger index = 0; index < self.photos.count; index++) {
                    if (index == 0) {
                        CGRect photoRect =  CGRectMake(0, 0, self.frame.size.width, photoWidth);
                        UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                        photo.contentMode = UIViewContentModeScaleAspectFill;
                        photo.clipsToBounds = YES;
                        photo.image = self.photos[index];
                        photo.tag = index;
                        photo.userInteractionEnabled = YES;
                        [self addSubview: photo];
                        
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                        [photo addGestureRecognizer: tap];
                    } else {
                        CGRect photoRect =  CGRectMake((index - 1) * (photoWidth + inset), photoWidth + inset, photoWidth, photoWidth);
                        UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                        photo.contentMode = UIViewContentModeScaleAspectFill;
                        photo.clipsToBounds = YES;
                        photo.image = self.photos[index];
                        photo.tag = index;
                        photo.userInteractionEnabled = YES;
                        [self addSubview: photo];
                        
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                        [photo addGestureRecognizer: tap];
                    }
                }
                break;
            }

            case BMThreePhotoLeftToRightLayout:
            default:
            {
                for (NSInteger index = 0; index < self.photos.count; index++) {
                    if (index == 0) {
                        CGRect photoRect =  CGRectMake(0, 0, photoWidth, self.frame.size.height);
                        UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                        photo.contentMode = UIViewContentModeScaleAspectFill;
                        photo.clipsToBounds = YES;
                        photo.image = self.photos[index];
                        photo.tag = index;
                        photo.userInteractionEnabled = YES;
                        [self addSubview: photo];
                        
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                        [photo addGestureRecognizer: tap];
                    } else {
                        CGRect photoRect =  CGRectMake(photoWidth + inset, (index - 1) * (photoWidth + inset), photoWidth, photoWidth);
                        UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                        photo.contentMode = UIViewContentModeScaleAspectFill;
                        photo.clipsToBounds = YES;
                        photo.image = self.photos[index];
                        photo.tag = index;
                        photo.userInteractionEnabled = YES;
                        [self addSubview: photo];
                        
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                        [photo addGestureRecognizer: tap];
                    }
                }
                break;
            }
        }
        return;
    }

    if (self.photos.count == 4) {
        switch (self.layoutType) {
            case BMFourPhotoLeftToRightLayout:
            {
                CGFloat photoWidth = [self computeBorderValueWithMaxWidth: self.frame.size.width bordersCount: 3 photoInset: inset];
                for (NSInteger index = 0; index < self.photos.count; index++) {
                    if (index == 0) {
                        CGRect photoRect =  CGRectMake(0, 0, self.frame.size.width - photoWidth - inset, self.frame.size.height);
                        UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                        photo.contentMode = UIViewContentModeScaleAspectFill;
                        photo.clipsToBounds = YES;
                        photo.image = self.photos[index];
                        photo.tag = index;
                        photo.userInteractionEnabled = YES;
                        [self addSubview: photo];
                        
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                        [photo addGestureRecognizer: tap];
                    } else {
                        CGRect photoRect =  CGRectMake(self.frame.size.width - photoWidth, (index - 1) * (photoWidth + inset), photoWidth, photoWidth);
                        UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                        photo.contentMode = UIViewContentModeScaleAspectFill;
                        photo.clipsToBounds = YES;
                        photo.image = self.photos[index];
                        photo.tag = index;
                        photo.userInteractionEnabled = YES;
                        [self addSubview: photo];
                        
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                        [photo addGestureRecognizer: tap];
                    }
                }
                break;
            }
            
            case BMFourPhotoTopToBottomLayout:
            {
                CGFloat photoWidth = [self computeBorderValueWithMaxWidth: self.frame.size.width bordersCount: 3 photoInset: inset];
                for (NSInteger index = 0; index < self.photos.count; index++) {
                    if (index == 0) {
                        CGRect photoRect =  CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - photoWidth - inset);
                        UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                        photo.contentMode = UIViewContentModeScaleAspectFill;
                        photo.clipsToBounds = YES;
                        photo.image = self.photos[index];
                        photo.tag = index;
                        photo.userInteractionEnabled = YES;
                        [self addSubview: photo];
                        
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                        [photo addGestureRecognizer: tap];
                    } else {
                        CGRect photoRect =  CGRectMake((index - 1) * (photoWidth + inset), self.frame.size.height - photoWidth, photoWidth, photoWidth);
                        UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                        photo.contentMode = UIViewContentModeScaleAspectFill;
                        photo.clipsToBounds = YES;
                        photo.image = self.photos[index];
                        photo.tag = index;
                        photo.userInteractionEnabled = YES;
                        [self addSubview: photo];
                        
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                        [photo addGestureRecognizer: tap];
                    }
                }
                break;
            }
            
            case BMFourPhotoPointToPointLayout:
            {
                CGFloat minPhotoWidth = [self computeBorderValueWithMaxWidth: self.frame.size.width bordersCount: 3 photoInset: inset];
                CGFloat maxPhotoWidth = self.frame.size.width - minPhotoWidth - inset;
                for (NSInteger index = 0; index < self.photos.count; index++) {
                    if (index == 0) {
                        CGRect photoRect =  CGRectMake(0, 0, maxPhotoWidth, maxPhotoWidth);
                        UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                        photo.contentMode = UIViewContentModeScaleAspectFill;
                        photo.clipsToBounds = YES;
                        photo.image = self.photos[index];
                        photo.tag = index;
                        photo.userInteractionEnabled = YES;
                        [self addSubview: photo];
                        
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                        [photo addGestureRecognizer: tap];
                    } else if (index == 3) {
                        CGRect photoRect =  CGRectMake(maxPhotoWidth + inset, maxPhotoWidth + inset, minPhotoWidth, minPhotoWidth);
                        UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                        photo.contentMode = UIViewContentModeScaleAspectFill;
                        photo.clipsToBounds = YES;
                        photo.image = self.photos[index];
                        photo.tag = index;
                        photo.userInteractionEnabled = YES;
                        [self addSubview: photo];
                        
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                        [photo addGestureRecognizer: tap];
                    } else if (index == 1) {
                        CGRect photoRect =  CGRectMake(maxPhotoWidth + inset, 0, minPhotoWidth, maxPhotoWidth);
                        UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                        photo.contentMode = UIViewContentModeScaleAspectFill;
                        photo.clipsToBounds = YES;
                        photo.image = self.photos[index];
                        photo.tag = index;
                        photo.userInteractionEnabled = YES;
                        [self addSubview: photo];
                        
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                        [photo addGestureRecognizer: tap];
                    } else {
                        CGRect photoRect =  CGRectMake(0, maxPhotoWidth + inset, maxPhotoWidth, minPhotoWidth);
                        UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                        photo.contentMode = UIViewContentModeScaleAspectFill;
                        photo.clipsToBounds = YES;
                        photo.image = self.photos[index];
                        photo.tag = index;
                        photo.userInteractionEnabled = YES;
                        [self addSubview: photo];
                        
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                        [photo addGestureRecognizer: tap];
                    }
                }
                break;
            }
                
            BMFourPhotoEqualLayout:
            default:
            {
                CGFloat photoWidth = [self computeBorderValueWithMaxWidth: self.frame.size.width bordersCount: 2 photoInset: inset];
                for (NSInteger index = 0; index < self.photos.count; index++) {
                    if (index / 2 == 0) {
                        CGRect photoRect =  CGRectMake(index * (photoWidth + inset), 0, photoWidth, photoWidth);
                        UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                        photo.contentMode = UIViewContentModeScaleAspectFill;
                        photo.clipsToBounds = YES;
                        photo.image = self.photos[index];
                        photo.tag = index;
                        photo.userInteractionEnabled = YES;
                        [self addSubview: photo];
                        
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                        [photo addGestureRecognizer: tap];
                    } else {
                        CGRect photoRect =  CGRectMake((index - 2) * (photoWidth + inset), photoWidth + inset, photoWidth, photoWidth);
                        UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                        photo.contentMode = UIViewContentModeScaleAspectFill;
                        photo.clipsToBounds = YES;
                        photo.image = self.photos[index];
                        photo.tag = index;
                        photo.userInteractionEnabled = YES;
                        [self addSubview: photo];
                        
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                        [photo addGestureRecognizer: tap];
                    }
                }
                break;
            }
        }
        return;
    }

    if (self.photos.count == 5) {
        CGFloat minPhotoWidth = [self computeBorderValueWithMaxWidth: self.frame.size.width bordersCount: 3 photoInset: inset];
        CGFloat maxPhotoHeight = self.frame.size.width - minPhotoWidth - inset;
        CGFloat maxPhotoWidth = [self computeBorderValueWithMaxWidth: self.frame.size.width bordersCount: 2 photoInset: inset];

        switch (self.layoutType) {
            case BMFivePhotoLeftToRightLayout:
            {
                for (NSInteger index = 0; index < self.photos.count; index++) {
                    if (index <= 1) {
                        CGRect photoRect =  CGRectMake(0, index * (maxPhotoWidth + inset), maxPhotoHeight, maxPhotoWidth);
                        UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                        photo.contentMode = UIViewContentModeScaleAspectFill;
                        photo.clipsToBounds = YES;
                        photo.image = self.photos[index];
                        photo.tag = index;
                        photo.userInteractionEnabled = YES;
                        [self addSubview: photo];
                        
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                        [photo addGestureRecognizer: tap];
                    } else {
                        CGRect photoRect =  CGRectMake(self.frame.size.width - minPhotoWidth, (index - 2) * (minPhotoWidth + inset), minPhotoWidth, minPhotoWidth);
                        UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                        photo.contentMode = UIViewContentModeScaleAspectFill;
                        photo.clipsToBounds = YES;
                        photo.image = self.photos[index];
                        photo.tag = index;
                        photo.userInteractionEnabled = YES;
                        [self addSubview: photo];
                        
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                        [photo addGestureRecognizer: tap];
                    }
                }
                break;
            }
            
            case BMFivePhotoPointToPointRightLayout:
            {
                for (NSInteger index = 0; index < self.photos.count; index++) {
                    if (index == 0) {
                        CGRect photoRect =  CGRectMake(0, 0, maxPhotoHeight, maxPhotoHeight);
                        UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                        photo.contentMode = UIViewContentModeScaleAspectFill;
                        photo.clipsToBounds = YES;
                        photo.image = self.photos[index];
                        photo.tag = index;
                        photo.userInteractionEnabled = YES;
                        [self addSubview: photo];
                        
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                        [photo addGestureRecognizer: tap];
                    } else if (index == 1) {
                        CGRect photoRect =  CGRectMake(0, maxPhotoHeight + inset, self.frame.size.width - minPhotoWidth - inset, minPhotoWidth);
                        UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                        photo.contentMode = UIViewContentModeScaleAspectFill;
                        photo.clipsToBounds = YES;
                        photo.image = self.photos[index];
                        photo.tag = index;
                        photo.userInteractionEnabled = YES;
                        [self addSubview: photo];
                        
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                        [photo addGestureRecognizer: tap];
                    }else {
                        CGRect photoRect =  CGRectMake(self.frame.size.width - minPhotoWidth, (index - 2) * (minPhotoWidth + inset), minPhotoWidth, minPhotoWidth);
                        UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                        photo.contentMode = UIViewContentModeScaleAspectFill;
                        photo.clipsToBounds = YES;
                        photo.image = self.photos[index];
                        photo.tag = index;
                        photo.userInteractionEnabled = YES;
                        [self addSubview: photo];
                        
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                        [photo addGestureRecognizer: tap];
                    }
                }
                break;
            }
            
            case BMFivePhotoPointToPointBottomLayout:
            {
                for (NSInteger index = 0; index < self.photos.count; index++) {
                    if (index == 0) {
                        CGRect photoRect =  CGRectMake(0, 0, maxPhotoHeight, maxPhotoHeight);
                        UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                        photo.contentMode = UIViewContentModeScaleAspectFill;
                        photo.clipsToBounds = YES;
                        photo.image = self.photos[index];
                        photo.tag = index;
                        photo.userInteractionEnabled = YES;
                        [self addSubview: photo];
                        
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                        [photo addGestureRecognizer: tap];
                    } else if (index == 1) {
                        CGRect photoRect =  CGRectMake(maxPhotoHeight + inset, 0, minPhotoWidth, self.frame.size.height - minPhotoWidth - inset);
                        UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                        photo.contentMode = UIViewContentModeScaleAspectFill;
                        photo.clipsToBounds = YES;
                        photo.image = self.photos[index];
                        photo.tag = index;
                        photo.userInteractionEnabled = YES;
                        [self addSubview: photo];
                        
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                        [photo addGestureRecognizer: tap];
                    }else {
                        CGRect photoRect =  CGRectMake((index - 2) * (minPhotoWidth + inset), self.frame.size.height - minPhotoWidth, minPhotoWidth, minPhotoWidth);
                        UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                        photo.contentMode = UIViewContentModeScaleAspectFill;
                        photo.clipsToBounds = YES;
                        photo.image = self.photos[index];
                        photo.tag = index;
                        photo.userInteractionEnabled = YES;
                        [self addSubview: photo];
                        
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                        [photo addGestureRecognizer: tap];
                    }
                }
                break;
            }
                
            case BMFivePhotoTopToBottomLayout:
            default:
            {
                for (NSInteger index = 0; index < self.photos.count; index++) {
                    if (index <= 1) {
                        CGRect photoRect =  CGRectMake(index * (maxPhotoWidth + inset), 0, maxPhotoWidth, maxPhotoHeight);
                        UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                        photo.contentMode = UIViewContentModeScaleAspectFill;
                        photo.clipsToBounds = YES;
                        photo.image = self.photos[index];
                        photo.tag = index;
                        photo.userInteractionEnabled = YES;
                        [self addSubview: photo];
                        
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                        [photo addGestureRecognizer: tap];
                    } else {
                        CGRect photoRect =  CGRectMake((index - 2) * (minPhotoWidth + inset), self.frame.size.height - minPhotoWidth, minPhotoWidth, minPhotoWidth);
                        UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                        photo.contentMode = UIViewContentModeScaleAspectFill;
                        photo.clipsToBounds = YES;
                        photo.image = self.photos[index];
                        photo.tag = index;
                        photo.userInteractionEnabled = YES;
                        [self addSubview: photo];
                        
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                        [photo addGestureRecognizer: tap];
                    }
                }
                break;
            }
        }
        return;
    }

    if (self.photos.count == 6) {
        switch (self.layoutType) {
            case BMSixPhotoEqualHorizontalLayout:
            {
                CGFloat photoWidth = [self computeBorderValueWithMaxWidth: self.frame.size.width bordersCount: 3 photoInset: inset];
                CGFloat photoHeight = [self computeBorderValueWithMaxWidth: self.frame.size.height bordersCount: 2 photoInset: inset];
                for (NSInteger index = 0; index < self.photos.count; index++) {
                    CGRect photoRect =  CGRectMake((index % 3) * (photoWidth + inset), (index / 3) * photoHeight, photoWidth, photoHeight);
                    UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                    photo.contentMode = UIViewContentModeScaleAspectFill;
                    photo.clipsToBounds = YES;
                    photo.image = self.photos[index];
                    photo.tag = index;
                    photo.userInteractionEnabled = YES;
                    [self addSubview: photo];
                    
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                    [photo addGestureRecognizer: tap];
                }
                break;
            }
            
            case BMSixPhotoEqualVerticalLayout:
            {
                CGFloat photoWidth = [self computeBorderValueWithMaxWidth: self.frame.size.width bordersCount: 2 photoInset: inset];
                CGFloat photoHeight = [self computeBorderValueWithMaxWidth: self.frame.size.height bordersCount: 3 photoInset: inset];
                for (NSInteger index = 0; index < self.photos.count; index++) {
                    CGRect photoRect =  CGRectMake((index / 3) * photoWidth, (index % 3) * (photoHeight + inset), photoWidth, photoHeight);
                    UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                    photo.contentMode = UIViewContentModeScaleAspectFill;
                    photo.clipsToBounds = YES;
                    photo.image = self.photos[index];
                    photo.tag = index;
                    photo.userInteractionEnabled = YES;
                    [self addSubview: photo];
                    
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                    [photo addGestureRecognizer: tap];
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
                        CGRect photoRect =  CGRectMake(0, 0, maxPhotoWidth, maxPhotoWidth);
                        UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                        photo.contentMode = UIViewContentModeScaleAspectFill;
                        photo.clipsToBounds = YES;
                        photo.image = self.photos[index];
                        photo.tag = index;
                        photo.userInteractionEnabled = YES;
                        [self addSubview: photo];
                        
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                        [photo addGestureRecognizer: tap];
                    } else if (index == 1 || index == 2) {
                        CGRect photoRect =  CGRectMake(maxPhotoWidth + inset, (index - 1) * (minPhotoWidth + inset), minPhotoWidth, minPhotoWidth);
                        UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                        photo.contentMode = UIViewContentModeScaleAspectFill;
                        photo.clipsToBounds = YES;
                        photo.image = self.photos[index];
                        photo.tag = index;
                        photo.userInteractionEnabled = YES;
                        [self addSubview: photo];
                        
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                        [photo addGestureRecognizer: tap];
                    } else {
                        CGRect photoRect =  CGRectMake((index - 3) * (minPhotoWidth + inset), maxPhotoWidth + inset, minPhotoWidth, minPhotoWidth);
                        UIImageView *photo = [[UIImageView alloc] initWithFrame: photoRect];
                        photo.contentMode = UIViewContentModeScaleAspectFill;
                        photo.clipsToBounds = YES;
                        photo.image = self.photos[index];
                        photo.tag = index;
                        photo.userInteractionEnabled = YES;
                        [self addSubview: photo];
                        
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTapPhotoEvent:)];
                        [photo addGestureRecognizer: tap];
                    }
                }
                break;
            }
        }
        return;
    }
}

#pragma mark - Event Response

- (void)handleTapPhotoEvent: (UITapGestureRecognizer *)tap {
    if (self.tapPhotoBlock) {
        self.tapPhotoBlock(self.photos, tap.view.tag);
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

@end
