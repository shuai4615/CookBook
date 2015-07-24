//
//  MenuViewController.m
//  CookBook
//
//  Created by qianfeng on 15/7/3.
//  Copyright (c) 2015年 FanShuai. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuDetailViewController.h"
#import "SearchViewController.h"
#define  kScreenSize [UIScreen mainScreen].bounds.size
#define kHomeFoodUrl @"http://caipu.yjghost.com/index.php/query/read?menu=%E5%AE%B6%E5%B8%B8%E8%8F%9C&rn=15&start="
#define kCreativeUrl @"http://caipu.yjghost.com/index.php/query/read?menu=%E5%88%9B%E6%84%8F%E8%8F%9C&rn=15&start="
#define kFastUrl     @"http://caipu.yjghost.com/index.php/query/read?menu=%E5%BF%AB%E6%89%8B%E8%8F%9C&rn=15&start="
#define kVegetableUrl @"http://caipu.yjghost.com/index.php/query/read?menu=%E7%B4%A0%E8%8F%9C&rn=15&start="
#define kColdUrl     @"http://caipu.yjghost.com/index.php/query/read?menu=%E5%87%89%E8%8F%9C&rn=15&start="
#define kBakingUrl  @"http://caipu.yjghost.com/index.php/query/read?menu=%E7%83%98%E7%84%99&rn=15&start="
#define kNoodleUrl  @"http://caipu.yjghost.com/index.php/query/read?menu=%E9%9D%A2%E9%A3%9F&rn=15&start="
@interface MenuViewController ()<UIScrollViewDelegate>
{
    UIScrollView * _scrollView;
}
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatScrollView];
    [self initUI];
}



-(void)creatScrollView{
    _scrollView=[[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.contentSize=CGSizeMake(self.view.frame.size.width, 1200);
    _scrollView.bounces=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.delegate=self;
    [self.view addSubview:_scrollView];
    UIBarButtonItem * item=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabbar_item_search"] style:UIBarButtonItemStylePlain target:self action:@selector(itemClick)];
    self.navigationItem.rightBarButtonItem=item;
    
}
-(void)itemClick{
    SearchViewController * svc=[[SearchViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
}
-(void)initUI{
    CGRect frame=CGRectMake(4, 4,kScreenSize.width-8 , 280);
    UIButton * homefoodButton=[MyControl creatButtonWithFrame:frame target:self sel:@selector(homefoodBtnClick:) tag:0 image:@"1_6.png" title:nil];
    [_scrollView addSubview:homefoodButton];
    
    frame.origin.y=CGRectGetMaxY(frame)+4;
    frame.size.width=(kScreenSize.width-16)/2;
    frame.size.height=260;
    UIButton * creativeBtn=[MyControl creatButtonWithFrame:frame target:self sel:@selector(creativeBtnClick:) tag:0 image:@"2_4.png" title:nil];
    [_scrollView addSubview:creativeBtn];
    
    frame.origin.x=CGRectGetMaxX(frame)+8;
    UIButton * fastBtn=[MyControl creatButtonWithFrame:frame target:self sel:@selector(fastBtnClick:) tag:0 image:@"3_2.png" title:nil];
    [_scrollView addSubview:fastBtn];
    
    frame.origin.x=4;
    frame.origin.y=CGRectGetMaxY(frame)+4;
    UIButton *  vegetableBtn=[MyControl creatButtonWithFrame:frame target:self sel:@selector(vegetableBtnClick:) tag:0 image:@"4_1" title:nil];
    [_scrollView addSubview:vegetableBtn];
    frame.origin.x=CGRectGetMaxX(frame)+8;
    UIButton * coldBtn=[MyControl creatButtonWithFrame:frame target:self sel:@selector(coldBtnClick:) tag:0 image:@"5_4" title:nil];
    [_scrollView addSubview:coldBtn];
    
    frame.origin.x=4;
    frame.origin.y=CGRectGetMaxY(frame)+4;
    frame.size.width=kScreenSize.width-8;
    frame.size.height=175;
    UIButton * bakingBtn=[MyControl creatButtonWithFrame:frame target:self sel:@selector(bakingBtnClick:) tag:0 image:@"烘焙.jpeg" title:nil];
    [_scrollView addSubview:bakingBtn];
    
    frame.origin.y=CGRectGetMaxY(frame)+4;
    UIButton * noodleBtn=[MyControl creatButtonWithFrame:frame target:self sel:@selector(noodleBtnClick:) tag:0 image:@"面食.jpg" title:nil];
    [_scrollView addSubview:noodleBtn];
    
}
-(void)homefoodBtnClick:(UIButton *)button{
    MenuDetailViewController * mvc=[[MenuDetailViewController alloc] init];
    mvc.url=kHomeFoodUrl;
    mvc.navigationItem.title=@"家常菜";
    [self.navigationController pushViewController:mvc animated:YES];
}
-(void)creativeBtnClick:(UIButton *)btn{
    MenuDetailViewController * mvc=[[MenuDetailViewController alloc] init];
    mvc.url=kCreativeUrl;
    mvc.navigationItem.title=@"创意菜";
    [self.navigationController pushViewController:mvc animated:YES];

}
-(void)fastBtnClick:(UIButton *)btn{
    MenuDetailViewController * mvc=[[MenuDetailViewController alloc] init];
    mvc.url=kFastUrl;
    mvc.navigationItem.title=@"凉菜";
    [self.navigationController pushViewController:mvc animated:YES];

}
-(void)vegetableBtnClick:(UIButton *)btn{
    MenuDetailViewController * mvc=[[MenuDetailViewController alloc] init];
    mvc.url=kVegetableUrl;
    mvc.navigationItem.title=@"素菜";
    [self.navigationController pushViewController:mvc animated:YES];

}

-(void)coldBtnClick:(UIButton *)btn{
    MenuDetailViewController * mvc=[[MenuDetailViewController alloc] init];
    mvc.url=kColdUrl;
    mvc.navigationItem.title=@"快手菜";
    [self.navigationController pushViewController:mvc animated:YES];
    
}
-(void)bakingBtnClick:(UIButton *)btn{
    MenuDetailViewController * mvc=[[MenuDetailViewController alloc] init];
    mvc.url=kBakingUrl;
    mvc.navigationItem.title=@"烘焙";
    [self.navigationController pushViewController:mvc animated:YES];
    
}
-(void)noodleBtnClick:(UIButton *)btn{
    MenuDetailViewController * mvc=[[MenuDetailViewController alloc] init];
    mvc.url=kNoodleUrl;
    mvc.navigationItem.title=@"面食";
    [self.navigationController pushViewController:mvc animated:YES];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // NSLog(@"滚动中");
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 减速结束
    
}
@end
