//
//  CountyModel.h
//  ZHFJDAddressOC
//
//  Created by 张海峰 on 2017/12/18.
//  Copyright © 2017年 张海峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountyModel : NSObject
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *SiteName;

@property(nonatomic,copy)NSString *TownName;
@property(nonatomic,copy)NSString *SiteTypeName;

@property(nonatomic,copy)NSString *Address;
@property(nonatomic,copy)NSString *Contacts;

@property(nonatomic,copy)NSString *Phone;
@property(nonatomic,copy)NSString *Area;

@end
