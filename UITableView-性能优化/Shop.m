//
//  Shop.m
//  UITableView-性能优化
//
//  Created by 朱正晶 on 15/2/19.
//  Copyright (c) 2015年 China. All rights reserved.
//

#import "Shop.h"

@implementation Shop

+ (instancetype)shopWithName:(NSString *)name icon:(NSString *)icon desc:(NSString *)desc
{
    Shop *s = [[self alloc] init];
    s.name = name;
    s.icon = icon;
    s.desc = desc;
    
    return s;
}

+ (instancetype) shopWithDict:(NSDictionary *)dict
{
    Shop *s = [self shopWithName:dict[@"name"] icon:dict[@"icon"] desc:dict[@"desc"]];
    
    return s;
}


@end
