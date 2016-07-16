//
//  BMUtility.h
//  zzz
//
//  Created by jashion on 16/7/14.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMMacro.h"

BM_EXTERN_C_BEGIN

//Get main screen's scale.
CGFloat BMScreenScale();

//Get main screen's size.(Portrait)
CGSize BMScreenSize();

//Get main screen's scale.
#ifndef kScreenScale
#define kScreenScale BMScreenScale()
#endif

//Get main screen's size.(Portrait)
#ifndef kScreenSize
#define kScreenSize BMScreenSize()
#endif

//Get main screen's width.(Portrait)
#ifndef kScreenWidth
#define kScreenWidth BMScreenSize().width
#endif

//Get main screen's height.(Portrait)
#ifndef kScreenHeight
#define kScreenHeight BMScreenSize().height
#endif

#ifndef onePixel
#define onePixel (1 / kScreenScale)
#endif

BM_EXTERN_C_END


