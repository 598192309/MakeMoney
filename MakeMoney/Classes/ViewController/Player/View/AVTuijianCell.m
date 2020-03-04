//
//  AVTuijianCell.m
//  MakeMoney
//
//  Created by rabi on 2020/3/4.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "AVTuijianCell.h"
#import "HomeItem.h"
@interface AVTuijianCell()
@property (nonatomic,strong) UIView * cellBackgroundView;
@property (strong, nonatomic)  UIImageView *imageV;
@property (strong, nonatomic)  UILabel *titleLable;
@property (strong, nonatomic)  UILabel *tagLable;
@property (strong, nonatomic)  UILabel *seeCountsLable;
@property (strong, nonatomic)  UILabel *timeLable;


@property (nonatomic, strong) HotItem *item;
@end
@implementation AVTuijianCell

#pragma mark - 生命周期
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
        [self layoutSub];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = TitleWhiteColor;
        
    }
    return self;
}


- (void)configUI{
    [self.contentView addSubview:self.cellBackgroundView];
    [self.cellBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.contentView);
    }];
    
}

- (void)layoutSub{
}

- (void)refreshWithItem:(HotItem*)item{
    self.item = item;
    
    self.titleLable.text = item.title;

    self.timeLable.text = [item.create_time lq_getTimeFromTimestampWithFormatter:@"yyyy-MM-dd"];
    self.seeCountsLable.text = [NSString stringWithFormat:lqLocalized(@"%@次播放", nil),item.play];
    /**
     <string name=“video_av_tag1”>巨乳</string>
     <string name=“video_av_tag2”>人妻</string>
     <string name=“video_av_tag3”>伦理</string>
     <string name=“video_av_tag4”>教师</string>
     <string name=“video_av_tag5”>制服</string>
     <string name=“video_av_tag6”>电车</string>
     <string name=“video_av_tag7”>按摩</string>
     <string name=“video_av_tag8”>潮喷</string>
     <string name=“video_av_tag9”>素人</string>
     <string name=“video_av_tag10”>口罩</string>
     <string name=“video_av_tag11”>中出</string>
     <string name=“video_av_tag12”>轮奸</string>
     <string name=“video_av_tag13”>性奴</string>
     <string name=“video_av_tag14”>无码</string>
     <string name=“video_av_tag15”>职场</string>
     <string name=“video_av_tag16”>偷情</string>
     <string name=“video_av_tag17”>SM</string>
     <string name=“video_av_tag18”>迷奸</string>
     <string name=“video_av_tag19”>女同</string>
     <string name=“video_av_tag20”>护士</string>
     <string name=“video_av_tag21”>高清</string>
     <string name=“video_av_tag22”>中文</string>
     */
    self.tagLable.text = item.video_tag;
    
    __weak __typeof(self) weakSelf = self;
    /**
     
    对应参数如下
    /api/v_imgs         vId=                   短视频
    /api/a_imgs         aId=                   av
    /api/qm_imgs      qmId=                同城
    /api/vt_imgs        vtId=                  全部分类
    /api/s_imgs         sId=                   专题
     */
    self.imageV.image = nil;
    if (!item) {
        return;
    }
    [HomeApi downImageWithType:@"a_imgs" paramTitle:@"aId" ID:item.ID key:item.video_url Success:^(UIImage * _Nonnull img,NSString *ID) {
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
        _cellBackgroundView.backgroundColor = TitleWhiteColor;
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
            make.left.mas_equalTo(Adaptor_Value(15));
            make.right.mas_equalTo(contentV.mas_centerX).offset(-Adaptor_Value(10));
            make.top.mas_equalTo(Adaptor_Value(5));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(5));
            make.height.mas_equalTo(Adaptor_Value(100));
        }];
        ViewRadius(_imageV, 5);
        
        _titleLable = [UILabel lableWithText:lqLocalized(@"",nil) textColor:TitleBlackColor fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:3];
        [contentV addSubview:_titleLable];
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(contentV.mas_centerX);
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(20));
            make.top.mas_equalTo(weakSelf.imageV).offset(Adaptor_Value(5));
        }];
        
        _tagLable = [UILabel lableWithText:lqLocalized(@"",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_tagLable];
        [_tagLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.titleLable);
            make.top.mas_equalTo(weakSelf.titleLable.mas_bottom).offset(Adaptor_Value(7));
        }];
        
        _seeCountsLable = [UILabel lableWithText:lqLocalized(@"",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_seeCountsLable];
        [_seeCountsLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.titleLable);
            make.bottom.mas_equalTo(contentV.mas_bottom).offset(-Adaptor_Value(10));
        }];
      

        _timeLable = [UILabel lableWithText:lqLocalized(@"",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_timeLable];
        [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {            make.left.mas_equalTo(weakSelf.seeCountsLable.mas_right).offset(Adaptor_Value(20));
            make.centerY.mas_equalTo(weakSelf.seeCountsLable);
        }];

    }
    return _cellBackgroundView;
}

@end
