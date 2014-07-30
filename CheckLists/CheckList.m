//
//  CheckList.m
//  CheckLists
//
//  Created by nanwei on 14-7-23.
//  Copyright (c) 2014年 nanwei. All rights reserved.
//

#import "CheckList.h"
#import "ChecklistItem.h"

@implementation CheckList

-(id)init{
    if((self = [super init])){
        self.items = [[NSMutableArray alloc]initWithCapacity:20];
        self.iconName = @"No Icon";
        
    }
    return self;
}
//初始化数据并编码
-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if((self =[super init])){
        self.name = [aDecoder decodeObjectForKey:@"Name"];
        self.items = [aDecoder decodeObjectForKey:@"Items"];
        self.iconName = [aDecoder decodeObjectForKey:@"IconName"];
    }
    return self;
    
}
//解码
-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    
    [aCoder encodeObject:self.name forKey:@"Name"];
    
    [aCoder encodeObject:self.items forKey:@"Items"];
    [aCoder encodeObject:self.iconName forKey:@"IconName"];
}

// 排序
-(NSComparisonResult)compare:(CheckList*)otherCheckList{
    return [self.name localizedStandardCompare:otherCheckList.name];
}

// 计算未选中的事项
-(int)countUncheckedItems{
    int count = 0;
    for(ChecklistItem *item in self.items){
        if(!item.checked){
            count += 1;
        }
    }
    return count;
}

@end
