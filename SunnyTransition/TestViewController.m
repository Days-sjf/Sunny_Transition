//
//  TestViewController.m
//  SunnyTransition
//
//  Created by slyao on 16/4/7.
//  Copyright © 2016年 slyao. All rights reserved.
//

#import "TestViewController.h"
#import "TestTransition.h"

@interface TestViewController ()

@property (strong, nonatomic)TestTransition *transition;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.view.userInteractionEnabled = YES;
    
//    [self.navigationItem setHidesBackButton:YES];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 100, 100);
    button.center = self.view.center;
    button.backgroundColor = [UIColor yellowColor];
    [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)back:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
