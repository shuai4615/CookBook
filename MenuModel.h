//
//  MenuModel.h
//  CookBook
//
//  Created by qianfeng on 15/7/4.
//  Copyright (c) 2015年 FanShuai. All rights reserved.
//

#import "FsModel.h"

@interface MenuModel : FsModel

@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString *  caipu_id;
@property(nonatomic,copy)NSString *  title;
@property(nonatomic,copy)NSString *  tags;
@property(nonatomic,copy)NSString *  imtro;
@property(nonatomic,copy)NSString *  ingredients;
@property(nonatomic,copy)NSString *  burden;
@property(nonatomic,copy)NSString *  albums;
@property(nonatomic,copy)NSString *  passed;
@property(nonatomic,copy)NSString *  user_upload;
@property(nonatomic,strong)NSArray * steps;
@property(nonatomic,copy)NSString * step;
@property(nonatomic,copy)NSString * img;
@end
