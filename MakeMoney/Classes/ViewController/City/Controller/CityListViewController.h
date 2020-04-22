//
//  CityListViewController.h
//  MakeMoney
//
//  Created by JS on 2020/4/22.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "BaseViewController.h"
//视频类型
typedef NS_ENUM(NSInteger, CityType) {
    CityType_New = 0,//最新
    CityType_QM,//QM
    CityType_High,//高端

};

NS_ASSUME_NONNULL_BEGIN

@interface CityListViewController : BaseViewController
@property (nonatomic,strong)NSString *regionID;
@property (nonatomic,strong)NSString *navStr;
@property (nonatomic,assign)CityType cityType;
@end

NS_ASSUME_NONNULL_END
