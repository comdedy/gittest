//
//  BaseMD.h
//  LuckyAuction
//
//  Created by Jason on 2017/4/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseMD : NSObject
//base64加密
+ (NSString *)base64EncodeString:(NSString *)string;
//对base64编码后的字符串进行解码
+ (NSString *)base64DecodeString:(NSString *)string;
//md5加密
+ (NSString *)MD5ForLower32Bate:(NSString *)str;
@end
