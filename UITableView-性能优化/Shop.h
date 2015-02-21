//
//  Shop.h
//  UITableView-性能优化
//
//  Created by 朱正晶 on 15/2/19.
//  Copyright (c) 2015年 China. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shop : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *desc;

+ (instancetype) shopWithName:(NSString*)name icon:(NSString*)icon desc:(NSString*)desc;
+ (instancetype) shopWithDict:(NSDictionary *)dict;

@end
