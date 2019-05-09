//
//  WKScrollView.h
//  YNPageViewController
//
//  Created by 吴坤 on 2018/7/2.
//  Copyright © 2018年 yongneng. All rights reserved.
//

#import <UIKit/UIKit.h>
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
@interface WKScrollView : UIView
@property(nonatomic,strong)UIScrollView *scrollview;
@property(nonatomic,strong)UIView *lineLab;
@property(nonatomic,strong)NSArray *btnArray;
-(instancetype)initWithFrame:(CGRect)frame TitArr:(NSArray *)tiArr viewArr:(NSArray *)viewArray;
@end
