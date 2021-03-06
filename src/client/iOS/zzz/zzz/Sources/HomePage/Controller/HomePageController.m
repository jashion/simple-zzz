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

#define HomePageTest

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
        _homePageDataArray = [@[] mutableCopy];

#ifdef HomePageTest
        NSArray *photos = @[@{@"photos" : @[[UIImage imageNamed: @"cat.jpg"]],
                              @"type"   : @(0)},
                            @{@"photos" : @[[UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"]],
                              @"type"   : @(1)},
                            @{@"photos" : @[[UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"]],
                              @"type"   : @(2)},
                            @{@"photos" : @[[UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"]],
                              @"type"   : @(3)},
                            @{@"photos" : @[[UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"]],
                              @"type"   : @(4)},
                            @{@"photos" : @[[UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"]],
                              @"type"   : @(5)},
                            @{@"photos" : @[[UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"]],
                              @"type"   : @(6)},
                            @{@"photos" : @[[UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"]],
                              @"type"   : @(7)},
                            @{@"photos" : @[[UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"]],
                              @"type"   : @(8)},
                            @{@"photos" : @[[UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"]],
                              @"type"   : @(9)},
                            @{@"photos" : @[[UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"]],
                              @"type"   : @(10)},
                            @{@"photos" : @[[UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"]],
                              @"type"   : @(11)},
                            @{@"photos" : @[[UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"]],
                              @"type"   : @(12)},
                            @{@"photos" : @[[UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"]],
                              @"type"   : @(13)},
                            @{@"photos" : @[[UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"]],
                              @"type"   : @(14)},
                            @{@"photos" : @[[UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"]],
                              @"type"   : @(15)},
                            @{@"photos" : @[[UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"]],
                              @"type"   : @(16)},
                            @{@"photos" : @[[UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"]],
                              @"type"   : @(17)},
                            @{@"photos" : @[[UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"]],
                              @"type"   : @(18)},
                            @{@"photos" : @[[UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"]],
                              @"type"   : @(19)},
                            @{@"photos" : @[[UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"]],
                              @"type"   : @(20)},
                            @{@"photos" : @[[UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"], [UIImage imageNamed: @"cat.jpg"]],
                              @"type"   : @(21)}];
        [_homePageDataArray addObjectsFromArray: photos];
        
#endif
    }
    return self;
}

- (void)loadView {
    self.view = [[HomePageView alloc] initWithController: self];
    self.myView = (HomePageView *)self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [cell setupPhotos: self.homePageDataArray[indexPath.section]];
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
