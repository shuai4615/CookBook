//
//  DetailViewController.h
//  CookBook
//
//  Created by qianfeng on 15/7/5.
//  Copyright (c) 2015年 FanShuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuModel.h"
#import "HeaderView.h"
#import "StepsModel.h"
@interface DetailViewController : UIViewController
@property(nonatomic,strong)MenuModel * model;
@property(nonatomic,strong)StepsModel * stepsmodel;
@property(nonatomic)int count;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)HeaderView * headerView;
@property(nonatomic)NSData * men;
@end
