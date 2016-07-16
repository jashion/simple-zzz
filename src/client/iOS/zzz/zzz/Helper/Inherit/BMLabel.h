//
//  BMLabel.h
//  zzz
//
//  Created by jashion on 16/7/15.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BMExternTextAlignment) {
    BMExternTextAlignmentTop        =   0,
    BMExternTextAlignmentMiddle     =   1,
    BMExternTextAlignmentBottom     =   2,
};

@interface BMLabel : UILabel

@property (nonatomic, assign) BMExternTextAlignment externTextAlignment;

@end
