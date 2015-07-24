//
//  MenuDetailViewController.h
//  CookBook
//
//  Created by qianfeng on 15/7/4.
//  Copyright (c) 2015年 FanShuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHRefresh.h"
#import "StepsModel.h"
@interface MenuDetailViewController : UIViewController
{
    BOOL _isRefreshing;
    BOOL _isLoadMore;
}
@property(nonatomic,copy)NSString * url;

@end
