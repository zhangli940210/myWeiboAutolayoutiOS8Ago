//
//  ViewController.m
//  15-自定义不等高的cell-Autolayout(IOS8之前)
//
//  Created by apple on 16/2/23.
//  Copyright © 2016年 m14a.cn. All rights reserved.
//

#import "ViewController.h"
#import "XMGStatusCell.h"
#import "XMGStatus.h"
#import "MJExtension.h"

@interface ViewController ()
/** 所有的微博模型*/
@property (nonatomic ,strong) NSArray *statuses;
@end

@implementation ViewController

#pragma mark - 懒加载数据
- (NSArray *)statuses
{
    if (!_statuses) {
        _statuses = [XMGStatus mj_objectArrayWithFilename:@"statuses.plist"];
    }
    return _statuses;
}

NSString *ID = @"status";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册方法
    [self.tableView registerClass:[XMGStatusCell class] forCellReuseIdentifier:ID];
    
    // iOS8之后，界面排布
    self.tableView.estimatedRowHeight = 200;
    
}


#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 传递模型数据
    cell.status = self.statuses[indexPath.row];
    return cell;
}

// 方案:在这个方法返回之前就要确定好cell的高度
XMGStatusCell *cell; // 定义一个杯子，里面的不同的模型数据就代表不同的水量
// 水量多的，进入杯子的高度就高，水量少的，进入杯子的高度就少
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
        // 如果没有找到，那么就去注册方法里面找
    }
    cell.status = self.statuses[indexPath.row];
    return cell.cellHeight;
}

@end

