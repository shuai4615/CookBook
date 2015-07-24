//
//  MyViewController.m
//  CookBook
//
//  Created by qianfeng on 15/7/3.
//  Copyright (c) 2015年 FanShuai. All rights reserved.
//

#import "MyViewController.h"
#import "UMSocial.h"
#import "SDImageCache.h"
#import "AboutViewController.h"
#import "CollectionViewController.h"
@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate,UIActionSheetDelegate>
{
    NSMutableArray * _dataArr;
    NSMutableArray * _imgArry;
}
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self creatTableView];
}
-(void)creatTableView{
    _dataArr=[[NSMutableArray alloc] initWithObjects:@[@"推荐给好友",@"我的收藏"],@[@"清除缓存",@"关于我们"], nil];
    _imgArry = [[NSMutableArray alloc]initWithObjects:@[@"share1.png",@"note.png"],@[@"trash1.png",@"about.png"], nil];
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.bounds.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _dataArr[indexPath.section][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:_imgArry[indexPath.section][indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    switch (indexPath.section) {
        case 0:
            [self section0Action:row];
            break;
        case 1:
            [self section1Action:row];
            break;
        default:
            break;
    }
}
-(void)section0Action:(NSInteger)row{
    switch (row) {
        case 0:
            [UMSocialSnsService presentSnsController:self appKey:@"507fcab25270157b37000010" shareText:@"" shareImage:[UIImage imageNamed:@"欢迎使用本App,祝您愉快"] shareToSnsNames:@[UMShareToWechatTimeline,  UMShareToSina, UMShareToTencent, UMShareToRenren] delegate:self];
            break;
          case 1:
        {
            CollectionViewController * cvc=[[CollectionViewController alloc] init];
            cvc.navigationItem.title=@"我的收藏";
            [self.navigationController pushViewController:cvc animated:YES];
        
        }
            break;
        default:
            break;
    }

}
-(void)section1Action:(NSInteger)row{
    switch (row) {
            
        case 0:{
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"确定清除缓存%.2fM", [self getCacheSize]] delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [sheet showInView:self.view];
        }
            break;
        case 1:{
            AboutViewController * avc=[[AboutViewController alloc] init];
            [self.navigationController pushViewController:avc animated:YES];
        }
            break;
        default:
            break;
    }
}
-(double)getCacheSize{
    double sdSize=[[SDImageCache sharedImageCache] getSize];
    NSString * myCachePath=[NSHomeDirectory() stringByAppendingFormat:@"/Library/Caches/MyCaches"];
    NSDirectoryEnumerator * enumerator=[[NSFileManager defaultManager] enumeratorAtPath:myCachePath];
    double mySize=0;
    for (NSString * fileName in enumerator) {
        NSString * filePath=[myCachePath stringByAppendingPathComponent:fileName];
        NSDictionary * dict=[[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        mySize +=dict.fileSize;
    }
    double totalSize=(mySize +sdSize)/1024/1024;
    return totalSize;
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==actionSheet.destructiveButtonIndex) {
        [[SDImageCache sharedImageCache] clearDisk];
        [[SDImageCache sharedImageCache] clearDisk];
        NSString * myCachePath=[NSHomeDirectory() stringByAppendingFormat:@"/Library/Caches/MyCaches"];
        [[NSFileManager defaultManager] removeItemAtPath:myCachePath error:nil];
    }

}
@end
