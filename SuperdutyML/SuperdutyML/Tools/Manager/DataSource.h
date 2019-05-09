//
//  DataSource.h
//  SuperdutyML
//
//  Created by 吴坤 on 2019/4/12.
//  Copyright © 2019年 WK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataSource : NSObject
@property(nonatomic,copy)NSString *UserID;

+(DataSource *)sharedDataSource;
@end

NS_ASSUME_NONNULL_END
