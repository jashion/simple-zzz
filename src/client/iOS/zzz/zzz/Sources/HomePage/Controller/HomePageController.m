//
//  HomePageController.m
//  zzz
//
//  Created by jashion on 16/6/26.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import "HomePageController.h"
#import "HomePageView.h"

@interface HomePageController ()

@property (nonatomic, strong) HomePageView *myView;

@end

@implementation HomePageController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.navigationItem.title = @"ZZZ";
    }
    return self;
}

- (void)loadView {
    self.view = [[HomePageView alloc] initWithController: self];
    self.myView = (HomePageView *)self.view;
}

@end
