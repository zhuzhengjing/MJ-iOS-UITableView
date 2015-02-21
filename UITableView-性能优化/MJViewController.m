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
@property (nonatomic, copy) NSMutableArray *shops;
@property (nonatomic, copy) NSMutableArray *delected;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
- (IBAction)deleteItem:(UIBarButtonItem *)sender;
@property (nonatomic, strong) UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *removeItem;

@end

@implementation MJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIToolbar *toolBar = self.view.subviews[0];
    
    CGFloat y = toolBar.frame.origin.y + toolBar.frame.size.height;
    CGRect rect = CGRectMake(0, y, self.view.frame.size.width, self.view.frame.size.height - y);
    _tableView = [[UITableView alloc] initWithFrame:rect
                                              style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];

    _shops = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shops.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    for (NSDictionary *dict in array) {
        Shop *s = [Shop shopWithDict:dict];
        [_shops addObject:s];
    }
    
    _delected = [NSMutableArray array];
}

// 返回每一section有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _shops.count;
}

// 返回一行cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    Shop *s = _shops[indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }

    cell.textLabel.text = [s name];
    cell.detailTextLabel.text = [s desc];
    cell.imageView.image = [UIImage imageNamed:[s icon]];
    
    if ([_delected containsObject:s]) {
        // 如果有选中的行，打钩
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    return cell;
}

// 设置每行高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


// 选中状态
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Shop *s = _shops[indexPath.row];
    
    if ([_delected containsObject:s] == NO) {   //如果_delected数组中么有，即代表是新选中的
        [_delected addObject:s];
    } else {
        [_delected removeObject:s];             //如果有，代表已经选中，但是又点击了一次，删除
    }
    
    if (_delected.count == 0) {
        _titleLable.text = @"淘宝";
        _removeItem.enabled = NO;
        
    } else {
        _titleLable.text = [NSString stringWithFormat:@"淘宝（%d）", _delected.count];
        _removeItem.enabled = YES;
    }
//    _titleLable.text = [NSString stringWithFormat:@"淘宝（%d）", _delected.count];
    // 刷新这一行
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


- (IBAction)deleteItem:(UIBarButtonItem *)sender
{
    NSMutableArray *array = [NSMutableArray array];
    for (Shop *s in _delected) {
        int index = [_shops indexOfObject:s];
        NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
        [array addObject:path];
    }
    [_shops removeObjectsInArray:_delected];
    
    [_delected removeAllObjects];
    
    //[_tableView reloadData];
    [_tableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationAutomatic];
    
    _removeItem.enabled = NO;
    _titleLable.text = @"淘宝";
}
@end




