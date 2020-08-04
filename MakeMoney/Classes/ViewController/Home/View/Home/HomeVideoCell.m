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
    //加载图片做个判断，
    //cover 包含http就直接加载，否则凭借 basic接口的 video_cover_url
    //如果cover有值 就去加载cover的  否则就走以前的 另外一个借口下载图片。
    if (item.cover.length > 0) {
        NSString *imageUrl;
        if ([item.cover hasPrefix:@"http"]) {
            imageUrl = item.cover;
        }else{
            imageUrl = [NSString stringWithFormat:@"%@%@",RI.basicItem.video_cover_url,item.cover];
        }
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:imageUrl]];

        
    }else{
        [HomeApi downImageWithType:typeStr paramTitle:titleStr ID:item.ID key:item.video_url Success:^(UIImage * _Nonnull img,NSString *ID) {
            if ([weakSelf.item.ID isEqualToString:ID]) {
                weakSelf.imageV.image = img;
            }
        } error:^(NSError *error, id resultObject) {
            
        }];
    }
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
