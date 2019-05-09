//
//  MyCollectionViewCell.m
//  FCRememberPwd
//
//  Created by 吴坤 on 2018/8/15.
//  Copyright © 2018年 fc. All rights reserved.
//

#import "MyCollectionViewCell.h"
@interface MyCollectionViewCell()
/* 图片 */
@property (strong , nonatomic)UIImageView *goodsImageView;
/* 标题 */
@property (strong , nonatomic)UILabel *goodsLabel;
/* 实时价格 */
@property (strong , nonatomic)UILabel *priceLabel;
/* 商场价格 */
@property (strong , nonatomic)UILabel *shopLabel;

@end

@implementation MyCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createItenmUI];
    }
    return self;
}
-(void)createItenmUI{
    self.backgroundColor = [UIColor whiteColor];
    _goodsImageView = [UIImageView new];
    _goodsImageView.backgroundColor = [UIColor greenColor];
    
    _goodsLabel = [UILabel new];
    _goodsLabel.numberOfLines = 2;
    _goodsLabel.textColor = [UIColor blackColor];
    NSString *str = @" 泰国原装红牛M-150功能饮料250ml";
    NSMutableAttributedString * attribute = [[NSMutableAttributedString alloc]initWithString:str];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName,[UIColor lightGrayColor],NSForegroundColorAttributeName, nil];
    [attribute addAttributes:dic range:NSMakeRange(0, attribute.length)];
    NSTextAttachment *attach = [[NSTextAttachment alloc]init];
    attach.image = [UIImage imageNamed:@"self_buy_normal"];
      attach.bounds = CGRectMake(0, -3, 45, 15);
    NSAttributedString *attribut1 = [NSAttributedString attributedStringWithAttachment:attach];
    [attribute insertAttributedString:attribut1 atIndex:0];
    _goodsLabel.attributedText = attribute;
    
    
    _priceLabel =[UILabel new];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.font  = [UIFont systemFontOfSize:14];
    _priceLabel.text = @"￥1000.00";
    
    [self addSubview:_goodsImageView];
    [self addSubview:_goodsLabel];
    [self addSubview:_priceLabel];
}

-(void)layoutSubviews{
    _goodsImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-70);
    _goodsLabel.frame = CGRectMake(5, CGRectGetMaxY(_goodsImageView.frame)+5, self.frame.size.width-10, 40);
    _priceLabel.frame = CGRectMake(5,  CGRectGetMaxY(_goodsLabel.frame), self.frame.size.width-10, 20);
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
