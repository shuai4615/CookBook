//
//  MenuCell.m
//  CookBook
//
//  Created by qianfeng on 15/7/4.
//  Copyright (c) 2015年 FanShuai. All rights reserved.
//

#import "MenuCell.h"
#import "UIImageView+WebCache.h"
@implementation MenuCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)showDataWithModel:(MenuModel *)model indexPath:(NSIndexPath *)indexPath{
    [self.albumsImageView sd_setImageWithURL:[NSURL URLWithString:model.albums] placeholderImage:[UIImage imageNamed:@"底_1"]];
    self.titleLabel.text=model.title;
    self.burdenLabel.text=model.burden;
    self.imtroLabel.text=model.imtro;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
