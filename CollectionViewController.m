//
//  CollectionViewController.m
//  CookBook
//
//  Created by qianfeng on 15/7/7.
//  Copyright (c) 2015年 FanShuai. All rights reserved.
//

#import "CollectionViewController.h"
#import "Collect.h"
#import "CoreData+MagicalRecord.h"
#import "MenuCell.h"
#import "DetailViewController.h"
#import "CollectDetailViewController.h"
@interface CollectionViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    //NSMutableArray * _collArr;
    UITableView * _tableView;
}
//@property(nonatomic,strong)NSMutableArray * collArr;
@property(nonatomic,strong)UITableView * tableView;
@property (nonatomic, retain) NSMutableArray *removeArray;
@property (nonatomic, retain) NSMutableArray *ar;
@property (nonatomic, retain) NSMutableArray *data;
@property(nonatomic)int a;
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableView];
    [self fetchAll];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.data=[[NSMutableArray alloc] init];
    self.tableView.rowHeight=104;
}
-(void)fetchAll{
    self.collArr=[[NSMutableArray alloc] init];
    NSArray * collArr=[Collect MR_findAll];
    [self.collArr removeAllObjects];
    [self.collArr addObjectsFromArray:collArr];
    self.tableView.rowHeight=104;
    [self.tableView reloadData];
}
- (NSMutableArray *)removeArray {
    if (_removeArray == nil) {
        _removeArray = [[NSMutableArray alloc] init];
    }
    return _removeArray;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuModel * model=self.collArr[indexPath.row];
    NSArray *arr = [Collect MR_findByAttribute:@"title" withValue:model.title];
    for (Collect *model in arr) {
        
        [model MR_deleteEntity];
    }
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    [self fetchAll];
    

}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

-(void)creatTableView{
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, self.view.frame.size.height-40) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuCell" bundle:nil] forCellReuseIdentifier:@"MenuCell"];
    self.tableView.rowHeight=104;
}
- (void)hiddenExtraLine {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    view.backgroundColor = [UIColor clearColor];
    UITableView *tableView = (UITableView *)[self.view viewWithTag:100];
    // tableView.tableHeaderView = view;
    tableView.tableFooterView = view;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.collArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuCell * cell=[tableView dequeueReusableCellWithIdentifier:@"MenuCell" forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    MenuModel * model=self.collArr[indexPath.row];
    [cell showDataWithModel:model indexPath:indexPath];
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    MenuModel * model1=self.collArr[indexPath.row];
    NSArray *arr = [Collect MR_findByAttribute:@"title" withValue:model1.title];
    for (Collect *model in arr) {
        self.a=[model.count intValue];
        NSDictionary * dictionary=[NSJSONSerialization JSONObjectWithData:model.men options:NSJSONReadingMutableContainers error:nil ];
        NSDictionary * dict=dictionary[@"result"];
        NSArray * arr=dict[@"data"];
        self.ar=[[NSMutableArray alloc] init];
        for (NSDictionary * dic in arr) {
            MenuModel * model=[[MenuModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            NSArray * array=dic[@"steps"];
            [self.data addObject:array];
            
    }
    
}
    CollectDetailViewController * dvc=[[CollectDetailViewController alloc] init];
    dvc.dataArray=self.data[self.a];
    [self.data removeAllObjects];
    dvc.navigationItem.title=@"详细步骤";
    [self.navigationController pushViewController:dvc animated:YES];
}

@end
