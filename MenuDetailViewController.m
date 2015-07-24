//
//  MenuDetailViewController.m
//  CookBook
//
//  Created by qianfeng on 15/7/4.
//  Copyright (c) 2015年 FanShuai. All rights reserved.
//

#import "MenuDetailViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MenuModel.h"
#import "MenuCell.h"
#import "SVProgressHUD.h"
#import "DetailViewController.h"
@interface MenuDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataArr;
    int _page;
    int _count;
    NSMutableArray * _ar;
    NSData * string;
}
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,strong)NSMutableArray * ar;
@property(nonatomic,strong)NSMutableArray * data;
@property(nonatomic)int page;
@property(nonatomic)int count;
@property (nonatomic)BOOL isRefreshing;
@property (nonatomic)BOOL isLoadMore;
@end

@implementation MenuDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _page=0;
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.dataArr=[[NSMutableArray alloc] init];
    self.data=[[NSMutableArray alloc] init];
    self.view.backgroundColor=[UIColor whiteColor];
    [self creatTableView];
    [self fetchWebData];
    [self creatRefreshView];
    self.tableView.rowHeight=104;
}
-(void)creatTableView{
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 63, self.view.bounds.size.width, self.view.bounds.size.height-63-44) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuCell" bundle:nil] forCellReuseIdentifier:@"MenuCell"];
}
-(void)creatRefreshView{

    
    
    __weak typeof(self) weakSelf=self;
    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isRefreshing) {
            return ;
        }
        weakSelf.isRefreshing=YES;
        weakSelf.page=0;
        [weakSelf fetchWebData];
    }];

    [self.tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isLoadMore) {
            return ;
        }
        weakSelf.isLoadMore=YES;
        weakSelf.page +=15;
        [weakSelf fetchWebData];
    }];
    
}
- (void)endRefreshing {
    if (self.isRefreshing) {
        self.isRefreshing = NO;//标记刷新结束
        //正在刷新 就结束刷新
        [self.tableView headerEndRefreshingWithResult:JHRefreshResultNone];
    }
    if (self.isLoadMore) {
        self.isLoadMore = NO;
        [self.tableView footerEndRefreshing];
    }
}
-(void)fetchWebData{
    [SVProgressHUD showWithStatus:@"下载中..." maskType:SVProgressHUDMaskTypeBlack];
    __weak typeof(self) weakSelf=self;
    
    AFHTTPRequestOperationManager * manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSString * urlstr=[self.url stringByAppendingString:[NSString stringWithFormat:@"%d",self.page]];
    
    [manager GET:urlstr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        string=responseObject;
        if (weakSelf.isRefreshing==YES) {
            [weakSelf.dataArr removeAllObjects];
        }
       NSDictionary * dictionary=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil ];
        NSDictionary * dict=dictionary[@"result"];
        NSArray * arr=dict[@"data"];
        weakSelf.ar=[[NSMutableArray alloc] init];
        for (NSDictionary * dic in arr) {
            MenuModel * model=[[MenuModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            NSArray * array=dic[@"steps"];
            [self.data addObject:array];
            for (NSDictionary * di in array) {
                
                [model setValuesForKeysWithDictionary:di];
                [weakSelf.ar addObject:model];
            }
            model.steps=weakSelf.ar;
            [weakSelf.dataArr addObject:model];
        }
        [weakSelf.tableView reloadData];
        [weakSelf endRefreshing];
        [SVProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
        [weakSelf endRefreshing];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuCell * cell=[tableView dequeueReusableCellWithIdentifier:@"MenuCell" forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    MenuModel * model=self.dataArr[indexPath.row];
    [cell showDataWithModel:model indexPath:indexPath];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController * dvc=[[DetailViewController alloc] init];
    MenuModel * menuModel=self.dataArr[indexPath.row];
    dvc.model=menuModel;
    dvc.men=string;
    dvc.navigationItem.title=menuModel.title;
    dvc.dataArray=self.data[indexPath.row];
    dvc.count=(int)indexPath.row;
    [self.navigationController pushViewController:dvc animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 104;
}
@end
