//
//  CityCell.m
//  MakeMoney
//
//  Created by rabi on 2020/2/28.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "CityCell.h"
#import "CityItem.h"
@interface CityCell()
@property (nonatomic,strong) UIView * cellBackgroundView;
@property (strong, nonatomic)  UILabel *titleLabel;
@property (strong, nonatomic)  UIImageView *imageV;
@property (nonatomic,strong)CityListItem *item;

@end
@implementation CityCell

#pragma mark - 生命周期
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configUI];
        self.backgroundColor = [UIColor clearColor];

    }
    return self;
}


- (void)configUI{
    [self.contentView addSubview:self.cellBackgroundView];
    __weak __typeof(self) weakSelf = self;
    [self.cellBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.contentView);
    }];
    
}




- (void)refreshWithItem:(CityListItem *)item {
    _titleLabel.text = item.title;
    
     /**
      
     对应参数如下
     /api/v_imgs         vId=                   短视频
     /api/a_imgs         aId=                   av
     /api/qm_imgs      qmId=                同城
     /api/vt_imgs        vtId=                  全部分类
     /api/s_imgs         sId=                   专题
      */
    self.item = item;
     self.imageV.image = nil;
    __weak __typeof(self) weakSelf = self;
     [HomeApi downImageWithType:@"qm_imgs" paramTitle:@"qmId" ID:item.ID key:@"tongcheng" Success:^(UIImage * _Nonnull img,NSString *ID) {
         if ([weakSelf.item.ID isEqualToString:ID]) {
             weakSelf.imageV.image = img;
         }
     } error:^(NSError *error, id resultObject) {
         
     }];
    
}
#pragma mark - act

#pragma mark - lazy
- (UIView *)cellBackgroundView{
    if (!_cellBackgroundView) {
        _cellBackgroundView = [UIView new];
        UIView *contentV = [UIView new];
        __weak __typeof(self) weakSelf = self;
        [_cellBackgroundView addSubview:contentV];
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.cellBackgroundView);
        }];
        contentV.backgroundColor = ThemeBlackColor;

        _imageV = [[UIImageView alloc] init];
        _imageV.backgroundColor = TitleGrayColor;
        [contentV addSubview:_imageV];
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(contentV);
            make.height.mas_equalTo(Adaptor_Value(180));
        }];

        UIView *titleBackWhiteView = [UIView new];
        titleBackWhiteView.backgroundColor = TitleWhiteColor;
        [contentV addSubview:titleBackWhiteView];
        [titleBackWhiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_greaterThanOrEqualTo(Adaptor_Value(Adaptor_Value(20)));
            make.right.left.mas_equalTo(contentV);
            make.top.mas_equalTo(weakSelf.imageV.mas_bottom);
        }];
        
        _titleLabel = [UILabel lableWithText:lqLocalized(@"",nil) textColor:TitleBlackColor fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:2];
        [titleBackWhiteView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(10));
            make.centerY.mas_equalTo(titleBackWhiteView);
            make.left.mas_equalTo(Adaptor_Value(10));
            make.top.mas_equalTo(Adaptor_Value(5));
        }];

    }
    return _cellBackgroundView;
}

@end
