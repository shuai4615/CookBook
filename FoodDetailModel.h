//
//  FoodDetailModel.h
//  CookBook
//
//  Created by qianfeng on 15/7/4.
//  Copyright (c) 2015年 FanShuai. All rights reserved.
//

#import "FsModel.h"

@interface FoodDetailModel : FsModel
@property(nonatomic,copy)NSString * food_name;
@property(nonatomic,copy)NSString * description;
@property(nonatomic,copy)NSString * food_code;
@property(nonatomic)NSNumber *food_id;
@property(nonatomic,copy)NSString * image_url;
@property(nonatomic,copy)NSString * page_url;
@end
