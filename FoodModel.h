//
//  FoodModel.h
//  CookBook
//
//  Created by qianfeng on 15/7/3.
//  Copyright (c) 2015年 FanShuai. All rights reserved.
//

#import "FsModel.h"

@interface FoodModel : FsModel
@property(nonatomic)NSNumber* id;
@property(nonatomic)NSNumber*page_count;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * sub_title;
@property(nonatomic,copy)NSString * image_url;
@property(nonatomic,copy)NSString * big_image_url;
@end
