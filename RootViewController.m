//
//  RootViewController.m
//  CookBook
//
//  Created by qianfeng on 15/7/3.
//  Copyright (c) 2015年 FanShuai. All rights reserved.
//

#import "RootViewController.h"
#import "MenuViewController.h"
#import "FoodViewController.h"
#import "MyViewController.h"
#import "MyControl.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatLaunchImageAnimation];
    [self setTabBar];
    [self setviewController];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_background"] forBarMetrics:UIBarMetricsDefault];
}
-(void)creatLaunchImageAnimation{
    UIImageView * imageView=[MyControl creatImageViewWithFrame:self.view.bounds imageName:[NSString stringWithFormat:@"startImage%u.jpg",arc4random()%11+1]];
    [self.view addSubview:imageView];
    [UIView animateWithDuration:2 animations:^{
        imageView.alpha=0;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];

}
-(void)setTabBar{
    self.tabBar.backgroundImage=[UIImage imageNamed:@"tabbar_background"];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:230/255.0 green:139/255.0 blue:79/255.0 alpha:1.0]} forState:UIControlStateSelected];
}
-(void)setviewController{
    MenuViewController * mvc=[[MenuViewController alloc] init];
    mvc.title=@"热门菜谱";
    
    UINavigationController * nmvc=[[UINavigationController alloc] initWithRootViewController:mvc];
    nmvc.tabBarItem.image=[UIImage imageNamed:@"tabbar_item_tuijian"];
    nmvc.tabBarItem.selectedImage=[[UIImage imageNamed:@"tabbar_item_tuijian_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    FoodViewController * fvc=[[FoodViewController alloc] init];
    fvc.title=@"食物库";
    UINavigationController * nfvc=[[UINavigationController alloc] initWithRootViewController:fvc];
    nfvc.tabBarItem.image=[UIImage imageNamed:@"tabbar_item_zhuanti"];
    nfvc.tabBarItem.selectedImage=[[UIImage imageNamed:@"tabbar_item_zhuanti_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    MyViewController * vc=[[MyViewController alloc] init];
    vc.title=@"我的设置";
    UINavigationController * nvc=[[UINavigationController alloc] initWithRootViewController:vc];
    nvc.tabBarItem.image=[UIImage imageNamed:@"tabbar_item_profile"];
    nvc.tabBarItem.selectedImage=[[UIImage imageNamed:@"tabbar_item_profile_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.viewControllers=@[nmvc,nfvc,nvc];
    
}

@end
