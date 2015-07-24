//
//  DetailCell.h
//  CookBook
//
//  Created by qianfeng on 15/7/6.
//  Copyright (c) 2015年 FanShuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StepsModel.h"
@interface DetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepsLabel;
-(void)showDataWithModel:(StepsModel *)model indexPath:(NSIndexPath *)indexPath;
@end
