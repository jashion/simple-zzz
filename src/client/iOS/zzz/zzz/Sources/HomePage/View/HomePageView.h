//
//  HomePageView.h
//  zzz
//
//  Created by jashion on 16/6/26.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageView : UIView

@property (nonatomic, strong) UITableView *homePageTableView;

- (instancetype)initWithController: (UIViewController *)controller;

@end
