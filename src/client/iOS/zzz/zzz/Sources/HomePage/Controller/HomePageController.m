//
//  HomePageController.m
//  zzz
//
//  Created by jashion on 16/6/26.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import "HomePageController.h"
#import "HomePageView.h"
#import "HomePageCell.h"
#import "UIView+BMAddition.h"

typedef NS_ENUM(NSUInteger, TableViewScrollDirection) {
    TableViewScrollDirectionUp,
    TableViewScrollDirectionDown
};

@interface HomePageController ()<HomePageCellDelegate>

@property (nonatomic, strong) HomePageView *myView;
@property (nonatomic, strong) NSMutableArray *homePageDataArray;
@property (nonatomic, assign) TableViewScrollDirection direction;

@end

@implementation HomePageController

#pragma mark - LifeCycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.navigationItem.title = @"绒么么";
        _homePageDataArray = @[].mutableCopy;
        for (NSInteger index = 0; index < 10; index++) {
            [_homePageDataArray addObject: @(index)];
        }
    }
    return self;
}

- (void)loadView {
    self.view = [[HomePageView alloc] initWithController: self];
    self.myView = (HomePageView *)self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.hidesBarsOnSwipe = YES;
}

#pragma mark - Refresh Data Method

#pragma mark - Network Request

#pragma mark - Network Response

#pragma mark - Public

#pragma mark - Private

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.homePageDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return PostProfileSize.height + PostCardViewSize.height + PostCommentViewSize.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomePageCell *cell = [tableView dequeueReusableCellWithIdentifier: NSStringFromClass([HomePageCell class])];
    cell.delegate = self;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == (self.homePageDataArray.count - 1)) {
        return  0.1;
    }
    return 12;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == (self.homePageDataArray.count - 1)) {
        return nil;
    }
    UIView *separateView = [[UIView alloc] init];
    separateView.size = CGSizeMake(kScreenWidth, 12);
    separateView.backgroundColor = [UIColor colorWithRed:0.941 green:0.937 blue:0.918 alpha:1.000];
    
    CAShapeLayer *topLine = [CAShapeLayer layer];
    topLine.frame = CGRectMake(0, 0, kScreenWidth, onePixel);
    topLine.backgroundColor = [UIColor colorWithRed:0.792 green:0.788 blue:0.769 alpha:1.000].CGColor;
    [separateView.layer insertSublayer: topLine atIndex: 0];
    
    CAShapeLayer *bottomLine = [CAShapeLayer layer];
    bottomLine.frame = CGRectMake(0, 12 - onePixel, kScreenWidth, onePixel);
    bottomLine.backgroundColor = [UIColor colorWithRed:0.792 green:0.788 blue:0.769 alpha:1.000].CGColor;
    [separateView.layer insertSublayer: bottomLine atIndex: 0];
    
    return separateView;
}

#pragma mark - HomePageCellDelegate

- (void)onClickObject:(id)onClickObject withType:(HomePageClickType)clickType {
    switch (clickType) {
        case HomePageClickTypeLike:
        {
            NSLog(@"Like");
            break;
        }
        
        case HomePageClickTypeComment:
        {
            NSLog(@"Comment");
            break;
        }

        case HomePageClickTypeShare:
        {
            NSLog(@"Share");
            break;
        }

        case HomePageClickTypePhoto:
        {
            NSLog(@"Photo");
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - Custom Accessors

#pragma mark - NSCopying

#pragma mark - NSObject


@end
