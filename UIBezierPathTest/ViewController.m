//
//  ViewController.m
//  UIBezierPathTest
//
//  Created by ZHILEI YIN on 2016/12/15.
//  Copyright © 2016年 dodonew. All rights reserved.
//

#import "ViewController.h"
#import "LXZSignView.h"

@interface ViewController ()

@property (nonatomic, strong) LXZSignView *signView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.signView = [[LXZSignView alloc] initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, 300)];
    self.signView.backgroundColor = [UIColor yellowColor];
    self.signView.numberArray = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7", nil];
    self.signView.movePointImage = [UIImage imageNamed:@"sign_positioning"];
    self.signView.headerImage = [UIImage imageNamed:@"person"];
    [self.view addSubview:self.signView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.signView layFormValueToValue:3];
}

@end
