//
//  WKUTabBarViewController.m
//  SuperdutyML
//
//  Created by 吴坤 on 2019/4/10.
//  Copyright © 2019年 WK. All rights reserved.
//

#import "WKUTabBarViewController.h"
#import "HomeViewController.h"
#import "MeViewController.h"
#import "AxcAE_TabBar.h"
#import "MyCollectionViewController.h"
#import "WKChartViewController.h"
#import "WKListViewController.h"
@interface WKUTabBarViewController ()<AxcAE_TabBarDelegate>
@property(nonatomic , strong) AxcAE_TabBar *axcAETabBar;
@end

@implementation WKUTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createAXCAE_TabBar];
}
-(void)createAXCAE_TabBar{
    NSArray<NSDictionary *>*vcArr = @[
                                      @{@"vc":[[HomeViewController alloc]init],@"normalImg":@"tab_contact_unselect.png",@"selectImg":@"tab_contact_select.png",@"itemTitle":@"首页"},
  @{@"vc":[[MyCollectionViewController alloc]init],@"normalImg":@"农污监管1",@"selectImg":@"农污监管",@"itemTitle":@"内容"},
  @{@"vc":[[WKListViewController alloc]init],@"normalImg":@"农污监管1",@"selectImg":@"农污监管",@"itemTitle":@"内容"},
  @{@"vc":[[WKChartViewController alloc]init],@"normalImg":@"tab_home_unselect",@"selectImg":@"tab_home_select",@"itemTitle":@"详情"},
  @{@"vc":[[MeViewController alloc]init],@"normalImg":@"tab_contact_unselect.png",@"selectImg":@"tab_contact_select.png",@"itemTitle":@"我的"}];
    
    NSMutableArray *tabbarconfs = @[].mutableCopy;
    NSMutableArray *tabbarVC = @[].mutableCopy;
    [vcArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        AxcAE_TabBarConfigModel *model = [[AxcAE_TabBarConfigModel alloc]init];
        model.itemTitle = [obj objectForKey:@"itemTitle"];
        model.selectImageName = [obj objectForKey:@"selectImg"];
        model.normalImageName = [obj objectForKey:@"normalImg"];
        model.selectColor = [UIColor blueColor];
        if (idx == 2) {
            //设置凸显
            model.bulgeStyle = AxcAE_TabBarConfigBulgeStyleCircular;
            //设置纯文字展示
            model.itemLayoutStyle = AxcAE_TabBarItemLayoutStyleTitle;
            //文字为➕好
            model.itemTitle = @"+";
            //字号大小
            model.titleLabel.font = [UIFont systemFontOfSize:50];
            model.normalColor = [UIColor grayColor];
            model.selectColor = [UIColor whiteColor];
            //让Lable上下左右全边距 稍微上拉一点
            model.componentMargin = UIEdgeInsetsMake(-10, 0, 0, 0 );
            //未选中状态w是白色
            model.normalBackgroundColor = [UIColor whiteColor];
            //选中状态是橘色
            model.selectBackgroundColor = [UIColor orangeColor];
            //设置大小/边长
            model.itemSize = CGSizeMake(40, 69);//自动一长宽中最大值进行切圆
            
            
        }
        UIViewController *vc = [obj objectForKey:@"vc"];
        UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:vc];
      
        [tabbarVC addObject:na];
        [tabbarconfs addObject:model];
    }];
    
     self.viewControllers = tabbarVC;
    self.axcAETabBar = [AxcAE_TabBar new];
    self.axcAETabBar.tabBarConfig = tabbarconfs;
    self.axcAETabBar.delegate = self;
    [self.tabBar addSubview:self.axcAETabBar];
}

-(void)axcAE_TabBar:(AxcAE_TabBar *)tabbar selectIndex:(NSInteger)index{
 //通知 切换视图控制器
    [self setSelectedIndex:index];
    //自定义的axce 回调点击事件给TabBarvc  用父类的tabbarControllers函数完成切换
    
}
-(void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    if (self.axcAETabBar) {
        if (self.axcAETabBar.selectIndex !=2) {
//            self.axcAETabBar.selectIndex = self.selectedIndex;
        }else{
            NSLog(@"就是干掉他%lu",(unsigned long)self.axcAETabBar.selectIndex );
        }
    }
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.axcAETabBar.frame = self.tabBar.bounds;
    [self.axcAETabBar viewDidLayoutItems];
    
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
