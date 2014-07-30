//
//  CheckList.h
//  CheckLists
//
//  Created by nanwei on 14-7-23.
//  Copyright (c) 2014年 nanwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckList : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)NSMutableArray *items;
-(int)countUncheckedItems;
@property(nonatomic,copy)NSString *iconName;

@end
