//
//  BMMacro.h
//  zzz
//
//  Created by jashion on 16/7/3.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef BMMacro_h
#define BMMacro_h

#ifdef __cplusplus
    #define BM_EXTERN_C_BEGIN extern "C" {
    #define BM_EXTERN_C_END }
#else
    #define BM_EXTERN_C_BEGIN
    #define BM_EXTERN_C_END
#endif

BM_EXTERN_C_BEGIN

/**
 Synthsize a weak or strong reference
 
 Example:
    @weakify(self)
    [self doSomething^{
        if(!self) return;
        @strongify(self)
        doSomething
        ...
    }];
 */

#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define weakify(object) try{} @finally{} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) try{} @finally{} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif

//Return a dispatch_time delay from now.
static inline dispatch_time_t dispatch_time_delay(NSTimeInterval second) {
    return dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC));
}

BM_EXTERN_C_END

#endif /* BMMacro_h */
