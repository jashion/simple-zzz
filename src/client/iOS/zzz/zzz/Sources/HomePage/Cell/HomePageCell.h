//
//  HomePageCell.h
//  zzz
//
//  Created by jashion on 16/6/26.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BMScreenSize        [UIScreen mainScreen].bounds.size
#define PostProfileSize     CGSizeMake(BMScreenSize.width, 60)
#define PostCardViewSize    CGSizeMake(BMScreenSize.width, BMScreenSize.width + 30)
#define PostCommentViewSize CGSizeMake(BMScreenSize.width, 50 * 3)
#define PostToolBarViewSize CGSizeMake(BMScreenSize.width, 60)

@class HomePageCell;
@protocol HomePageCellDelegate;

@interface PostProfileView : UIView

@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *nickName;
@property (nonatomic, strong) UILabel *createDate;
@property (nonatomic, weak) HomePageCell *cell;

@end

@interface PostCardView: UIView

@property (nonatomic, strong) UIImageView *photoContainer;
@property (nonatomic, strong) UILabel *photoDes;
@property (nonatomic, weak) HomePageCell *cell;

@end

@interface PostCommentView : UIView

@property (nonatomic, strong) UITableView *commentContainer;
@property (nonatomic, weak) HomePageCell *cell;


@end

@interface PostToolBarView : UIView

@property (nonatomic, strong) UIButton *comment;
@property (nonatomic, strong) UIButton *like;
@property (nonatomic, strong) UIButton *share;
@property (nonatomic, weak) HomePageCell *cell;


@end

@interface HomePageCell : UITableViewCell

@property (nonatomic, weak) id<HomePageCellDelegate> delegate;
@property (nonatomic, strong) PostProfileView *postProfileView;
@property (nonatomic, strong) PostCardView *postCardView;
@property (nonatomic, strong) PostCommentView *postCommentView;
@property (nonatomic, strong) PostToolBarView *postToolBarView;

@end

@protocol HomePageCellDelegate <NSObject>


@end
