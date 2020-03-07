//
//  MyLoveCell.m
//  MakeMoney
//
//  Created by rabi on 2020/3/6.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "MyLoveCell.h"
#import "MineItem.h"
#import "AblumItem.h"
@interface MyLoveCell()
@property (nonatomic,strong) UIView * cellBackgroundView;
@property (strong, nonatomic)  UILabel *titleLabel;
@property (strong, nonatomic)  UIImageView *imageV;
@property (strong, nonatomic)  EnlargeTouchSizeButton *loveBtn;
@property (strong, nonatomic)  UILabel *timeLable;
@property (strong, nonatomic)  EnlargeTouchSizeButton *seeTimesBtn;
@property (strong, nonatomic)  UILabel *vedioTimesLable;
@property (strong, nonatomic)  UILabel *titleLable;

@property (nonatomic,strong)HotItem *item;
@end
@implementation MyLoveCell

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




- (void)refreshWithItem:(HotItem *)item {
    self.titleLable.text = item.title;

    self.timeLable.text = [item.create_time lq_getTimeFromTimestampWithFormatter:@"yyyy-MM-dd"];
    [self.seeTimesBtn setTitle:item.play forState:UIControlStateNormal];
    self.vedioTimesLable.text = item.total_time;
    
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
    if (!item) {
        return;
    }
     [HomeApi downImageWithType:@"qm_imgs" paramTitle:@"qmId" ID:item.ID key:@"tongcheng" Success:^(UIImage * _Nonnull img,NSString *ID) {
         if ([weakSelf.item.ID isEqualToString:ID]) {
             weakSelf.imageV.image = img;
         }
     } error:^(NSError *error, id resultObject) {

     }];
    
}
//针对写真
- (void)refreshAblumWithItem:(AblumItem *)item{
    self.titleLable.text = item.album_name;
    self.timeLable.text = [item.create_time lq_getTimeFromTimestampWithFormatter:@"yyyy-MM-dd"];
    [self.seeTimesBtn setTitle:item.see forState:UIControlStateNormal];
    self.vedioTimesLable.text = [NSString stringWithFormat:@"%ld张",(long)item.img_count];
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
        contentV.backgroundColor = TitleWhiteColor;

        _imageV = [[UIImageView alloc] init];
        _imageV.backgroundColor = TitleGrayColor;
        [contentV addSubview:_imageV];
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(contentV);
            make.height.mas_equalTo(Adaptor_Value(150));
            make.left.mas_equalTo(Adaptor_Value(5));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(5));
        }];

        _loveBtn = [[EnlargeTouchSizeButton alloc] init];
        [_loveBtn addTarget:self action:@selector(loveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_loveBtn setImage:[UIImage imageNamed:@"icon_home_like_before"] forState:UIControlStateNormal];
        [_loveBtn setImage:[UIImage imageNamed:@"icon_home_like_after"] forState:UIControlStateSelected];
        [contentV addSubview:_loveBtn];
        [_loveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(Adaptor_Value(20));
            make.top.mas_equalTo(Adaptor_Value(25));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(25));
        }];
        _loveBtn.touchSize = CGSizeMake(Adaptor_Value(50), Adaptor_Value(50));
        
        UIView *loveBtnBackView = [UIView new];
        loveBtnBackView.backgroundColor = [UIColor lq_colorWithHexString:@"ffffff" alpha:0.3];
        [contentV insertSubview:loveBtnBackView belowSubview:_loveBtn];
        [loveBtnBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(Adaptor_Value(40));
            make.center.mas_equalTo(weakSelf.loveBtn);
        }];
        ViewRadius(loveBtnBackView, Adaptor_Value(20));
        

        _timeLable = [UILabel lableWithText:lqLocalized(@"",nil) textColor:[UIColor whiteColor] fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_timeLable];
        [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(Adaptor_Value(30)));
            make.left.mas_equalTo(Adaptor_Value(10));
            make.bottom.mas_equalTo(weakSelf.imageV);
        }];
        
        _seeTimesBtn = [[EnlargeTouchSizeButton alloc] init];
//        [_seeTimesBtn addTarget:self action:@selector(seeTimesBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_seeTimesBtn setImage:[UIImage imageNamed:@"hot"] forState:UIControlStateNormal];
        _seeTimesBtn.titleLabel.font = AdaptedFontSize(12);
        [contentV addSubview:_seeTimesBtn];
        [_seeTimesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(Adaptor_Value(30)));
            make.centerY.mas_equalTo(weakSelf.timeLable);
            make.left.mas_equalTo(weakSelf.timeLable.mas_right).offset(Adaptor_Value(20));
        }];
        
        _vedioTimesLable = [UILabel lableWithText:lqLocalized(@"",nil) textColor:[UIColor whiteColor] fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentRight numberofLines:0];
        [contentV addSubview:_vedioTimesLable];
        [_vedioTimesLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(Adaptor_Value(30)));
            make.right.mas_equalTo(-Adaptor_Value(10));
            make.bottom.mas_equalTo(weakSelf.imageV);
        }];
        
        UIView *alfaView  = [UIView new];
        alfaView.backgroundColor = [UIColor lq_colorWithHexString:@"303030" alpha:0.4];
        [contentV insertSubview:alfaView belowSubview:_timeLable];
        [alfaView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(Adaptor_Value(30)));
            make.left.right.bottom.mas_equalTo(weakSelf.imageV);
        }];
        
        UIView *titleBackWhiteView = [UIView new];
        titleBackWhiteView.backgroundColor = TitleWhiteColor;
        [contentV addSubview:titleBackWhiteView];
        [titleBackWhiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_greaterThanOrEqualTo(Adaptor_Value(Adaptor_Value(40)));
            make.right.left.mas_equalTo(contentV);
            make.top.mas_equalTo(weakSelf.imageV.mas_bottom);
            make.bottom.mas_equalTo(contentV);
        }];
        
        _titleLable = [UILabel lableWithText:lqLocalized(@"",nil) textColor:TitleBlackColor fontSize:AdaptedFontSize(16) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:2];
        [titleBackWhiteView addSubview:_titleLable];
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(10));
            make.centerY.mas_equalTo(titleBackWhiteView);
            make.left.mas_equalTo(Adaptor_Value(10));
            make.top.mas_equalTo(Adaptor_Value(5));
        }];
    }
    return _cellBackgroundView;
}
@end
