//
//  HeaderView.m
//  CookBook
//
//  Created by qianfeng on 15/7/6.
//  Copyright (c) 2015年 FanShuai. All rights reserved.
//

#import "HeaderView.h"
#import "UIImageView+WebCache.h"

@implementation HeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)showHeaderViewWithModel:(MenuModel *)model{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.albums] placeholderImage:[UIImage imageNamed:@"底_1"]];
    self.nameLabel.text=model.title;
    self.imtroLabel.text=model.imtro;
    self.functionLabel.text=model.tags;
    self.dataLabel.text=model.burden;


}


@end
