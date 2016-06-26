//
//  HomePageView.m
//  zzz
//
//  Created by jashion on 16/6/26.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import "HomePageView.h"
#import "HomePageController.h"

@interface HomePageView ()

@property (nonatomic, strong) HomePageController *controller;

@end

@implementation HomePageView

- (instancetype)initWithController: (UIViewController *)controller {
	self = [super init];
    if (self) {
        _controller = (HomePageController *)controller;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end
