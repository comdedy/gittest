//
//  LoginViewController.m
//  SuperdutyML
//
//  Created by 吴坤 on 2019/4/10.
//  Copyright © 2019年 WK. All rights reserved.
//

#import "LoginViewController.h"
#import "DHGuidePageHUD.h"
#import "BaseMD.h"
#import "WKUTabBarViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>
{
    UIImageView *backImageView;
    UIImageView *logoImageView;
    UILabel *logoNameLbe;
    
    
    UIView *loginView;
    
    UIImageView *userImage;
    UITextField *userField;
    UIView *xianView;
    
    UIImageView *pwdImage;
    UITextField *pwdField;
    
    UIImageView *agreementImage;
    BOOL isAgreedAgreement;
    
    
    UIButton *loginBtn;
    
    
    NSArray *paths;
    NSString *path;
    BOOL isDir;
    NSFileManager *fileManager;
    BOOL existed;
    NSString *filename;
    NSDictionary *dicNamePwd;
    
    
    
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self GuidePage];
    [self createSubUI];
    
    
}
-(void)GuidePage{
    
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:BOOLFORKEY]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:BOOLFORKEY];
        // 静态引导页
//        [self setStaticGuidePage];
        // 动态引导页
                 [self setDynamicGuidePage];
        
        // 视频引导页
//                 [self setVideoGuidePage];
    }
}

-(void)createSubUI{
    isAgreedAgreement=NO;
    backImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH ,SCREEN_HEIGHT)];
    backImageView.image=[UIImage imageNamed:@"login_bg"];
    [self.view addSubview:backImageView];
    
    
    
    logoImageView=[[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-80)/2, 40, 80, 80)];
    [self.view addSubview:logoImageView];
    logoImageView.image=[UIImage imageNamed:@"login_logo"];
    logoImageView.layer.cornerRadius=40;
    logoImageView.layer.masksToBounds=YES;
    
    
    
    logoNameLbe=[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-120)/2 ,140, 120, 20)];
    logoNameLbe.textAlignment=NSTextAlignmentCenter;
    logoNameLbe.text=@"FC霜雪千年";
    logoNameLbe.textColor=[UIColor whiteColor];
    logoNameLbe.font=[UIFont systemFontOfSize:16];
    
    [self.view addSubview:logoNameLbe];
    
    
    [self loadLoginView];
    
    
    agreementImage=[[UIImageView alloc]initWithFrame:CGRectMake(30, 330, 20, 20)];
    [self.view addSubview:agreementImage];
    agreementImage.image=[UIImage imageNamed:@"login_sel_nor"];
    
    UIButton *rememberBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 330, 100, 20)];
    [rememberBtn setTitle:@"记住密码" forState:(UIControlStateNormal)];
    rememberBtn.titleLabel.font=[UIFont systemFontOfSize:16.0];
    [rememberBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [rememberBtn addTarget:self action:@selector(BtnRemember) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rememberBtn];
    rememberBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    
    
    
    loginBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 380, SCREEN_WIDTH-40, 40)];
    loginBtn.backgroundColor=loginTintColor;
    loginBtn.layer.cornerRadius=6;
    loginBtn.layer.masksToBounds=YES;
    
    [loginBtn setTitle:@"登录" forState:(UIControlStateNormal)];
    loginBtn.titleLabel.font=[UIFont systemFontOfSize:18.0];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.view addSubview:loginBtn];
    
    [loginBtn addTarget:self action:@selector(Btnlogin) forControlEvents:UIControlEventTouchUpInside];
    
    [self getFileNameData];
    
}

-(void)getFileNameData{
    
    //找到相应的目录
    paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    path = [paths objectAtIndex:0];
    
    //判断有没有文件夹
    fileManager = [NSFileManager defaultManager];
    
    //在Caches目录文件夹下找相应文件namepwd.plist
    filename=[path stringByAppendingPathComponent:@"rememberpwd.plist"];
    
    NSLog(@"%@",filename);
    
    if (![fileManager fileExistsAtPath:filename]) {
        isAgreedAgreement=NO;
        agreementImage.image=[UIImage imageNamed:@"login_sel_nor"];
        
    }else{
        //如果有文件，获取文件夹文件
        dicNamePwd = [NSDictionary dictionaryWithContentsOfFile:filename];
        NSLog(@"%@",dicNamePwd);
        
        userField.text=[BaseMD base64DecodeString:[BaseMD base64DecodeString:[dicNamePwd objectForKey:@"name"]]];
        pwdField.text=[BaseMD base64DecodeString:[BaseMD base64DecodeString:[dicNamePwd objectForKey:@"pwd"]]];
        
        
        isAgreedAgreement=YES;
        agreementImage.image=[UIImage imageNamed:@"login_sel_check"];
        
    }
    
    
}
-(void)BtnRemember{
    isAgreedAgreement=!isAgreedAgreement;
    
    if (isAgreedAgreement) {
        agreementImage.image=[UIImage imageNamed:@"login_sel_check"];
        
        
    }else{
        
        agreementImage.image=[UIImage imageNamed:@"login_sel_nor"];
        
        
    }
    
    
}
-(void)Btnlogin{
    //找到相应的目录
    paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    path = [paths objectAtIndex:0];
    
    //判断有没有文件夹
    fileManager = [NSFileManager defaultManager];
    
    //在Caches目录文件夹下找相应文件namepwd.plist
    filename=[path stringByAppendingPathComponent:@"rememberpwd.plist"];
    
    NSLog(@"%@",filename);
    
    if ([userField.text isEqualToString:@""] || userField.text == nil) {
        
    } else if ([pwdField.text isEqualToString:@""] || pwdField.text == nil) {
        
        
    }else{
        
        if (isAgreedAgreement) {
            //添加新内容，生成新文件
            dicNamePwd=@{@"name":[BaseMD base64EncodeString:[BaseMD base64EncodeString:userField.text]],
                         @"pwd":[BaseMD base64EncodeString:[BaseMD base64EncodeString:pwdField.text]]
                         };
            [dicNamePwd writeToFile:filename atomically:YES];
            NSLog(@"%@",dicNamePwd);
            
        }else{
            
            //删除文件夹
            [fileManager removeItemAtPath:filename error:nil];
            
        }
        
        [self.view endEditing:YES];
        
        
        
    }
    
    WKUTabBarViewController *wktabbar = [[WKUTabBarViewController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = wktabbar;
}


//即将进入这个界面时，执行该方法
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    
    self.navigationController.navigationBarHidden=YES;
    
    
    
}
//将要离开这个界面时，执行该方法
-(void)viewWillDisappear:(BOOL)animated{
    
    [self.view endEditing:YES];
    
    
}
-(void)loadLoginView{
    loginView=[[UIView alloc]initWithFrame:CGRectMake(20, 180, SCREEN_WIDTH-40, loginViewHeight)];
    loginView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    loginView.layer.cornerRadius=10;
    loginView.layer.masksToBounds=YES;
    [self.view addSubview:loginView];
    
    
    userImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 17.5, 26, 26)];
    [loginView addSubview:userImage];
    userImage.image=[UIImage imageNamed:@"login_user"];
    
    
    userField=[[UITextField alloc]initWithFrame:CGRectMake(59, 19, SCREEN_WIDTH-40-59, 23)];
    userField.placeholder=@"用户/手机号";
    [userField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [userField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    userField.tintColor=loginTintColor;
    userField.textColor=[UIColor whiteColor];
    [userField setDelegate:self];
    
    
    userField.keyboardType = UIKeyboardTypeASCIICapable;
    userField.returnKeyType = UIReturnKeyDone;
    userField.clearButtonMode = UITextFieldViewModeWhileEditing;
    userField.autocorrectionType = UITextAutocorrectionTypeNo;
    userField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    [loginView addSubview:userField];
    
    
    
    
    xianView=[[UIView alloc]initWithFrame:CGRectMake(0, loginViewHeight/2-1, SCREEN_WIDTH-40, 1)];
    [loginView addSubview:xianView];
    xianView.backgroundColor=[UIColor whiteColor];
    
    
    pwdImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 84.25, 22, 26.5)];
    [loginView addSubview:pwdImage];
    pwdImage.image=[UIImage imageNamed:@"login_pwd"];
    
    
    
    pwdField=[[UITextField alloc]initWithFrame:CGRectMake(59, 86, SCREEN_WIDTH-40-59, 23)];
    pwdField.placeholder=@"请输入密码";
    [pwdField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [pwdField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    
    pwdField.tintColor=loginTintColor;
    pwdField.textColor=[UIColor whiteColor];
    
    [pwdField setDelegate:self];
    
    pwdField.secureTextEntry=YES;
    pwdField.keyboardType = UIKeyboardTypeASCIICapable;
    pwdField.returnKeyType = UIReturnKeyDone;
    pwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
    pwdField.autocorrectionType = UITextAutocorrectionTypeNo;
    pwdField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    [loginView addSubview:pwdField];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//设置状态栏的颜色
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

//隐藏状态栏
-(BOOL)prefersStatusBarHidden{
    return NO;
}
#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    
    return YES;
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - 设置APP静态图片引导页
- (void)setStaticGuidePage {
    NSArray *imageNameArray = @[@"guideImage1.jpg",@"guideImage2.jpg",@"guideImage3.jpg",@"guideImage4.jpg",@"guideImage5.jpg"];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:[UIScreen mainScreen].bounds imageNameArray:imageNameArray buttonIsHidden:NO];
    guidePage.slideInto = YES;
    [self.navigationController.view addSubview:guidePage];
}

#pragma mark - 设置APP动态图片引导页
- (void)setDynamicGuidePage {
    NSArray *imageNameArray = @[@"guideImage6.gif",@"guideImage7.gif",@"guideImage8.gif"];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:[UIScreen mainScreen].bounds imageNameArray:imageNameArray buttonIsHidden:YES];
    guidePage.slideInto = YES;
    [self.navigationController.view addSubview:guidePage];
}

#pragma mark - 设置APP视频引导页
- (void)setVideoGuidePage {
    NSURL *videoURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"guideMovie1" ofType:@"mov"]];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:[UIScreen mainScreen].bounds videoURL:videoURL];
    [self.navigationController.view addSubview:guidePage];
}
@end
