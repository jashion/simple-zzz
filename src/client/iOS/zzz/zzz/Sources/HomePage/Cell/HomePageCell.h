//
//  HomePageCell.h
//  zzz
//
//  Created by jashion on 16/6/26.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMPhotosLayoutView.h"

#define PostProfileSize     CGSizeMake(kScreenWidth, 60)
#define PostCardViewSize    CGSizeMake(kScreenWidth, kScreenWidth + 30)
#define PostCommentViewSize CGSizeMake(kScreenWidth, 40 * 4)
#define PostToolBarViewSize CGSizeMake(kScreenWidth, 60)
#define ButtonSize          CGSizeMake(70, 40)

static const NSInteger likeTag = 0;
static const NSInteger commentTag = 1;
static const NSInteger shareTag = 2;

typedef NS_ENUM(NSUInteger, HomePageClickType) {
    HomePageClickTypeLike       =   0,
    HomePageClickTypeComment    =   1,
    HomePageClickTypeShare      =   2,
    HomePageClickTypePhoto      =   3,
    HomePageClickTypeUrl        =   4
};

@class HomePageCell;
@protocol HomePageCellDelegate;

@interface PostProfileView : UIView

@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *nickName;
@property (nonatomic, strong) UILabel *createDate;
@property (nonatomic, weak) HomePageCell *cell;

@end

@interface PostCardView: UIView

@property (nonatomic, strong) BMPhotosLayoutView *photoContainer;
@property (nonatomic, strong) UILabel *photoDes;
@property (nonatomic, weak) HomePageCell *cell;

@end

@interface PostCommentView : UIView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIButton *like;
@property (nonatomic, strong) UIImageView *likeIcon;
@property (nonatomic, strong) UILabel *likeNum;
@property (nonatomic, strong) UIButton *comment;
@property (nonatomic, strong) UIImageView *commentIcon;
@property (nonatomic, strong) UILabel *commentNum;
@property (nonatomic, strong) UIButton *share;
@property (nonatomic, strong) UIImageView *shareIcon;
@property (nonatomic, strong) UITableView *commentContainer;
@property (nonatomic, weak) HomePageCell *cell;

@end

@interface HomePageCell : UITableViewCell

@property (nonatomic, weak) id<HomePageCellDelegate> delegate;
@property (nonatomic, strong) PostProfileView *postProfileView;
@property (nonatomic, strong) PostCardView *postCardView;
@property (nonatomic, strong) PostCommentView *postCommentView;

- (void)setupPhotos: (NSDictionary *)photosDict;

@end

@protocol HomePageCellDelegate <NSObject>

- (void)onClickObject: (id)onClickObject withType: (HomePageClickType)clickType;

@end
