//
//  ViewController.m
//  TimeButton
//
//  Created by ydz on 16/5/12.
//  Copyright © 2016年 ydz. All rights reserved.
//

#import "ViewController.h"
#import "JXTimeButton.h"

@interface ViewController ()<UIGestureRecognizerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JXTimeButton * timeBtn = [[JXTimeButton alloc] initWithFrame:CGRectMake(0, 20, 100, 40) AndBeforeTitle:@"获取验证码" AndWorkingMarkStr:@"重新获取" AndTimeSum:60 AndTimeButtonStar:^{
        NSLog(@"STAR");
    } AndTimeButtonStop:^{
        NSLog(@"STOP");
    }];
    timeBtn.center = self.view.center;
    timeBtn.font = [UIFont systemFontOfSize:15];
    timeBtn.textAlignment = 1;
    timeBtn.backgroundColor = [UIColor orangeColor];
    timeBtn.layer.masksToBounds = YES;
    timeBtn.layer.cornerRadius = 5;
    
    [self.view addSubview:timeBtn];
}



@end
