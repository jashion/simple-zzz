//
//  HomePageCell.m
//  zzz
//
//  Created by jashion on 16/6/26.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import "HomePageCell.h"
#import "UIColorUtils.h"
#import "UIView+BMAddition.h"
#import "BMLabel.h"

@implementation PostProfileView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (!self) {
        return nil;
    }
    
    _avatar = [[UIImageView alloc] initWithFrame: CGRectMake(10, 10, 40, 40)];
    _avatar.backgroundColor = [UIColor grayColor];
    _avatar.image = [UIImage imageNamed:@"cat.jpg"];
    _avatar.contentMode = UIViewContentModeScaleToFill;
    _avatar.clipsToBounds = YES;
    _avatar.layer.cornerRadius = 20;
    [self addSubview: _avatar];
    
    _nickName = [[UILabel alloc] initWithFrame: CGRectMake(60, 0, frame.size.width - 140, frame.size.height)];
    _nickName.font = [UIFont systemFontOfSize: 14];
    _nickName.textColor = [UIColor blackColor];
    _nickName.textAlignment = NSTextAlignmentLeft;
    _nickName.text = @"猫叔";
    [self addSubview: _nickName];
    
    _createDate = [[UILabel alloc] initWithFrame: CGRectMake(frame.size.width - 90, 0, 80, frame.size.height)];
    _createDate.font = [UIFont systemFontOfSize: 14];
    _createDate.textColor = [UIColor blackColor];
    _createDate.textAlignment = NSTextAlignmentRight;
    _createDate.text = @"2016/6/1";
    [self addSubview: _createDate];

    return self;
}

@end

@implementation PostCardView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (!self) {
        return nil;
    }
    
    _photoContainer = [[BMPhotosLayoutView alloc] initWithFrame: CGRectMake(0, 0, frame.size.width, frame.size.width) photos: @[] layoutType: BMFivePhotoPointToPointBottomLayout];
    _photoContainer.tapPhotoBlock = ^(NSArray *photos, NSInteger currentIndex, BMPhotosLayoutView *photoLayoutView){
        NSLog(@"currentIndex: %ld", currentIndex);
    };
    [self addSubview: _photoContainer];
    
    _photoDes = [[UILabel alloc] initWithFrame: CGRectMake(10, frame.size.width, frame.size.width - 20, frame.size.height - frame.size.width)];
    _photoDes.font = [UIFont systemFontOfSize: 15];
    _photoDes.textColor = [UIColorUtils contentTextColor];
    _photoDes.text = @"猫叔，一只神奇的🐱，日月不坠，眼眸不开。";
    [self addSubview: _photoDes];
    
    CAShapeLayer *bottomLine = [CAShapeLayer layer];
    bottomLine.frame = CGRectMake(10, frame.size.height - 1 / kScreenScale, frame.size.width - 20, 1 / kScreenScale);
    bottomLine.backgroundColor = [UIColorUtils graySeparateLineColor].CGColor;
    [self.layer insertSublayer: bottomLine atIndex: 0];
    
    return self;
}

#pragma mark - Event Response

- (void)handleClickEvent: (id)sender {
    
}

@end

@implementation PostCommentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (!self) {
        return nil;
    }
    
    [self addSubview: self.like];
    [self addSubview: self.comment];
    [self addSubview: self.share];
    [self addSubview: self.commentContainer];
    
    return self;
}

#pragma mark - Event Response

- (void)handleClickEvent: (id)sender {
    if ([sender isKindOfClass: [UIButton class]]) {
        if (self.cell.delegate && [self.cell.delegate respondsToSelector: @selector(onClickObject:withType:)]) {
            UIButton *button = (UIButton *)sender;
            switch (button.tag) {
                case likeTag:
                {
                    [self.cell.delegate onClickObject: sender withType: HomePageClickTypeLike];
                    break;
                }
                    
                case commentTag:
                {
                    [self.cell.delegate onClickObject: sender withType: HomePageClickTypeComment];
                    break;
                }
                    
                case shareTag:
                {
                    [self.cell.delegate onClickObject: sender withType: HomePageClickTypeShare];
                    break;
                }
                    
                default:
                    break;
            }
        }
        return;
    }
}

#pragma mark - Custome Accessors

- (UITableView *)commentContainer {
    if (!_commentContainer) {
        _commentContainer = [[UITableView alloc] initWithFrame: CGRectMake(0, 40, kScreenWidth, 120) style: UITableViewStylePlain];
        _commentContainer.dataSource = self;
        _commentContainer.delegate = self;
        _commentContainer.separatorStyle = UITableViewCellSeparatorStyleNone;
        _commentContainer.scrollEnabled = NO;
    }
    return _commentContainer;
}

- (UIButton *)like {
    if (!_like) {
        _like = [UIButton buttonWithType: UIButtonTypeCustom];
        _like.size = ButtonSize;
        _like.tag = likeTag;
        [_like addTarget: self action: @selector(handleClickEvent:) forControlEvents: UIControlEventTouchUpInside];
        self.likeIcon = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"Like_Icon"]];
        self.likeIcon.right = _like.width / 2 - 5;
        self.likeIcon.centerY = _like.height / 2;
        [_like addSubview: self.likeIcon];
        self.likeNum = [[UILabel alloc] init];
        self.likeNum.size = CGSizeMake(ButtonSize.width / 2, ButtonSize.height);
        self.likeNum.left = _like.width / 2;
        self.likeNum.textColor = [UIColorUtils commentTextColor];
        self.likeNum.font = [UIFont systemFontOfSize: 15];
        self.likeNum.textAlignment = NSTextAlignmentCenter & NSTextAlignmentLeft;
        self.likeNum.text = @"520";
        [_like addSubview: self.likeNum];
    }
    return _like;
}

- (UIButton *)comment {
    if (!_comment) {
        _comment = [UIButton buttonWithType: UIButtonTypeCustom];
        _comment.size = ButtonSize;
        _comment.tag = commentTag;
        [_comment addTarget: self action: @selector(handleClickEvent:) forControlEvents: UIControlEventTouchUpInside];
        _comment.left = self.like.right;
        self.commentIcon = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"Comment_Icon"]];
        self.commentIcon.right = _comment.width / 2 - 5;
        self.commentIcon.centerY = _comment.height / 2;
        [_comment addSubview: self.commentIcon];
        self.commentNum = [[UILabel alloc] init];
        self.commentNum.size = CGSizeMake(ButtonSize.width / 2, ButtonSize.height);
        self.commentNum.left = _comment.width / 2;
        self.commentNum.textColor = [UIColorUtils commentTextColor];
        self.commentNum.font = [UIFont systemFontOfSize: 15];
        self.commentNum.textAlignment = NSTextAlignmentLeft;
        self.commentNum.text = @"125";
        [_comment addSubview: self.commentNum];
    }
    return _comment;
}

- (UIButton *)share {
    if (!_share) {
        _share = [UIButton buttonWithType: UIButtonTypeCustom];
        _share.size = ButtonSize;
        _share.tag = shareTag;
        [_share addTarget: self action: @selector(handleClickEvent:) forControlEvents: UIControlEventTouchUpInside];
        _share.right = self.width;
        self.shareIcon = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"Share_Icon"]];
        self.shareIcon.center = CGPointMake(ButtonSize.width / 2, ButtonSize.height / 2);
        [_share addSubview: self.shareIcon];
    }
    return _share;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"commentCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    BMLabel *commentText = [[BMLabel alloc] initWithFrame: CGRectMake(10, 0, kScreenWidth - 20, 30)];
    commentText.textAlignment = NSTextAlignmentLeft;
    if (indexPath.item != 3) {
        commentText.textColor = [UIColorUtils commentTextColor];
        commentText.externTextAlignment = BMExternTextAlignmentMiddle;
        commentText.font = [UIFont systemFontOfSize: 15];
        commentText.text = @"猫叔：@摩奥 好帅的一只猫！";
    } else {
        commentText.textColor = [UIColorUtils checkMoreCommentTextColor];
        commentText.externTextAlignment = BMExternTextAlignmentTop;
        commentText.font = [UIFont systemFontOfSize: 12];
        commentText.text = @"查看所有103条评论";
    }
    [cell.contentView addSubview: commentText];
    
    return cell;
}

#pragma mark - UITableViewDelegate

@end

@implementation HomePageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if (!self) {
        return nil;
    };
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _postProfileView = [[PostProfileView alloc] initWithFrame: CGRectMake(0, 0, PostProfileSize.width, PostProfileSize.height)];
    _postProfileView.cell = self;
    _postCardView = [[PostCardView alloc] initWithFrame: CGRectMake(0, PostProfileSize.height, PostCardViewSize.width, PostCardViewSize.height)];
    _postCardView.cell = self;
    _postCommentView = [[PostCommentView alloc] initWithFrame: CGRectMake(0, PostProfileSize.height + PostCardViewSize.height, PostCommentViewSize.width, PostCommentViewSize.height)];
    _postCommentView.cell = self;
    [self.contentView addSubview: _postProfileView];
    [self.contentView addSubview: _postCardView];
    [self.contentView addSubview: _postCommentView];
    return self;
}

- (void)setupPhotos: (NSDictionary *)photosDict {
    [self.postCardView.photoContainer setUpPhotos: [photosDict objectForKey: @"photos"] layoutType: [[photosDict objectForKey: @"type"] integerValue]];
}

@end
