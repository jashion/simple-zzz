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

typedef NS_ENUM(NSUInteger, TableViewScrollDirection) {
    TableViewScrollDirectionUp,
    TableViewScrollDirectionDown
};

@interface HomePageController ()

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
    }
    return self;
}

- (void)loadView {
    self.view = [[HomePageView alloc] initWithController: self];
    self.myView = (HomePageView *)self.view;
}

#pragma mark - Refresh Data Method

#pragma mark - Network Request

#pragma mark - Network Response

#pragma mark - Public

#pragma mark - Private

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return PostProfileSize.height + PostCardViewSize.height + PostCommentViewSize.height + PostToolBarViewSize.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomePageCell *cell = [tableView dequeueReusableCellWithIdentifier: NSStringFromClass([HomePageCell class])];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1 / [UIScreen mainScreen].scale;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *postProfileView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, BMScreenSize.width, 60)];
    postProfileView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *avatar = [[UIImageView alloc] initWithFrame: CGRectMake(10, 10, 40, 40)];
    avatar.backgroundColor = [UIColor grayColor];
    avatar.image = [UIImage imageNamed:@"cat.jpg"];
    avatar.contentMode = UIViewContentModeScaleToFill;
    avatar.clipsToBounds = YES;
    avatar.layer.cornerRadius = 20;
    [postProfileView addSubview: avatar];
    
    UILabel *nickName = [[UILabel alloc] initWithFrame: CGRectMake(60, 0, postProfileView.frame.size.width - 140, postProfileView.frame.size.height)];
    nickName.font = [UIFont systemFontOfSize: 14];
    nickName.textColor = [UIColor blackColor];
    nickName.textAlignment = NSTextAlignmentLeft;
    nickName.text = @"猫叔";
    [postProfileView addSubview: nickName];
    
    UILabel *postCreateDate = [[UILabel alloc] initWithFrame: CGRectMake(postProfileView.frame.size.width - 90, 0, 80, postProfileView.frame.size.height)];
    postCreateDate.font = [UIFont systemFontOfSize: 14];
    postCreateDate.textColor = [UIColor blackColor];
    postCreateDate.textAlignment = NSTextAlignmentRight;
    postCreateDate.text = @"2016/6/1";
    [postProfileView addSubview: postCreateDate];
    return postProfileView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = [[UIView alloc] initWithFrame: CGRectMake(0, 0, BMScreenSize.width, 1 / [UIScreen mainScreen].scale)];
    footer.backgroundColor = [UIColor lightGrayColor];
    return footer;
}

#pragma mark - Custom DataSource Or Delegate

#pragma mark - Custom Accessors

#pragma mark - NSCopying

#pragma mark - NSObject


@end
