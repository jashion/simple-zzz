//
//  HomePageView.m
//  zzz
//
//  Created by jashion on 16/6/26.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import "HomePageView.h"
#import "HomePageController.h"
#import "HomePageCell.h"

@interface HomePageView ()

@property (nonatomic, weak) HomePageController *controller;
@property (nonatomic, copy) void(^block)();

@end

@implementation HomePageView

- (instancetype)initWithController: (UIViewController *)controller {
	self = [super init];
    if (self) {
        _controller = (HomePageController *)controller;
        self.backgroundColor = [UIColor whiteColor];
        [self initalizeView];
    }
    return self;
}

- (void)initalizeView {
    _homePageTableView = [[UITableView alloc] initWithFrame: [UIScreen mainScreen].bounds style: UITableViewStylePlain];
    _homePageTableView.backgroundColor = [UIColor whiteColor];
    _homePageTableView.dataSource = _controller;
    _homePageTableView.delegate = _controller;
    _homePageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_homePageTableView registerClass: [HomePageCell class] forCellReuseIdentifier: NSStringFromClass([HomePageCell class])];
    [self addSubview: _homePageTableView];
}

@end
