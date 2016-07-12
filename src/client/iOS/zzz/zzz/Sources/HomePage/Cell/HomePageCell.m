//
//  HomePageCell.m
//  zzz
//
//  Created by jashion on 16/6/26.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import "HomePageCell.h"

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
    
    _photoContainer = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, frame.size.width, frame.size.width)];
    _photoContainer.image = [UIImage imageNamed:@"cat.jpg"];
    _photoContainer.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview: _photoContainer];
    
    _photoDes = [[UILabel alloc] initWithFrame: CGRectMake(10, frame.size.width, frame.size.width - 20, frame.size.height - frame.size.width)];
    _photoDes.font = [UIFont systemFontOfSize: 15];
    _photoDes.textColor = [UIColor lightGrayColor];
    _photoDes.text = @"猫叔，一只神奇的🐱，日月不坠，眼眸不开。";
    [self addSubview: _photoDes];
    
    return self;
}

@end

@implementation PostCommentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (!self) {
        return nil;
    }
    return self;
}

@end

@implementation PostToolBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (!self) {
       return nil;
    }
    return self;
}

@end

@implementation HomePageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if (!self) {
        return nil;
    };
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    _postProfileView = [[PostProfileView alloc] initWithFrame: CGRectMake(0, 0, PostProfileSize.width, PostProfileSize.height)];
    _postCardView = [[PostCardView alloc] initWithFrame: CGRectMake(0, 0, PostCardViewSize.width, PostCardViewSize.height)];
    _postCommentView = [[PostCommentView alloc] initWithFrame: CGRectMake(0, PostCardViewSize.height, PostCommentViewSize.width, PostCommentViewSize.height)];
    _postToolBarView = [[PostToolBarView alloc] initWithFrame: CGRectMake(0,PostCardViewSize.height + PostCommentViewSize.height, PostToolBarViewSize.width, PostToolBarViewSize.height)];
    [self.contentView addSubview: _postProfileView];
    [self.contentView addSubview: _postCardView];
    [self.contentView addSubview: _postCommentView];
    [self.contentView addSubview: _postToolBarView];
    return self;
}

@end
