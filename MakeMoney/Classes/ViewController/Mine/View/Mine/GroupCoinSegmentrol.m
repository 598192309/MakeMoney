//
//  GroupCoinSegmentrol.m
//  Encropy
//
//  Created by Lqq on 2019/8/20.
//  Copyright © 2019 Lq. All rights reserved.
//  组合 单币 Segmentrol

#import "GroupCoinSegmentrol.h"

@interface GroupCoinSegmentrol ()
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSMutableArray *buttonsWidths;
@property (nonatomic, assign) NSInteger originIndex;
@property (nonatomic, strong) UIView *indicateView;
@end

@implementation GroupCoinSegmentrol

- (void)setTitleSelectedColor:(UIColor *)titleSelectedColor{
    _titleSelectedColor = titleSelectedColor;
    self.selectedIndex = 0;

}

- (void)setTitleNormalColor:(UIColor *)titleNormalColor{
    _titleNormalColor = titleNormalColor;
}

- (void)setIndicateViewWidth:(CGFloat)indicateViewWidth{
    _indicateViewWidth = indicateViewWidth;
}

- (UIView *)indicateView
{
    if (_indicateView == nil) {
        _indicateView = [[UIView alloc] init];
        _indicateView.backgroundColor = TitleWhiteColor;
        
        [self addSubview:_indicateView];
    }
    return _indicateView;
}
- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (NSMutableArray *)buttonsWidths
{
    if (_buttonsWidths == nil) {
        _buttonsWidths = [NSMutableArray array];
    }
    return _buttonsWidths;
}


- (instancetype)initWithTitleItems:(NSArray *)items
{
    self = [super init];
    if (self) {
        for (int i = 0 ; i < items.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:items[i] forState:UIControlStateNormal];
            [btn setTitleColor:_titleNormalColor ? _titleNormalColor : TitleGrayColor forState:UIControlStateNormal];
            btn.titleLabel.font = AdaptedFontSize(17);
            [btn addTarget:self action:@selector(butClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.buttons safeAddObject:btn];
            [self addSubview:btn];
            
            [btn sizeToFit];
            [self.buttonsWidths safeAddObject:@(btn.frame.size.width + 20)];
            
        }
        self.backgroundColor = [UIColor clearColor];
        
        
        _originIndex = 1;
        self.selectedIndex = 0;
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat btnWidth = self.frame.size.width / self.buttons.count;
    for (int i= 0 ; i < self.buttons.count; ++i) {
        UIButton *btn = self.buttons[i];
        btn.frame = CGRectMake(i * btnWidth, 0, btnWidth, self.frame.size.height);
        if (i != self.selectedIndex) {
            [btn setTitleColor:_titleNormalColor ? _titleNormalColor : TitleGrayColor forState:UIControlStateNormal];
        }
    }
//    _indicateView.frame = CGRectMake(0, self.lq_height - 2, self.indicateViewWidth > 0 ? self.indicateViewWidth : Adaptor_Value(15), Adaptor_Value(4));
    if (self.indicateViewWidth > 0) {
        _indicateView.frame = CGRectMake(0, self.lq_height - 2,  self.indicateViewWidth, Adaptor_Value(4));
    }else{
        _indicateView.frame = CGRectMake(0, self.lq_height - 2,  Adaptor_Value(15), Adaptor_Value(4));

    }
    ViewRadius(_indicateView, Adaptor_Value(2));
    _indicateView.lq_centerX = (btnWidth)*0.5;

}

- (void)butClicked:(UIButton *)btn
{
    NSInteger newIndex = [self.buttons indexOfObject:btn];
    NSInteger originIndex = self.selectedIndex;
    if (originIndex == newIndex) {
        return;
    }
    
    [self setSelectedIndex:newIndex];
    if (self.selectedIndexBlock) {
        self.selectedIndexBlock(originIndex ,newIndex);
    }
    
}


- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    [self changeButtonsStatusSelectIndex:_selectedIndex originIndex:_originIndex];
    _originIndex = selectedIndex;
}


- (void)changeButtonsStatusSelectIndex:(NSInteger)selectIndex originIndex:(NSInteger)originIndex
{
    UIButton *originBtn = self.buttons[originIndex];
    UIButton *selectBtn = self.buttons[selectIndex];
    [originBtn setTitleColor:_titleNormalColor ? _titleNormalColor : TitleGrayColor forState:UIControlStateNormal];
    
    [selectBtn setTitleColor:self.titleSelectedColor ? self.titleSelectedColor : TitleWhiteColor forState:UIControlStateNormal];
    
    CGFloat btnWidth = self.frame.size.width / self.buttons.count;
    [UIView animateWithDuration:0.1 animations:^{
//        self.indicateView.frame = CGRectMake(selectIndex * btnWidth, self.lq_height - 2, Adaptor_Value(15), Adaptor_Value(4));
        self.indicateView.lq_centerX = selectBtn.lq_x + (btnWidth )*0.5;
    }];
}@end
