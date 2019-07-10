
//
//  MeViewController.m
//  SuperdutyML
//
//  Created by 吴坤 on 2019/4/10.
//  Copyright © 2019年 WK. All rights reserved.
//

#import "MeViewController.h"

@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

 
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.view addSubview:but];
    
    [but addTarget:self action:@selector(handleAction) forControlEvents:UIControlEventTouchDown];
    
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
//        make.width.mas_equalTo(100);
        make.left.mas_offset(100);
        make.right.mas_offset(-100);
        make.height.mas_equalTo(36);
    }];
    but.backgroundColor = [UIColor redColor];
    [but setTitle:@"弹弹" forState:UIControlStateNormal];
    
}
-(void)handleAction{
    
    [LEEAlert alert].config
    .LeeAddTitle(^(UILabel * _Nonnull label) {
        label.text = @"提示";
    })
    .LeeAddContent(^(UILabel *label){
        label.text = @"这是 一次深层次的测试你看看这此能不能成功";
    })
    .LeeAddAction(^(LEEAction * _Nonnull action) {
        action.title = @"取消";
        action.type = LEEActionTypeCancel;
    })
    .LeeAddAction(^(LEEAction * _Nonnull action) {
        action.type = LEEActionTypeDefault;
        action.title = @"确定";
        action.acb
    })
    
    
    .LeeShow();
    ;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
