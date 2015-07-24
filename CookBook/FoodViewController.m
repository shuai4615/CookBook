//
//  FoodViewController.m
//  CookBook
//
//  Created by qianfeng on 15/7/3.
//  Copyright (c) 2015年 FanShuai. All rights reserved.
//

#import "FoodViewController.h"
#import "FoodCell.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#define kFoodUrl @"http://food.boohee.com/fb/v1/topics"
@interface FoodViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataArr;
}
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArr;
@end

@implementation FoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableView];
    self.dataArr=[[NSMutableArray alloc] init];
    [self fetchWebData];
}
-(void)creatTableView{
    self.tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"FoodCell" bundle:nil] forCellReuseIdentifier:@"FoodCell"];
    self.tableView.rowHeight=114;
    
    
    
    
}
-(void)fetchWebData{
    [SVProgressHUD showWithStatus:@"下载中..." maskType:SVProgressHUDMaskTypeBlack];
    AFHTTPRequestOperationManager* manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:kFoodUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray * arr=dict[@"topics"];
        for (NSDictionary * dic in arr) {
            FoodModel * model=[[FoodModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:model];
        }
        [SVProgressHUD dismiss];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",error.localizedDescription);
    }];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FoodCell * cell=[tableView dequeueReusableCellWithIdentifier:@"FoodCell" forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    FoodModel * model=self.dataArr[indexPath.row];
    [cell showDataWithModel:model indexPath:indexPath];
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FoodDetailViewController *fvc=[[FoodDetailViewController alloc] init];
    FoodModel * model=self.dataArr[indexPath.row];
    fvc.navigationItem.title=model.title;
    fvc.num=model.id;
    fvc.page=model.page_count;
    [self.navigationController pushViewController:fvc animated:YES];
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [UIView animateWithDuration:1 animations:^{
//        self.navigationController.navigationBar.alpha=0.0;
//        self.tabBarController.tabBar.alpha=0.1;
//    }];
//
//
//}
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    [UIView animateWithDuration:0.5 animations:^{
//        self.navigationController.navigationBar.alpha=1.0;
//        self.tabBarController.tabBar.alpha=1.0;
//    }];
//
//}
@end
