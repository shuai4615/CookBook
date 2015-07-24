//
//  SearchViewController.m
//  CookBook
//
//  Created by qianfeng on 15/7/7.
//  Copyright (c) 2015年 FanShuai. All rights reserved.
//

#import "SearchViewController.h"
#import "MenuCell.h"
#import "MenuModel.h"
#import "DetailViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "JHRefresh.h"
@interface SearchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataArr;
    NSString * _urlStr;
    int _page;
    NSMutableArray * _ar;
    NSString * _str;
}

@property(nonatomic,strong)NSMutableArray * ar;
@property(nonatomic,strong)NSMutableArray * data;
@property (nonatomic)BOOL isRefreshing;
@property (nonatomic)BOOL isLoadMore;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic)int page;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _page=0;
    [self initUI];
    //self.automaticallyAdjustsScrollViewInsets=NO;
    [self creatRefreshView];
}
-(void)initUI{
    self.dataArr = [[NSMutableArray alloc] init];
    self.data=[[NSMutableArray alloc] init];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight=104;
    
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuCell" bundle:nil] forCellReuseIdentifier:@"MenuCell"];
    UISearchBar * search=[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    search.delegate=self;
    search.placeholder=@"大量美味等你搜索";
    self.tableView.tableHeaderView=search;
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    //显示 cancel 按钮
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

//将要结束编辑模式调用
//是否可以结束编辑模式
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    //隐藏cancel 按钮
    [searchBar setShowsCancelButton:NO animated:YES];
    return YES;//可以结束编辑模式
}
//点击cancel 的时候调用
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";//清空内容
    //收键盘
    [searchBar resignFirstResponder];
}
//点击search 按钮 调用
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    _urlStr=[NSString stringWithFormat:@"http://caipu.yjghost.com/index.php/query/read?menu=%@&rn=15&start=",searchBar.text];
    _urlStr = [_urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    _str=_urlStr;
    [searchBar resignFirstResponder];
    [self fetchWebData];
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
    //    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleNone];
    //    //设置特效标题
    //    [MMProgressHUD showWithTitle:@"正在拼命加载" status:@"Loading..."];
    [SVProgressHUD showWithStatus:@"下载中..." maskType:SVProgressHUDMaskTypeBlack];
    __weak typeof(self) weakSelf=self;
    
    AFHTTPRequestOperationManager * manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    _urlStr=[_urlStr stringByAppendingString:[NSString stringWithFormat:@"%d",self.page]];
    
    [manager GET:_urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (weakSelf.isRefreshing==YES) {
            [weakSelf.dataArr removeAllObjects];
        }
        //        [self.tableView stopHeaderViewLoading];
        //        [self.tableView stopFooterViewLoading];
        
        NSDictionary * dictionary=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil ];
        NSDictionary * dict=dictionary[@"result"];
        NSArray * arr=dict[@"data"];
        
        //weakSelf.count=(int)arr.count;
        weakSelf.ar=[[NSMutableArray alloc] init];
        for (NSDictionary * dic in arr) {
            MenuModel * model=[[MenuModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            NSArray * array=dic[@"steps"];
            [self.data addObject:array];
            //self.count=(int)array.count;
            for (NSDictionary * di in array) {
                
                [model setValuesForKeysWithDictionary:di];
                [weakSelf.ar addObject:model];
            }
            model.steps=weakSelf.ar;
            [weakSelf.dataArr addObject:model];
            
        }
        //[MMProgressHUD dismissWithSuccess:@"成功" title:@"数据加载"];
        [weakSelf.tableView reloadData];
        [weakSelf endRefreshing];
        [SVProgressHUD dismiss];
        _urlStr=_str;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //[MMProgressHUD dismissWithError:@"失败" title:@"网络故障"];
        //        [self.tableView stopHeaderViewLoading];
        //        [self.tableView stopFooterViewLoading];
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
    dvc.navigationItem.title=menuModel.title;
    //dvc.count=self.count;
    dvc.dataArray=self.data[indexPath.row];
    [self.navigationController pushViewController:dvc animated:YES];
}
@end
