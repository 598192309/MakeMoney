

#ifndef Constant_h
#define Constant_h


// 应用苹果商店ID
#define APPLE_ID        @""
//APP名字
//#define APP_NAME @"HuiXiaKuan"

// 应用版本号
#define APP_VERSION     [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define APPDelegate     [UIApplication sharedApplication].delegate

#define APPlication    [UIApplication sharedApplication]

// 应用版本审核
#define APP_AUDIT_CONDICATION   @"1.0.0"

// 是否iPad
#define isPad                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//是否是英语
#define ISEN [[[[NSUserDefaults standardUserDefaults] valueForKey:@"AppleLanguages"] firstObject] hasPrefix:@"en"]


// 注册通知
#define NOTIFY_ADD(_noParamsFunc, _notifyName)  [[NSNotificationCenter defaultCenter] \
addObserver:self \
selector:@selector(_noParamsFunc) \
name:_notifyName \
object:nil];

// 发送通知
#define NOTIFY_POST(_notifyName)   [[NSNotificationCenter defaultCenter] postNotificationName:_notifyName object:nil];
#define NOTIFY_POST_Dict(_notifyName, _dict) [[NSNotificationCenter defaultCenter] postNotificationName:_notifyName object:nil userInfo:_dict];


// 移除通知
#define NOTIFY_REMOVE(_notifyName) [[NSNotificationCenter defaultCenter] removeObserver:self name:_notifyName object:nil];
// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]


//中文字体
//#define CHINESE_FONT_NAME  @"Heiti SC"
#define CHINESE_FONT_NAME  @"Helvetica Neue"


#define CHINESE_SYSTEM(x) [UIFont fontWithName:CHINESE_FONT_NAME size:x]


//不同屏幕尺寸字体适配（375，667是因为效果图为IPHONE6 如果不是则根据实际情况修改）
#define kScreenWidthRatio  (LQScreemW / 375.0)
#define kScreenHeightRatio (LQScreemH / 667.0)
#define AdaptedWidth(x)  ceilf((x) * kScreenWidthRatio)
#define AdaptedHeight(x) ceilf((x) * kScreenHeightRatio)
#define AdaptedFontSize(R)    (IS_IPHONEX ? CHINESE_SYSTEM(AdaptedWidth(R)) :CHINESE_SYSTEM(AdaptedWidth(R)))
#define AdaptedBoldFontSize(R)    [UIFont boldSystemFontOfSize:R]

/*************** 颜色 *******************/
#define LQColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:1]
#define LQRandColor [UIColor colorWithHue:arc4random()% 255 / 255.0 saturation:arc4random()% 255 / 255.0 brightness:arc4random()% 255 / 255.0 alpha:1]


/*************** 尺寸 *******************/
#define LQScreemW [UIScreen mainScreen].bounds.size.width
#define LQScreemH [UIScreen mainScreen].bounds.size.height
#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )480) < DBL_EPSILON )
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )568) < DBL_EPSILON )
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )667) < DBL_EPSILON )
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )736) < DBL_EPSILON )
#define IS_IPHONEX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iPhoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXsMax
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size)&& !isPad : NO)

//判断iPhoneX所有系列
#define IS_PhoneXAll (IS_IPHONEX || IS_IPHONE_Xr || IS_IPHONE_Xs_Max)

#define TabbarH  (IS_PhoneXAll ? 83 : 49)
#define NavMaxY  (IS_PhoneXAll ? 88 : 64)
#define SafeAreaTopHeight  (IS_PhoneXAll ? 24 : 0) //导航栏 粪叉显示栏多了24
#define SafeAreaBottomHeight  (IS_PhoneXAll ? 34 : 0) //导航栏 粪叉显示栏多了24
#define TitleViewH Adaptor_Value(45)


// MainScreen Height&Width
#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

// Screen adaptation to iphone6 as the standard
#define Screen_Adaptor_Scale    Main_Screen_Width/375.0f

#define Adaptor_Value(v)        (v)*Screen_Adaptor_Scale
//#define BottomAdaptor_Value(v)       (IS_IPHONEX ? (v + 34)*Screen_Adaptor_Scale : (v)*Screen_Adaptor_Scale)
//#define TopAdaptor_Value(v)       (IS_IPHONEX ? (v + 24)*Screen_Adaptor_Scale : (v)*Screen_Adaptor_Scale)
#define BottomAdaptor_Value(v)        (v + SafeAreaBottomHeight)*Screen_Adaptor_Scale
#define TopAdaptor_Value(v)       (v + SafeAreaTopHeight)*Screen_Adaptor_Scale


// 3.5英寸
#define is3Inch_Laters          [UIScreen mainScreen].bounds.size.height == 480
// 4英寸
#define is4Inch                 [UIScreen mainScreen].bounds.size.height == 568
// 4.7inch
#define is4Inch_Laters          [UIScreen mainScreen].bounds.size.height == 667
// 5.5inch
#define is5Inch_Laters          [UIScreen mainScreen].bounds.size.height == 736




/*************** 打印 *******************/

#define LQFunc LQLog(@"%s",__func__)

/*自定义Log*/
// 调试
#ifdef DEBUG
#define LQLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#else
#define LQLog(...)

#endif


#ifdef DEBUG
#define KHOST @"http://29688b6n03.zicp.vip:39554"
//#define KHOST @"http://app.51778.me"


#else
#define KHOST @"http://app.51778.me"

#endif



//像素
#define kOnePX (1 / [UIScreen mainScreen].scale)


/**
 *  触发UIAlerView
 */
#define ALERT(_title_,_msg_) ([[[UIAlertView alloc] initWithTitle:_title_ message:_msg_ delegate:nil cancelButtonTitle:lqLocalized(@"确实", nil) otherButtonTitles:nil, nil] show])
//国际化
#define lqLocalized(key,comment) NSLocalizedStringFromTable(key, @"lqlocal", comment)
#define lqStrings(string) NSLocalizedStringFromTable(string, @"lqlocal", nil)

//number转String
#define IntTranslateStr(int_str) [NSString stringWithFormat:@"%ld",(long)int_str]
#define FloatTranslateStr(float_str) [NSString stringWithFormat:@"%.2d",float_str]
/** 弱引用 */
#define WEAKSELF __weak typeof(self) weakSelf = self

/**阴影*/
#define ViewYellowGradient(view,farm) NSArray *colorArray = @[(__bridge id)[UIColor lq_colorWithHexString:@"#ffc600"].CGColor,(__bridge id)  [UIColor lq_colorWithHexString:@"#ed8233"].CGColor]; \
CAGradientLayer *layer = [CAGradientLayer new]; \
layer.colors = colorArray; \
layer.startPoint = CGPointMake(0.0, 0.0); \
layer.endPoint = CGPointMake(0.5, 0); \
layer.frame = farm; \
[view.layer insertSublayer:layer atIndex:0];

#define ViewGradient(view,color1,color2,farm) NSArray *colorArray = @[(__bridge id)[UIColor lq_colorWithHexString:color1].CGColor,(__bridge id)  [UIColor lq_colorWithHexString:color2].CGColor]; \
CAGradientLayer *layer = [CAGradientLayer new]; \
layer.colors = colorArray; \
layer.startPoint = CGPointMake(0.0, 0.0); \
layer.endPoint = CGPointMake(0.5, 0); \
layer.frame = farm; \
[view.layer insertSublayer:layer atIndex:0];
/**
 APP通用的一些设置
 */

// RGB颜色转换（16进制->10进制）
#define HexRGB(rgbValue)        HexRGBA(rgbValue, 1.0)

#define HexRGBA(rgbValue, a)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:(a)]

#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define TitleBlackColor   [UIColor lq_colorWithHexString:@"#202020"]
#define TitleGrayColor   [UIColor lq_colorWithHexString:@"#bcbcbc"]
#define TitleWhiteColor   [UIColor lq_colorWithHexString:@"#ffffff"]


#define CustomRedColor   [UIColor lq_colorWithHexString:@"#e94339"]
#define CustomBlueColor   [UIColor lq_colorWithHexString:@"#2373f2"]

#define CustomPinkColor RGBCOLOR(244, 106, 144)


#define CustomBlueDarkColor   [UIColor lq_colorWithHexString:@"#19529e"]

#define LightYellowColor   [UIColor lq_colorWithHexString:@"#dbc29e"]

// 主题色
#define ThemeBlackColor   [UIColor lq_colorWithHexString:@"#0f0f1b"]

#define TitleBarColor   [UIColor lq_colorWithHexString:@"#000000</"]



// 字体大小(常规/粗体)
#define BOLDSYSTEMFONT(FONTSIZE)    [UIFont boldSystemFontOfSize:FONTSIZE]

#define SYSTEMFONT(FONTSIZE)        [UIFont systemFontOfSize:FONTSIZE]
#define Semibold_FONT_NAME  @"PingFangSC-Semibold"
#define Regular_FONT_NAME  @"PingFangSC-Regular"

#define SemiboldFONT(FONTSIZE)      [UIFont fontWithName:Semibold_FONT_NAME size:(Adaptor_Value(FONTSIZE))]
#define RegularFONT(FONTSIZE)      [UIFont fontWithName:Regular_FONT_NAME size:(Adaptor_Value(FONTSIZE))]
#define FONT(NAME, FONTSIZE)        [UIFont fontWithName:(NAME) size:(FONTSIZE)]

///**
// 通知
// */
#define KNotificationSecuritySetting @"KNotificationSecuritySetting"//账户安全里的交易密码设置 邮箱绑定
#define KAuthorization            @"KAuthorization"

#define KLanguage            @"KLanguage"//语言
#define KValuation            @"KValuation"//计价方式
#define KIncreaseDownColor           @"KIncreaseDownColor"//涨跌色
#define KNotification_LanguageChanged @"KNotification_LanguageChanged"//语言
#define KNotification_ValuationChanged             @"KNotification_ValuationChanged"//计价方式
#define KNotification_IncreaseDownColorChanged           @"KNotification_IncreaseDownColorChanged"//涨跌色

// 登录、登出
#define kUserSignIn         @"user_sign_in"
#define kUserSignOut        @"user_sign_out"
#define kRefreshAvatar        @"kRefreshAvatar"

#define KNotification_IdentityAuthed     @"KNotification_IdentityAuthed"//身份认证过
#define KNotification_BankAuthed    @"KNotification_BankAuthed"






#define KNotification_ReLorigin @"KNotification_ReLorigin"//多人登录 在其他设备登录 需要重新登录
//
#define KNotification_ReLoriginSuccess @"KNotification_ReLoriginSuccess"//多人登录 在其他设备登录 需要重新登录  重新登录成功
//
#define KNotification_RegisterSuccess @"KNotification_RegisterSuccess"//注册成功 并登陆成功
//
//
//
////用户信息
//#define KShiming             @"KShiming"
#define KAvatar             @"KAvatar"//头像
//
#define VersionKey @"curVersion"
//
//
#define KMobile             @"KMobile"
//网络状态监控地址
#define kURL_Reachability__Address @"www.baidu.com"

/**二维码key */
#define  ErweimaShareKey @"ARBKR7HE27AFB2"

#endif

