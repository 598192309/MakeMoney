//
//  ZFDouYinCell.h
//  ZFPlayer_Example
//
//  Created by 紫枫 on 2018/6/4.
//  Copyright © 2018年 紫枫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeItem.h"
@interface ZFDouYinCell : UITableViewCell 

@property (nonatomic, strong) HotItem *dataItem;
/**点击 观看完整版 */
@property(nonatomic,copy)void(^douYinCellSeeBtnClickBlock)(UIButton *sender);
/**点击喜欢 */
@property(nonatomic,copy)void(^douYinCellLikeBtnClickBlock)(UIButton *sender);
/**点击分享 */
@property(nonatomic,copy)void(^douYinCellShareBtnClickBlock)(UIButton *sender);
@end
