//
//  DetailCell.m
//  CookBook
//
//  Created by qianfeng on 15/7/6.
//  Copyright (c) 2015年 FanShuai. All rights reserved.
//

#import "DetailCell.h"
#import "UIImageView+WebCache.h"
@implementation DetailCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)showDataWithModel:(StepsModel *)model indexPath:(NSIndexPath *)indexPath{
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"底_1"]];
    self.stepsLabel.text=model.step;
    self.stepLabel.text=[NSString stringWithFormat:@"步骤%ld",indexPath.row+1];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
