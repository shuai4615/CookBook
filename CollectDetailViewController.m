//
//  CollectDetailViewController.m
//  CookBook
//
//  Created by qianfeng on 15/7/10.
//  Copyright (c) 2015年 FanShuai. All rights reserved.
//

#import "CollectDetailViewController.h"
#import "DetailCell.h"
#import "StepsModel.h"
#import "PresentViewController.h"
@interface CollectDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _Array;
    NSMutableArray * _sendArr;
    
}
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * Array;


@end

@implementation CollectDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Array=[[NSMutableArray alloc] init];
    [self creatTableView];
    [self fetData];
}
-(void)creatTableView{
    self.tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.rowHeight=121;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailCell" bundle:nil] forCellReuseIdentifier:@"DetailCell"];
}
-(void)fetData{
    for (NSDictionary * dic in self.dataArray) {
        StepsModel * model=[[StepsModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [self.Array addObject:model];
    }
    [self.tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.Array.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailCell * cell=[tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
    StepsModel * model=self.Array[indexPath.row];
    [cell showDataWithModel:model indexPath:indexPath];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PresentViewController * pvc=[[PresentViewController alloc] init];
    StepsModel * model=self.Array[indexPath.row];
    pvc.navigationItem.title=@"制作步骤";
    pvc.pic=model.img;
    pvc.note=model.step;
    pvc.idx=indexPath.row;
    pvc.stepcount=self.Array.count;
    pvc.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [self.navigationController presentModalViewController:pvc animated:YES];
    
}

@end
