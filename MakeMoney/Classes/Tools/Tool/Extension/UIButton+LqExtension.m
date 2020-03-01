//
//  UIButton+LqExtension.m
//  LqTool
//
//  Created by rabi on 2019/12/24.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "UIButton+LqExtension.h"
#import<objc/runtime.h>

@interface UIButton ()
@property (nonatomic,strong)dispatch_source_t atimer;
@property (nonatomic,copy)UIColor * tColor;
@property (nonatomic,copy)UIColor * mColor;
@property (nonatomic,copy)NSString * mtitle;

@end

@implementation UIButton (LqExtension)
- (void)setHighlighted:(BOOL)highlighted{

}

/** 创建普通按钮 */
+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont backGroundColor:(UIColor *)color Target:(id)target action:(SEL)action rect:(CGRect)rect{
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = titleFont;
    btn.backgroundColor = color;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (rect.size.width == 0) {
        [btn sizeToFit];
    }else{
        btn.frame = rect;
    }
    return btn;
}

+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont backGroundColor:(UIColor *)color normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage Target:(id)target action:(SEL)action rect:(CGRect)rect{

    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = titleFont;
    btn.backgroundColor = color;
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setImage:selectedImage forState:UIControlStateSelected];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (rect.size.width == 0) {
        [btn sizeToFit];
    }else{
        btn.frame = rect;
    }
    return btn;

}
/**   **  **  **  **  **  **     倒计时button         */

static char *AtimerKey = "atimerKey";
static char *TColor = "tColor";
static char *MColor = "MColor";
static char *Mtitle = "mtitle";

- (void)setAtimer:(dispatch_source_t)atimer{
    /*
     objc_AssociationPolicy参数使用的策略：
     OBJC_ASSOCIATION_ASSIGN;            //assign策略
     OBJC_ASSOCIATION_COPY_NONATOMIC;    //copy策略
     OBJC_ASSOCIATION_RETAIN_NONATOMIC;  // retain策略
     
     OBJC_ASSOCIATION_RETAIN;
     OBJC_ASSOCIATION_COPY;
     */
    /*
     关联方法：
     objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);
     
     参数：
     * id object 给哪个对象的属性赋值
     const void *key 属性对应的key
     id value  设置属性值为value
     objc_AssociationPolicy policy  使用的策略，是一个枚举值，和copy，retain，assign是一样的，手机开发一般都选择NONATOMIC
     */

    objc_setAssociatedObject(self, AtimerKey, atimer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (dispatch_source_t)atimer{
    return objc_getAssociatedObject(self, AtimerKey);

}

- (void)setMtitle:(NSString *)mtitle{
    objc_setAssociatedObject(self, Mtitle, mtitle, OBJC_ASSOCIATION_COPY_NONATOMIC);

}

- (NSString *)mtitle{
    return objc_getAssociatedObject(self, Mtitle);

}

- (void)setMColor:(UIColor *)mColor{
    objc_setAssociatedObject(self, MColor, mColor, OBJC_ASSOCIATION_COPY_NONATOMIC);

}
-(UIColor *)mColor{
    return objc_getAssociatedObject(self, MColor);

}

- (void)setTColor:(UIColor *)tColor{
    objc_setAssociatedObject(self, TColor, tColor, OBJC_ASSOCIATION_COPY_NONATOMIC);

}

-(UIColor *)tColor{
    return objc_getAssociatedObject(self, TColor);

}


- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color {
    
    __weak typeof(self) weakSelf = self;
    //倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.backgroundColor = mColor;
                [weakSelf setTitle:title forState:UIControlStateNormal];
                weakSelf.userInteractionEnabled = YES;
            });
        } else {
            int allTime = (int)timeLine + 1;
            int seconds = timeOut % allTime;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.backgroundColor = color;
                [weakSelf setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle] forState:UIControlStateNormal];
                weakSelf.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}

- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title titleColor:(UIColor *)tColor countDownTitle:(NSString *)subTitle countDownTitleColor:(UIColor *)cColor mainColor:(UIColor *)mColor countColor:(UIColor *)color{
    __weak typeof(self) weakSelf = self;
    self.hidden = NO;
    //倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    self.atimer = _timer;

    //每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.backgroundColor = mColor;
                [weakSelf setTitle:title forState:UIControlStateNormal];
                weakSelf.userInteractionEnabled = YES;
                [weakSelf setTitleColor:tColor forState:UIControlStateNormal];

            });
        } else {
            int allTime = (int)timeLine + 1;
            int seconds = timeOut % allTime;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.backgroundColor = color;
                [weakSelf setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle] forState:UIControlStateNormal];
                weakSelf.userInteractionEnabled = NO;
                [weakSelf setTitleColor:cColor forState:UIControlStateNormal];
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);

}

- (void)countBtnReset{
    __weak typeof(self) weakSelf = self;
    dispatch_source_cancel(weakSelf.atimer);
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.backgroundColor = self.mColor;
        [weakSelf setTitle:self.mtitle forState:UIControlStateNormal];
        weakSelf.userInteractionEnabled = YES;
        [weakSelf setTitleColor:self.tColor forState:UIControlStateNormal];
        
    });

}


/**********************************************************自定义位置***************/
- (void)setIconInLeft
{
    [self setIconInLeftWithSpacing:0];
}

- (void)setIconInRight
{
    [self setIconInRightWithSpacing:0];
}

- (void)setIconInTop
{
    [self setIconInTopWithSpacing:0];
}

- (void)setIconInBottom
{
    [self setIconInBottomWithSpacing:0];
}

- (void)setIconInLeftWithSpacing:(CGFloat)Spacing
{
    self.titleEdgeInsets = (UIEdgeInsets){
        .top    = 0,
        .left   = Spacing,
        .bottom = 0,
        .right  = -Spacing,
    };
    
    self.imageEdgeInsets = (UIEdgeInsets){
        .top    = 0,
        .left   = -Spacing,
        .bottom = 0,
        .right  = Spacing,
    };
}

- (void)setIconInRightWithSpacing:(CGFloat)Spacing
{
    CGFloat img_W = self.imageView.frame.size.width;
    CGFloat tit_W = self.titleLabel.frame.size.width;
    
    self.titleEdgeInsets = (UIEdgeInsets){
        .top    = 0,
        .left   = - (img_W + Spacing / 2),
        .bottom = 0,
        .right  =   (img_W + Spacing / 2),
    };
    
    self.imageEdgeInsets = (UIEdgeInsets){
        .top    = 0,
        .left   =   (tit_W + Spacing / 2),
        .bottom = 0,
        .right  = - (tit_W + Spacing / 2),
    };
}

- (void)setIconInTopWithSpacing:(CGFloat)Spacing
{
    CGFloat img_W = self.imageView.frame.size.width;
    CGFloat img_H = self.imageView.frame.size.height;
    CGFloat tit_W = self.titleLabel.frame.size.width;
    CGFloat tit_H = self.titleLabel.frame.size.height;

    self.titleEdgeInsets = (UIEdgeInsets){
        .top    =   (tit_H / 2 + Spacing / 2),
        .left   = - img_W,
        .bottom = - (tit_H / 2 + Spacing / 2),
        .right  =   0,
    };

    self.imageEdgeInsets = (UIEdgeInsets){

        .top    = - (img_H / 2 + Spacing / 2),
        .left   =   0,
        .bottom =   (img_H / 2 + Spacing / 2),
        .right  = -tit_W,
    };
    
}

- (void)setIconInBottomWithSpacing:(CGFloat)Spacing
{
    CGFloat img_W = self.imageView.frame.size.width;
    CGFloat img_H = self.imageView.frame.size.height;
    CGFloat tit_W = self.titleLabel.frame.size.width;
    CGFloat tit_H = self.titleLabel.frame.size.height;
    
    self.titleEdgeInsets = (UIEdgeInsets){
        .top    = - (tit_H / 2 + Spacing / 2),
        .left   = - (img_W / 2),
        .bottom =   (tit_H / 2 + Spacing / 2),
        .right  =   (img_W / 2),
    };
    
    self.imageEdgeInsets = (UIEdgeInsets){
        .top    =   (img_H / 2 + Spacing / 2),
        .left   =   (tit_W / 2),
        .bottom = - (img_H / 2 + Spacing / 2),
        .right  = - (tit_W / 2),
    };
}
@end
