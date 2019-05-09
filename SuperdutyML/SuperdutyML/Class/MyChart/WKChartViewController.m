//
//  WKChartViewController.m
//  FCRememberPwd
//
//  Created by 吴坤 on 2018/8/16.
//  Copyright © 2018年 fc. All rights reserved.
//

#import "WKChartViewController.h"
#import "AAChartKit.h"

#define ColorWithRGB(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define KBlueColor         ColorWithRGB(63, 153,231,1)
@interface WKChartViewController ()
@property (nonatomic, strong) AAChartView  *chartView;
@property (nonatomic, strong) AAChartModel *chartModel;
@property (nonatomic, strong) NSArray      *animationTypeArr;
@end

@implementation WKChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"动画类型";

    [self configureTheChartViewWithChartType:AAChartTypeArea];
}
- (void)configureTheChartViewWithChartType:(AAChartType)chartType {
    self.chartView = [[AAChartView alloc]initWithFrame:CGRectMake(0, kStatusBarAndNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kStatusBarAndNavigationBarHeight-100)];
    self.view.backgroundColor = [UIColor whiteColor];
    self.chartView.scrollEnabled = NO;
    // self.chartView.contentHeight = self.view.frame.size.height-220;
    [self.view addSubview:self.chartView];
    
    self.chartModel = AAObject(AAChartModel)
    .chartTypeSet(chartType)
    .animationDurationSet(@150)
    .titleSet(@"标题一")
    .subtitleSet(@"标题二")
    .categoriesSet(@[@"Java",@"Swift",@"Python",@"Ruby", @"PHP",@"Go",@"C",@"C#",@"C++",@"Perl",@"R",@"MATLAB",@"SQL"])
    .yAxisTitleSet(@"标题三")
    ;
    //直方折线图
//        self.chartModel
//        .gradientColorEnabledSet(true)
//        .markerRadiusSet(@0)
//        .seriesSet(@[
//                     AAObject(AASeriesElement)
//                     .nameSet(@"2017")
//                     .dataSet(@[@0, @1, @1, @0, @1, @1, @0, @0, @0, @1, @1, @0])
//                     .stepSet((id)@(true))
//                     ,
//                     ]
//                   );
    //折线图填充
    NSDictionary *gradientColorDic = @{
                                       @"linearGradient": @{
                                               @"x1": @0,
                                               @"y1": @1,
                                               @"x2": @0,
                                               @"y2": @0
                                               },
                                       @"stops": @[@[@0,@"rgba(255,140,0,0.2)"],
                                                   @[@1,@"rgba(220,20,60,1)"]]//颜色字符串设置支持十六进制类型和 rgba 类型
                                       };
    self.chartModel
    .markerRadiusSet(@3)//节点
    .gradientColorEnabledSet(true)
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(@"2018")
                 .dataSet(@[@0.9, @0.6, @3.5, @8.4, @13.5, @17.0, @18.6, @17.9, @14.3, @9.0, @50.0, @1.0])
                 .colorSet((id)gradientColorDic)
                 ,
                 ]);
    [self.chartView aa_drawChartWithChartModel:self.chartModel];
}

- (void)animationTypeTableViewClicked:(AAChartAnimation)chartAnimationType {
    self.chartModel.animationType = chartAnimationType;
    [self.chartView aa_refreshChartWithChartModel:self.chartModel];//刷新图表数据
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
