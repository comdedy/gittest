//
//  WKListViewController.m
//  OperationMaintenance
//
//  Created by 吴坤 on 2018/6/15.
//  Copyright © 2018年 TestGhost. All rights reserved.
//

#import "WKListViewController.h"
#import "ZHFAddTitleAddressView.h"
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height
@interface WKListViewController ()<ZHFAddTitleAddressViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;
@property(nonatomic,strong)ZHFAddTitleAddressView * addTitleAddressView;
@end

@implementation WKListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [self setUI];
}
-(void)setUI{
    self.addTitleAddressView = [[ZHFAddTitleAddressView alloc]init];
    self.addTitleAddressView.title = @"选择地址";
    self.addTitleAddressView.userID = 7;
    self.addTitleAddressView.delegate1 = self;
    self.addTitleAddressView.defaultHeight = 350;
    self.addTitleAddressView.titleScrollViewH = 37;
    [self.view addSubview:[self.addTitleAddressView initAddressView]];
}
- (IBAction)addressBtnClick:(id)sender {
    [self.addTitleAddressView addAnimate];
}
-(void)cancelBtnClick:(NSString *)titleAddress CountyModel:(CountyModel *)countyModel{
    [self.addressBtn setTitle:titleAddress forState:UIControlStateNormal];
    NSLog( @"%@", [NSString stringWithFormat:@"打印的对应省市县的id=%@---%@---%@",countyModel.SiteName,countyModel.SiteTypeName,countyModel.ID]);
    
  
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
