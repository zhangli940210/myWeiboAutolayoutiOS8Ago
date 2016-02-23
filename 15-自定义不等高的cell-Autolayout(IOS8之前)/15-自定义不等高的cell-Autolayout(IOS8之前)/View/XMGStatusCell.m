//
//  XMGStatusCell.m
//  12-自定义不等高的cell-frame01-
//
//  Created by xiaomage on 16/1/30.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGStatusCell.h"
#import "XMGStatus.h"

//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface XMGStatusCell ()
/** 图像*/
@property (nonatomic ,weak)UIImageView *iconImageView;

/** 昵称*/
@property (nonatomic ,weak)UILabel *nameLabel;

/** vip*/
@property (nonatomic ,weak)UIImageView *vipImageView;

/** 正文*/
@property (nonatomic ,weak)UILabel *text_Label;

/** 配图*/
@property (nonatomic ,weak)UIImageView *pictureImageView;
@end

@implementation XMGStatusCell

// 把所有有可能显示的子控件都先添加进去
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat space = 10;
        // 图像
        UIImageView *iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconImageView];
        self.iconImageView = iconImageView;
        // 添加约束
        [iconImageView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.left).offset(space);
            make.top.equalTo(self.contentView.top).offset(space);
            make.width.equalTo(40);
            make.height.equalTo(40);
        }];
        
        // 昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = XMGNameFont;
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        // 添加约束
        [nameLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconImageView.right).offset(space);
            make.top.equalTo(iconImageView.top);
            make.width.lessThanOrEqualTo(120);
        }];
        
        // vip
        UIImageView *vipImageView = [[UIImageView alloc] init];
        vipImageView.image = [UIImage imageNamed:@"vip"];
        vipImageView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:vipImageView];
        self.vipImageView = vipImageView;
        // 添加约束
        [vipImageView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLabel.right).offset(space);
            make.top.equalTo(iconImageView.top);
            make.width.equalTo(16);
            make.height.equalTo(nameLabel.height);
        }];
        
        // 正文
        UILabel *text_Label = [[UILabel alloc] init];
        text_Label.font = XMGTextFont;
        text_Label.numberOfLines = 0;
        [self.contentView addSubview:text_Label];
        // 手动设置label的文字的最大宽度(目的:为了能够计算label的高度,得到最真实的尺寸)
        text_Label.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 20;
        self.text_Label = text_Label;
        // 添加约束
        [text_Label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconImageView.left);
            make.top.equalTo(iconImageView.bottom).offset(space);
            make.right.equalTo(self.contentView).offset(-space);
        }];
        
        // 配图
        UIImageView *pictureImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:pictureImageView];
        self.pictureImageView = pictureImageView;
        // 添加约束
        [pictureImageView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(text_Label.bottom).offset(space);
            make.left.equalTo(iconImageView.left);
            make.width.equalTo(100);
            make.height.equalTo(100);
        }];
        
    }
    return self;
}

// 设置数据
- (void)setStatus:(XMGStatus *)status
{
    _status = status;
    self.iconImageView.image = [UIImage imageNamed:status.icon];
    
    self.nameLabel.text = status.name;
    
    if (status.isVip) { // 是VIP
        self.vipImageView.hidden = NO;
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        self.vipImageView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    self.text_Label.text = status.text;
    
    if (status.picture) { // 有配图
        self.pictureImageView.hidden = NO;
        self.pictureImageView.image = [UIImage imageNamed:status.picture];
    } else {
        self.pictureImageView.hidden = YES;
    }
}

- (CGFloat)cellHeight
{
    // 强制布局(目的:让label根据设置的约束计算自己最真实尺寸)
    [self layoutIfNeeded];
    
    CGFloat cellHeight = 0;
    
    if (self.status.picture) { // 有配图
        cellHeight = CGRectGetMaxY(self.pictureImageView.frame) + 10;
    } else {
        cellHeight = CGRectGetMaxY(self.text_Label.frame) + 10;
    }
    return cellHeight;
}

@end
