//
//  DataModel.h
//  CheckLists
//
//  Created by nanwei on 14-7-24.
//  Copyright (c) 2014年 nanwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject
@property(nonatomic,strong)NSMutableArray *lists;
-(void)saveCheckLists;
-(NSInteger)indexOfSelectedCheckList;
-(void)setIndexOfSelectedCheckList:(NSInteger)index;
-(void)sortCheckLists;
+(NSInteger)nextCheckListItemId;

@end
