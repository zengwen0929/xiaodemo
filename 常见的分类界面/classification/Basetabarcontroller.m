//
//  Basetabarcontroller.m
//  GiftSay
//
//  Created by lanou on 15/12/16.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "Basetabarcontroller.h"
#import "ClassViewController.h"
#import "AppDelegate.h"
@interface Basetabarcontroller ()

@end

@implementation Basetabarcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = [UIColor redColor];
   // self.tabBar.barTintColor = [UIColor blackColor];
    
      ClassViewController*classList=[[ClassViewController alloc]init];
    //classList.title=@"分类";
  
   
    [self addChildViewController:classList title:@"分类" image:@""];
   
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 20, 18);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    //self.tabBar.barTintColor = [UIColor redColor];
}
- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image{
    
    UINavigationController *childVC = [[UINavigationController alloc]initWithRootViewController:childController];
    childVC.tabBarItem.title = title;
      childVC.tabBarItem.image = [UIImage imageNamed:image];
    childVC.navigationBar.barTintColor = [UIColor whiteColor];
      
    [self addChildViewController:childVC];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
