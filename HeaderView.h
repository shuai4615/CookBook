//
//  HeaderView.h
//  CookBook
//
//  Created by qianfeng on 15/7/6.
//  Copyright (c) 2015年 FanShuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuModel.h"
@interface HeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *collectionButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (weak, nonatomic) IBOutlet UILabel *imtroLabel;
@property (weak, nonatomic) IBOutlet UILabel *functionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;

-(void)showHeaderViewWithModel:(MenuModel *)model;
@end
