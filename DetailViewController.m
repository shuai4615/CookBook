//
//  DetailViewController.m
//  CookBook
//
//  Created by qianfeng on 15/7/5.
//  Copyright (c) 2015年 FanShuai. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailCell.h"
#import "StepsModel.h"
#import "PresentViewController.h"
#import "UMSocial.h"
#import "Collect.h"
#import "CoreData+MagicalRecord.h"
#import "CollectionViewController.h"
@interface DetailViewController ()<UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _Array;
    NSMutableArray * _sendArr;
    BOOL _isExist;
}
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * Array;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.headerView.collectionButton setImage:[UIImage imageNamed:@"home_fav_normal"] forState:UIControlStateNormal];
    //[self.headerView.collectionButton setImage:[UIImage imageNamed:@"home_fav_select"] forState:UIControlStateSelected];
//    if (_isExist) {
//        self.headerView.collectionButton.enabled=NO;
//    }else{
//    self.headerView.collectionButton.enabled=YES;
//    }
    
    self.Array=[[NSMutableArray alloc] init];
    [self fetData];
    [self creatTableView];
    [self addHeaderView];
    
}
-(void)creatTableView{ 
    self.tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.rowHeight=121;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailCell" bundle:nil] forCellReuseIdentifier:@"DetailCell"];
}
-(void)addHeaderView{
    UINib *nib = [UINib nibWithNibName:@"HeaderView" bundle:nil];
    NSArray *viewArray = [nib instantiateWithOwner:nil options:nil];
    self.headerView = [viewArray lastObject];
    [self.headerView showHeaderViewWithModel:self.model];
    self.tableView.tableHeaderView=self.headerView;
    [self.headerView.collectionButton  addTarget:self action:@selector(collectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView.shareButton addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _isExist=[self isExistAppForTitle:self.model.title];
    [self.headerView.collectionButton setTitle:@"已收藏" forState:UIControlStateDisabled];
    [self.headerView.collectionButton setTitle:@"收藏" forState:UIControlStateNormal];
    if (_isExist) {
        self.headerView.collectionButton.enabled=NO;
    }else{
        self.headerView.collectionButton.enabled=YES;
    }
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
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
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
-(void)collectBtnClick:(UIButton *)button{
    button.enabled = NO;
    Collect * model1=[Collect MR_createEntity];
    model1.title=self.model.title;
    model1.imtro=self.model.imtro;
    model1.burden=self.model.burden;
    model1.albums=self.model.albums;
    model1.count=[NSNumber numberWithInt:self.count];
    model1.men=self.men;
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
}
- (BOOL)isExistAppForTitle:(NSString *)title{
    NSArray * arr=nil;
  arr = [Collect MR_findByAttribute:@"title" withValue:title];
    if (arr.count==0) {
        
        return NO;
    }
    return YES;
}
-(void)shareBtnClick{
   [UMSocialSnsService presentSnsController:self appKey:@"507fcab25270157b37000010" shareText:@"欢迎使用本App,祝您愉快" shareImage:[UIImage imageNamed:@""] shareToSnsNames:@[UMShareToWechatTimeline,  UMShareToSina, UMShareToTencent, UMShareToRenren] delegate:self];
    
    
    
}
@end
