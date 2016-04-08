//
//  ViewController.m
//  SunnyTransition
//
//  Created by slyao on 16/4/7.
//  Copyright © 2016年 slyao. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import "TestTransition.h"
#import "TestModelTransition.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)NSArray *array;
@property (strong, nonatomic)TestTransition *transition;
@property (strong, nonatomic)TestModelTransition *modelTransition;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.array = @[@"push/pop",@"present/dismiss"];
    
    self.transition = [[TestTransition alloc] init];
    self.modelTransition = [[TestModelTransition alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell.textLabel.text = self.array[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TestViewController *vc = [[TestViewController alloc] init];

    if (indexPath.row == 0) {
        self.navigationController.delegate = self.transition;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        vc.transitioningDelegate = self.modelTransition;
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
