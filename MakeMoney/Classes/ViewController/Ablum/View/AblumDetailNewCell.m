//
//  AblumDetailNewCell.m
//  MakeMoney
//
//  Created by 黎芹 on 2020/3/7.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "AblumDetailNewCell.h"

@interface AblumDetailNewCell()
@property (weak, nonatomic) IBOutlet UIImageView *contentImageV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewLeadingCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewTrailingCons;
@property (nonatomic, strong) M_AblumImage *ablumImage;
@end

@implementation AblumDetailNewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
}

- (void)refreshUIWithImageStr:(NSString*)imageStr{
    [self.contentImageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",RI.basicItem.album_url,imageStr]] placeholderImage:[UIImage imageNamed:@"app_bg"]];

}

- (void)refreshUIWithAblumImage:(M_AblumImage *)ablum
{
    _ablumImage = ablum;
    __weak __typeof(self) weakSelf = self;
    [self.contentImageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",RI.basicItem.album_url,ablum.imageUrl]] placeholderImage:[UIImage imageNamed:@"app_bg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (weakSelf.ablumImage.imageSize.height > 0) return ;
        if (image) {
            weakSelf.ablumImage.imageSize = image.size;
            if (weakSelf.imageSizeSetSuccessBlock) {
                weakSelf.imageSizeSetSuccessBlock();
            }
        }
    }];
}
- (void)refreshTongchengDetailUIWithImage:(UIImage *)image{
    self.contentImageV.image = image;
    self.imageViewLeadingCons.constant = Adaptor_Value(25);
    self.imageViewTrailingCons.constant = -Adaptor_Value(25);
}
@end


@implementation M_AblumImage



@end
