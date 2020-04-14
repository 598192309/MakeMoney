//
//  SaoMaView.h
//  MakeMoney
//
//  Created by rabi on 2020/3/5.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SaoMaView : UIView
@property (nonatomic,strong)NSString *urlStr;
/**点击保存*/
@property(nonatomic,copy)void(^saveBtnClickBlock)(UIButton * sender,UIImageView * erweimaImageV);
/**点击copy*/
@property(nonatomic,copy)void(^copyBtnClickBlock)(UIButton * sender);

@property (nonatomic, copy) NSString *navTitle;
@end

NS_ASSUME_NONNULL_END
