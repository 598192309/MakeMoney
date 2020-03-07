//
//  HomeVideoCell.m
//  MakeMoney
//
//  Created by JS on 2020/3/1.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "HomeVideoCell.h"

@interface HomeVideoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UIButton *loveBtn;
@property (nonatomic, strong) HotItem *item;
@end

@implementation HomeVideoCell

-(void)awakeFromNib{
    [super awakeFromNib];
 
    ViewRadius(_imageV, 4);
    _loveBtn.hidden = YES;
    [_loveBtn setIconInLeftWithSpacing:2.5];
}
- (void)refreshCellWithItem:(HotItem *)item videoType:(VideoType)type{
    _item = item;
    _desLabel.text = item.title;
    self.imageV.image = nil;
    NSString *typeStr = @"v_imgs";
    NSString *titleStr = @"vId";
    if (type == VideoType_AV) {
        typeStr = @"a_imgs";
        titleStr = @"aId";
    }
    __weak __typeof(self) weakSelf = self;
//    if (item.ID.length == 0) {
//        LQLog(@"这个item ID为空  %@",[item mj_JSONObject]);
//    }
    if (!item) {
        return;
    }
    [HomeApi downImageWithType:typeStr paramTitle:titleStr ID:item.ID key:item.video_url Success:^(UIImage * _Nonnull img,NSString *ID) {
        if ([weakSelf.item.ID isEqualToString:ID]) {
            weakSelf.imageV.image = img;
        }
    } error:^(NSError *error, id resultObject) {
        
    }];
    /**
     
    对应参数如下
    /api/v_imgs         vId=                   短视频
    /api/a_imgs         aId=                   av
    /api/qm_imgs      qmId=                同城
    /api/vt_imgs        vtId=                  全部分类
    /api/s_imgs         sId=                   专题
     */
    
}
//针对最新上传 最多播放 最多点赞 全部分类里进来 要显示
- (void)setLoveBtnAppear:(BOOL)appear{
    self.loveBtn.hidden = !appear;
    [self.loveBtn setTitle:self.item.love forState:UIControlStateNormal];
}
@end
