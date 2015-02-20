//
//  MJViewController.m
//  UITableView-性能优化
//
//  Created by 朱正晶 on 15/2/19.
//  Copyright (c) 2015年 China. All rights reserved.
//

#import "MJViewController.h"
#import "Shop.h"


@interface MJViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) NSMutableArray *shops;
@end

@implementation MJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIToolbar *toolBar = self.view.subviews[0];
    
    CGFloat y = toolBar.frame.origin.y + toolBar.frame.size.height;
    CGRect rect = CGRectMake(0, y, self.view.frame.size.width, self.view.frame.size.height - y);
    UITableView *tableView = [[UITableView alloc] initWithFrame:rect
                                                          style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];

    _shops = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shops.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    for (NSDictionary *dict in array) {
        Shop *shop = [[Shop alloc] init];
        shop.name = dict[@"name"];
        shop.icon = dict[@"icon"];
        shop.desc = dict[@"desc"];
        
        [_shops addObject:shop];
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _shops.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }

    cell.textLabel.text = [_shops[indexPath.row] name];
    cell.detailTextLabel.text = [_shops[indexPath.row] desc];
    cell.imageView.image = [UIImage imageNamed:[_shops[indexPath.row] icon]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

@end
