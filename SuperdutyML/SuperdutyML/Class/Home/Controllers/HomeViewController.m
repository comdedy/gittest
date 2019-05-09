//
//  HomeViewController.m
//  SuperdutyML
//
//  Created by 吴坤 on 2019/4/10.
//  Copyright © 2019年 WK. All rights reserved.
//

#import "HomeViewController.h"
#import "MySearchViewController.h"
#import "WKScrollView.h"
#import "WKListViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor grayColor];
    [self createRightItems];
    [self createSubUI];
    NSLog(@"000");
}
-(void)createRightItems{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchAction)];

}
-(void)searchAction{
    MySearchViewController *searchvc = [[MySearchViewController alloc]init];
    [self.navigationController pushViewController:searchvc animated:YES];
}

-(void)createSubUI{
    WKListViewController *wklist = [[WKListViewController alloc]init];
    [self addChildViewController:wklist];
//    WKScrollView *scroller = [[WKScrollView alloc]initWithFrame:CGRectMake(0, kStatusBarAndNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kStatusBarAndNavigationBarHeight-kTabbarHeight) TitArr:@[@"第一",@"第二",@"第三"] viewArr:@[wklist.view,[UIView new],[UIView new]]];
//    [self.view addSubview:scroller];
    [self.view addSubview:wklist.view];

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
