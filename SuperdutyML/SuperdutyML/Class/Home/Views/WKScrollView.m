//
//  WKScrollView.m
//  YNPageViewController
//
//  Created by 吴坤 on 2018/7/2.
//  Copyright © 2018年 yongneng. All rights reserved.
//

#import "WKScrollView.h"
@interface WKScrollView ()<UIScrollViewDelegate>

@end

@implementation WKScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame TitArr:(NSArray *)tiArr viewArr:(NSArray *)viewArray{
    if (self = [super initWithFrame:frame]) {
        CGFloat viewW = frame.size.width;
        CGFloat viewH = frame.size.height;
        
        NSMutableArray *arr = [NSMutableArray new];
        for (int i = 0; i < tiArr.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i*viewW/tiArr.count, 0, viewW/tiArr.count,29);
            [btn setTitle:tiArr[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            btn.tag = 100+i;
            [arr addObject:btn];
            self.backgroundColor = [UIColor whiteColor];
        }
        self.btnArray = arr;
        
        for (int i = 0; i< tiArr.count; i++) {
            if (i==0) {
                UIButton *but = self.btnArray[i];
                but.selected = YES;
            }else{
                UIButton *but = self.btnArray[i];
                but.selected = NO;
            }
        }
        _lineLab = [[UIView alloc]initWithFrame:CGRectMake(0,29, viewW/tiArr.count, 1)];
        [self addSubview:_lineLab];
        _lineLab.backgroundColor = [UIColor greenColor];
        
        _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, viewW, viewH-30)];
        self.scrollview.pagingEnabled= YES;
        [self addSubview:_scrollview];
        _scrollview.delegate = self;
        _scrollview.contentSize = CGSizeMake(self.btnArray.count*viewW,viewH-30);
        _scrollview.backgroundColor =  [UIColor lightGrayColor];
        self.scrollview.bounces= NO;
        self.scrollview.alwaysBounceVertical = NO;
        for (int i = 0; i< viewArray.count; i++) {
            UIView *aview = viewArray[i];
            aview.frame = CGRectMake(i*viewW, 0, viewW, viewH);
            [self.scrollview addSubview:aview];
            aview.backgroundColor = randomColor;
        }
       
    }
    return self;
}

-(void)handleAction:(UIButton *)sender{
    NSInteger index = sender.tag - 100;
    [UIView animateWithDuration:0.0 animations:^{
        _lineLab.frame = CGRectMake(index*self.frame.size.width/self.btnArray.count,29, self.frame.size.width/self.btnArray.count, 1);
    }];
    
    for (int i = 0; i< self.btnArray.count; i++) {
        if (i==index) {
            UIButton *but = self.btnArray[i];
            but.selected = YES;
        }else{
            UIButton *but = self.btnArray[i];
            but.selected = NO;
        }
    }
    
    CGPoint z = self.scrollview.contentOffset;
    z.x = self.btnArray.count*_lineLab.frame.origin.x;
    self.scrollview.contentOffset = z;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint z = scrollView.contentOffset;
    CGFloat x = z.x;
    int index = fabs(x/self.frame.size.width);
      [UIView animateWithDuration:0.0 animations:^{
           _lineLab.frame = CGRectMake(index*self.frame.size.width/self.btnArray.count,29, self.frame.size.width/self.btnArray.count, 1);
      }];
    for (int i = 0; i< self.btnArray.count; i++) {
        if (i==index) {
            UIButton *but = self.btnArray[i];
            but.selected = YES;
        }else{
            UIButton *but = self.btnArray[i];
            but.selected = NO;
        }
    }
}

@end
