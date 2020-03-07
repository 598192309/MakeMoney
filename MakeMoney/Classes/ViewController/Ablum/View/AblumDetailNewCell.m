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

@end
