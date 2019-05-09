//
//  DataSource.m
//  SuperdutyML
//
//  Created by 吴坤 on 2019/4/12.
//  Copyright © 2019年 WK. All rights reserved.
//

#import "DataSource.h"

@implementation DataSource
+(DataSource *)sharedDataSource{
    static DataSource *dataSource = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        dataSource = [DataSource new];
    });
    return dataSource;
    
}
@end
