//
//  MineCustomView.h
//  HuiXiaKuan
//  我的账户 头部视图
//  Created by Lqq on 2018/8/30.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InitItem;
@interface MineCustomHeaderView : UIView
/**点击头像*/
@property(nonatomic,copy)void(^mineCustomHeaderViewBlock)(NSDictionary *dict);

/**点击*/
@property(nonatomic,copy)void(^mineCustomHeaderViewBtnsBlock)(UIButton *sender,NSDictionary *dict);

/**点击签到*/
@property(nonatomic,copy)void(^mineCustomQiandaoBtnClickBlock)(UIButton *sender);

- (void)configUIWithItem:(InitItem *)item finishi:(void(^)(void))finishBlock;

- (void)setAvter:(UIImage *)image;
@end
