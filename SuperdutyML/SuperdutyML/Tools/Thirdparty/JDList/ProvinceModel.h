//
//  ProvinceModel.h
//  ZHFJDAddressOC
//
//  Created by 张海峰 on 2017/12/18.
//  Copyright © 2017年 张海峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProvinceModel : NSObject
@property(nonatomic,copy)NSString *ID;
//@property(nonatomic,assign)NSInteger id;
//@property(nonatomic,assign)NSInteger is_enabled;
@property(nonatomic,copy)NSString *DictName;
@property(nonatomic,assign)NSInteger DictType;
@property(nonatomic,copy)NSString *DictCount;
@property(nonatomic,copy)NSString *ParentName;
@end
