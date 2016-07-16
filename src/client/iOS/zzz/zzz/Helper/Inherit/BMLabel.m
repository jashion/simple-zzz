//
//  BMLabel.m
//  zzz
//
//  Created by jashion on 16/7/15.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import "BMLabel.h"

@implementation BMLabel

- (void)setExternTextAlignment:(BMExternTextAlignment)externTextAlignment {
    _externTextAlignment = externTextAlignment;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGRect textNormalRect = [self textRectForBounds: rect limitedToNumberOfLines: self.numberOfLines];
    [super drawRect: textNormalRect];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds: bounds limitedToNumberOfLines: numberOfLines];
    switch (self.externTextAlignment) {
        case BMExternTextAlignmentTop:
        {
            textRect.origin.y = bounds.origin.y;
            break;
        }
        
        case BMExternTextAlignmentMiddle:
        {
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2;
            break;
        }

        case BMExternTextAlignmentBottom:
        {
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height);
            break;
        }

        default:
        {
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2;
            break;
        }
    }
    
    return textRect;
}

@end
