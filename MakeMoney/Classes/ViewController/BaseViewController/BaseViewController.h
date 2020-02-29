//
//  BaseViewController.h
//  IUang
//
//  Created by jayden on 2018/4/17.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property (nonatomic, assign) BOOL notFirstAppear;

@property (nonatomic, assign) BOOL isHideBackItem;

@property (nonatomic, assign) BOOL isShowing;


///右滑返回功能，默认开启（YES）
- (BOOL)gestureRecognizerShouldBegin;

-(NSString *)backItemImageName;


//添加导航栏
@property (nonatomic,strong) UIView * navigationView;
@property (nonatomic,strong) UIButton * navigationBackButton;
@property (nonatomic,strong) UIButton * navigationBackTitleButton;
@property (nonatomic,strong) UIButton * navigationBackSecButton;//在返回按钮后面的
@property (nonatomic,strong) UIView * navigationbackgroundLine;
@property (nonatomic,strong) UILabel * navigationTextLabel;//单个

@property (nonatomic,strong) UILabel * navigationTextTopLabel;//偏上
@property (nonatomic,strong) UILabel * navigationTextBottomLabel;//偏上
@property (nonatomic,strong) EnlargeTouchSizeButton * navigationRightBtn;
@property (nonatomic,strong) EnlargeTouchSizeButton * navigationRightSecBtn;
@property (nonatomic,strong) UIButton * navigationRightThirdBtn;

@property (nonatomic,strong) UIButton * navigationLastBtn;//上一个
@property (nonatomic,strong) UIButton * navigationNextBtn;//下一个


-(void)addNavigationView;

//
//- (BOOL)shouldAutorotate;
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations;
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation;
@end

