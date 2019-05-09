//
//  MySearchViewController.m
//  FCRememberPwd
//
//  Created by 吴坤 on 2018/8/9.
//  Copyright © 2018年 fc. All rights reserved.
//

#import "MySearchViewController.h"
@interface MySearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UISearchBar *searchbar;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSArray *array;
@property(nonatomic,strong)NSArray *dataArr;
@end

@implementation MySearchViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"搜索";
    [self createsaearchUI];
   
}
-(void)createsaearchUI{
    self.searchbar = [[UISearchBar alloc]init];
     _searchbar.frame = CGRectMake(15, 10+kStatusBarAndNavigationBarHeight, [UIScreen mainScreen].bounds.size.width - 35, 35);
    [self.searchbar setPlaceholder:@"请输入搜索内容"];
    self.searchbar.backgroundColor =  [UIColor whiteColor];
    self.searchbar.delegate = self;
     UITextField *searchField = [self.searchbar valueForKey:@"_searchField"];
    //设置输入的文字的颜色以及大小
    searchField.textColor  = [UIColor blackColor];
    UIImageView *imagV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5.5, 28, 24)];
    searchField.leftView = imagV;
    imagV.contentMode = UIViewContentModeCenter;//图片的居中 不设置图片失真
    searchField.leftViewMode = UITextFieldViewModeAlways;
    imagV.image = [UIImage imageNamed:@"search_icon"];
    
     UIImage *searchBarBg = [self getImageWithColor:[UIColor clearColor] andHeight:32.0f];
    //设置背景图片
    [self.searchbar setBackgroundImage:searchBarBg];
    //设置背景色
    [_searchbar setBackgroundColor:[UIColor clearColor]];
    //设置文本框背景
    [_searchbar setSearchFieldBackgroundImage:[UIImage imageNamed:@"ic_seacrBarBgImageView@2x"] forState:UIControlStateNormal];
    
    //TODO: 搜索框的样式
    _searchbar.searchBarStyle = UISearchBarStyleMinimal;
    _searchbar.autocorrectionType = UITextAutocorrectionTypeNo;
    _searchbar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _searchbar.text = nil;
//    _searchbar.showsSearchResultsButton = YES;
//    _searchbar.showsScopeBar = YES;
//    _searchbar.scopeButtonTitles = @[@"第一",@"第二",@"最后"];

    [self.view addSubview:_searchbar];
    
   /*
     _searchbar.showsSearchResultsButton = YES; 显示右侧下拉的箭头
    
    searchBarStyle:
    UISearchBarStyleDefault, // 默认样式，和UISearchBarStyleProminent 一样
    UISearchBarStyleProminent, // 显示背景，常用在my Mail, Messages and Contacts
    UISearchBarStyleMinimal // 不显示背景，系统自带的背景色无效，自定义的有效，常用在Calendar, Notes and Music
    */
    [self createTable];
    
}

//取消
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
 
    [searchBar resignFirstResponder];
    searchBar.text = nil;
    self.table.hidden = NO;
    self.array = nil;
    self.array = self.dataArr;
    [self.table reloadData];
}
//确定
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
      [searchBar resignFirstResponder];
    NSMutableArray *results = [NSMutableArray new];
    for (NSString *astr in self.array) {
        if ([astr containsString:searchBar.text]) {
            [results addObject:astr];
        }
    }
    self.array = nil;
    self.array = results;
     [self.table reloadData];
    if (results.count==0) {
        self.table.hidden = YES;
    }
}
//搜索结果
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
        if (searchText.length == 0){
            [searchBar resignFirstResponder];
            self.table.hidden = NO;
            self.array  = self.dataArr;
            [self.table reloadData];
        }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
  
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;

}

-(void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar{
    
}

- (UIImage *)getImageWithColor:(UIColor*)color andHeight:(CGFloat)height {
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)createTable{
    self.dataArr =@[@"d",@"f",@"q",@"x",@"fa",@"d",@"dfs",@"qfsdfds",@"xhthjj",@"frtera",@"dhfg",@"b你是甜腻你是低你是唯一的升华你是 氨氮",@"你是不是啥子啊 ",@"b你到东南下面你刚刚",@"你是不是主题猪头",@"what ？",@"faky"];
    self.array = self.dataArr;
    self.table  =[[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_searchbar.frame)+10 , SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(_searchbar.frame)-10-kTabbarSafeBottomMargin) style:UITableViewStylePlain];
    [self.view addSubview:self.table];
    self.table.delegate =  self;
    self.table.dataSource = self;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indefy = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indefy];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indefy];
    }
    cell.textLabel.text = self.array[indexPath.row];
    return cell;
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
