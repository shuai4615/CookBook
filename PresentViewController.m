//
//  PresentViewController.m
//  CookBook
//
//  Created by qianfeng on 15/7/6.
//  Copyright (c) 2015年 FanShuai. All rights reserved.
//

#import "PresentViewController.h"
#import "UIImageView+WebCache.h"
@interface PresentViewController ()
@property (weak, nonatomic) IBOutlet UIView *presentView;
@property (weak, nonatomic) IBOutlet UILabel *ideLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *stepsLabel;

@end

@implementation PresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showData];
}
-(void)showData{
    self.ideLabel.text=[NSString  stringWithFormat:@"%ld/%ld",(long)self.idx+1,(long)self.stepcount];
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:self.pic] placeholderImage:[UIImage imageNamed:@"placeholder_11_big" ]];
    self.stepsLabel.text=self.note;
    self.noteLabel.text=[NSString stringWithFormat:@"%ld.",(long)self.idx+1];
    
    self.presentView.layer.masksToBounds=YES;
    self.presentView.layer.cornerRadius=10;
    self.picImageView.layer.masksToBounds=YES;
    self.picImageView.layer.cornerRadius=5;
    self.ideLabel.layer.masksToBounds=YES;
    self.ideLabel.layer.cornerRadius=5;

}


@end
