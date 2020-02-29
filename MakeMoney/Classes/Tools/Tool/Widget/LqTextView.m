//
//  LqTextView.m
//  LqTool
//
//  Created by lqq on 2019/12/21.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "LqTextView.h"

@interface LqTextView ()

@property (nonatomic,weak) UILabel *placeholderLabel; //这里先拿出这个label以方便我们后面的使用

@end
@implementation LqTextView

#pragma mark - lifeCycle
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initTextView];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self= [super initWithFrame:frame]) {
        [self initTextView];
    }
    return self;
}

- (void)initTextView{
    self.backgroundColor= [UIColor clearColor];
    
    UILabel *placeholderLabel = [[UILabel alloc]init];//添加一个占位label
    
    placeholderLabel.backgroundColor= [UIColor clearColor];
    
    placeholderLabel.numberOfLines=0; //设置可以输入多行文字时可以自动换行
    [self addSubview:placeholderLabel];
    
    self.placeholderLabel= placeholderLabel; //赋值保存
    
    self.myPlaceholderColor= [UIColor lq_colorWithHexString:@"999999"]; //设置占位文字默认颜色
    
    self.font= [UIFont systemFontOfSize:15]; //设置默认的字体
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self]; //通知:监听文字的改变
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.placeholderLabel.lq_top=8; //设置UILabel 的 y值
    
    self.placeholderLabel.lq_left=5;//设置 UILabel 的 x 值
    
    self.placeholderLabel.lq_width=self.lq_width-self.placeholderLabel.lq_left*2.0; //设置 UILabel 的 x
    
    //根据文字计算高度
    
    CGSize maxSize =CGSizeMake(self.placeholderLabel.lq_width,MAXFLOAT);
    
    self.placeholderLabel.lq_height= [self.myPlaceholder boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.placeholderLabel.font} context:nil].size.height;
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:UITextViewTextDidChangeNotification];
}

#pragma mark - getter/setter
- (void)setMyPlaceholder:(NSString *)myPlaceholder {
    _myPlaceholder = [myPlaceholder copy];
    self.placeholderLabel.text = myPlaceholder;
    [self setNeedsLayout];
}

- (void)setMyPlaceholderColor:(UIColor*)myPlaceholderColor{
    
    _myPlaceholderColor= myPlaceholderColor;
    //设置颜色
    self.placeholderLabel.textColor= myPlaceholderColor;
   
}

- (void)setFont:(UIFont*)font{
    
    [super setFont:font];
    
    self.placeholderLabel.font= font;
    //重新计算子控件frame
    [self setNeedsLayout];
    
}

- (void)setText:(NSString*)text{
    
    [super setText:text];
    
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString*)attributedText{
    
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}

#pragma mark - ActionMethod
- (void)textDidChange {
    
    self.placeholderLabel.hidden = self.hasText;
    
}
@end
