//
//  Collect.h
//  CookBook
//
//  Created by qianfeng on 15/7/8.
//  Copyright (c) 2015年 FanShuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Collect : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * imtro;
@property (nonatomic, retain) NSString * burden;
@property (nonatomic, retain) NSString * albums;
@property (nonatomic)NSData * men;
@property (nonatomic,retain)NSNumber * count;
@end
