//
//  FoodCell.m
//  CookBook
//
//  Created by qianfeng on 15/7/3.
//  Copyright (c) 2015年 FanShuai. All rights reserved.
//

#import "FoodCell.h"
#import "UIImageView+WebCache.h"
@implementation FoodCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)showDataWithModel:(FoodModel *)model indexPath:(NSIndexPath *)indexPath{
    [self.iconImageVIew sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"底_1"]];
    self.titleLabel.text=model.title;
    self.subtitleLabel.text=model.sub_title;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
