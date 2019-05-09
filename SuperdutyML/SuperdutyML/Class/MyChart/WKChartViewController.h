//
//  WKChartViewController.h
//  FCRememberPwd
//
//  Created by 吴坤 on 2018/8/16.
//  Copyright © 2018年 fc. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,ChartAnimationTypeVCChartType) {
    ChartAnimationTypeVCChartTypeColumn = 0,
    ChartAnimationTypeVCChartTypeBar,
    ChartAnimationTypeVCChartTypeArea,
    ChartAnimationTypeVCChartTypeAreaspline,
    ChartAnimationTypeVCChartTypeLine,
    ChartAnimationTypeVCChartTypeSpline,
    ChartAnimationTypeVCChartTypeStepLine,
    ChartAnimationTypeVCChartTypeStepArea,
    ChartAnimationTypeVCChartTypeScatter,
    ChartAnimationTypeVCChartTypePie,
    
};

@interface WKChartViewController : UIViewController
@property (nonatomic, assign) ChartAnimationTypeVCChartType chartType;
@end
