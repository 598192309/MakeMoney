//
//  HomeCategaryCell.m
//  MakeMoney
//
//  Created by JS on 2020/3/1.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "HomeCategaryCell.h"

@interface HomeCategaryCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (nonatomic, strong) HotItem *item;

@end

@implementation HomeCategaryCell

-(void)awakeFromNib{
    [super awakeFromNib];
    _imageV.layer.cornerRadius = 4;
    _imageV.layer.masksToBounds = YES;
}
- (void)refreshCellWithItem:(HotItem *)item des:(NSString *)des{
    _item = item;
    _desLabel.text = des;
    self.imageV.image = nil;
    __weak __typeof(self) weakSelf = self;
    if (!item) {
        return;
    }
    [HomeApi downImageWithType:@"v_imgs" paramTitle:@"vId" ID:item.ID key:item.video_url Success:^(UIImage * _Nonnull img,NSString *ID) {
        if ([weakSelf.item.ID isEqualToString:ID]) {
            weakSelf.imageV.image = img;
        }
    } error:^(NSError *error, id resultObject) {
        
    }];
    
}
@end
