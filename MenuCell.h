//
//  MenuCell.h
//  CookBook
//
//  Created by qianfeng on 15/7/4.
//  Copyright (c) 2015年 FanShuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuModel.h"
@interface MenuCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *albumsImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *burdenLabel;
@property (weak, nonatomic) IBOutlet UILabel *imtroLabel;
-(void)showDataWithModel:(MenuModel *)model indexPath:(NSIndexPath *)indexPath;
@end
