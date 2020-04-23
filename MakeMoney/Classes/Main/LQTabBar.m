//
//  LQTabBar.m
//  MakeMoney
//
//  Created by rabi on 2020/4/23.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "LQTabBar.h"

@interface LQTabBar ()<LXTabBarItemDelegate>

@end
@implementation LQTabBar

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    // 移除系统的tabBarItem
    Class class = NSClassFromString(@"UITabBarButton");
    for (UIView *item in self.subviews) {
        if ([item isKindOfClass:class]) {
        [item removeFromSuperview];
    }
    }
    // 设置自定义的tabBarItem
    [self setupItems];
}

- (void)setupItems {
    CGFloat width = CGRectGetWidth(self.frame)/self.items.count;
    CGFloat height = CGRectGetHeight(self.frame);
    for (int i = 0; i < self.lzItems.count; i++) {
        LXTabBarItem *item = [self.lzItems objectAtIndex:i];
        item.frame = CGRectMake(i*width, 0, width, height);
        [self addSubview:item];
        item.delegate = self;
        }
}

- (void)tabBarItem:(LXTabBarItem *)item didSelectIndex:(NSInteger)index {
    if (self.lzDelegate && [self.lzDelegate respondsToSelector:@selector(tabBar:didSelectItem:atIndex:)]) {
        [self.lzDelegate tabBar:self didSelectItem:item atIndex:index];
        }
}


@end


static NSInteger defaultTag = 100000;
@interface LXTabBarItem ()

@property (nonatomic, strong)UIImageView *iconImageView;
@property (nonatomic, strong)UILabel *titleLabel;
@end

@implementation LXTabBarItem
- (instancetype)init {
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemClicked:)];
        [self addGestureRecognizer:tap];
        }
    return self;
}
// 重写setTag方法
- (void)setTag:(NSInteger)tag {
    [super setTag:tag + defaultTag];
}

- (UIImageView *)iconImageView {
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_iconImageView];
        }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
     _titleLabel = [[UILabel alloc]init];
     _titleLabel.textAlignment = NSTextAlignmentCenter;
     _titleLabel.font = [UIFont systemFontOfSize:10];
     _titleLabel.numberOfLines = 0;
     _titleLabel.textColor = [UIColor grayColor];
    [self addSubview:_titleLabel];
    }

    return _titleLabel;
}

- (void)setIcon:(NSString *)icon {
    _icon = icon;

    self.iconImageView.image = [UIImage imageNamed:icon];

}

- (void)setTitle:(NSString *)title {
    _title = title;

    self.titleLabel.text = title;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;

    self.titleLabel.textColor = titleColor;
}
- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat space = 6.0;

    if (self.icon.length > 0 && self.title.length > 0) {

    CGFloat iconHeight = (CGRectGetHeight(self.frame) - space * 3)*2/3.0 ;
    self.iconImageView.frame = CGRectMake(space, space, CGRectGetWidth(self.frame) - 2 * space, iconHeight);
    self.titleLabel.frame = CGRectMake(space, CGRectGetMaxY(self.iconImageView.frame) + space, CGRectGetWidth(self.frame) - 2*space, iconHeight/2.0);
    } else if (self.icon.length > 0) {

    self.iconImageView.frame = CGRectMake(2, 2, CGRectGetWidth(self.frame) - 4, CGRectGetHeight(self.frame) - 4);
    } else if (self.title.length > 0) {

    self.titleLabel.frame = CGRectMake(2, CGRectGetHeight(self.frame) - 22, CGRectGetWidth(self.frame) - 4, 20);
    }
}

- (void)itemClicked:(UITapGestureRecognizer *)tap {

    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarItem:didSelectIndex:)]) {

    [self.delegate tabBarItem:self didSelectIndex:self.tag - defaultTag];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
// Drawing code
}
*/

@end
