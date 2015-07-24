//
//  FoodCell.h
//  CookBook
//
//  Created by qianfeng on 15/7/3.
//  Copyright (c) 2015年 FanShuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodModel.h"
@interface FoodCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
-(void)showDataWithModel:(FoodModel *)model indexPath:(NSIndexPath *)indexPath;

@end
