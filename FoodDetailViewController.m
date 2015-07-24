//
//  FoodDetailViewController.m
//  CookBook
//
//  Created by qianfeng on 15/7/4.
//  Copyright (c) 2015年 FanShuai. All rights reserved.
//

#import "FoodDetailViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MyControl.h"
#import "LZXHelper.h"
#import "SVProgressHUD.h"
#define kurl @"http://food.boohee.com/fb/v1/topics/%@"
#define collectionViewCellID @"NewCollectionViewCell"

@interface FoodDetailViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
}
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)UIPageControl * pageControl;
@end

@implementation FoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithPage];
    [self initUI];
    [self fetchWebData];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor whiteColor];
}
-(void)initUI{
    self.scrollView=[[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.pagingEnabled=YES;
    int pager=self.page.intValue;
    self.scrollView.contentSize=CGSizeMake(self.view.frame.size.width*pager, self.view.frame.size.height);
    self.scrollView.showsVerticalScrollIndicator=NO;
    self.scrollView.bounces=NO;
    [self.view addSubview:self.scrollView];

}
-(void)initWithPage{
    CGRect frame = CGRectMake(_scrollView.frame.origin.x, CGRectGetMaxY(_scrollView.frame)-100, _scrollView.frame.size.width, 40);
    _pageControl = [[UIPageControl alloc] initWithFrame:frame];
    [_pageControl addTarget:self action:@selector(pageControlClick:) forControlEvents:UIControlEventValueChanged];
    _pageControl.numberOfPages  = self.page.intValue;
    _pageControl.backgroundColor = [UIColor redColor];
    [self.view addSubview:_pageControl];

}
-(void)pageControlClick:(UIPageControl *)pageControl{
[_scrollView setContentOffset:CGPointMake(pageControl.currentPage*_scrollView.frame.size.width, 0) animated:YES];

}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
    _pageControl.currentPage = currentPage;

}
-(void)fetchWebData{
    [SVProgressHUD showWithStatus:@"下载中..." maskType:SVProgressHUDMaskTypeBlack];
    AFHTTPRequestOperationManager * manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:kurl,self.num] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            NSDictionary * dicte=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil ];
            NSDictionary * dict=dicte[@"topic"];
            NSArray * arr=dict[@"pages"];
            int i=0;
            for (NSDictionary * dic in arr) {
                UIView * imageView=[[UIView alloc] initWithFrame:CGRectMake(i*self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
                UIImageView *iconImage=[[UIImageView alloc] init];
                NSString * str=dic[@"image_url"];
                [iconImage sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@""]];
                iconImage.frame=CGRectMake(0,60, self.view.frame.size.width, 200);
                [imageView addSubview:iconImage];
                UILabel * titleLabel=[MyControl creatLabelWithFrame:CGRectMake(8, 200+62, self.view.frame.size.width-12, 20) text:dic[@"food_name"]];
                titleLabel.font=[UIFont systemFontOfSize:20];
                titleLabel.textColor=[UIColor redColor];
                [imageView addSubview:titleLabel];
                UITextView * textView=[[UITextView alloc] initWithFrame:CGRectMake(2, 284, self.view.frame.size.width-4, self.view.frame.size.height-325)];
                textView.text=dic[@"description"];
                textView.editable=NO;
                textView.font=[UIFont systemFontOfSize:16];
                [imageView addSubview:textView];
                [self.scrollView addSubview:imageView];
                i++;
            }
        }
        
        [SVProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
            }];
    
    
}
@end
