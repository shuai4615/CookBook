//
//  PresentViewController.h
//  CookBook
//
//  Created by qianfeng on 15/7/6.
//  Copyright (c) 2015年 FanShuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PresentViewController : UIViewController
@property (nonatomic)NSInteger stepcount;
@property (nonatomic)NSInteger idx;
@property (nonatomic,copy)NSString * pic;
@property (nonatomic,copy)NSString * note;
-(void)showData;
@end
