//
//  DataModel.m
//  CheckLists
//
//  Created by nanwei on 14-7-24.
//  Copyright (c) 2014年 nanwei. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

-(id)init{
    if ((self = [super init])) {
        [self loadCheckListLists];
        [self registerDefaults];
    }
    return self;
}
+(NSInteger)nextCheckListItemId{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger itemId = [userDefaults integerForKey:@"CheckListItemId"];
    [userDefaults setInteger:itemId + 1 forKey:@"CheckListItemId"];
    [userDefaults synchronize];
    return itemId;
}

-(void)sortCheckLists{
    [self.lists sortUsingSelector:@selector(compare:)];
}

-(void)registerDefaults{
    NSDictionary *dictionary = @{@"CheckListIndex":@-1,@"FirstTime":@YES,@"CheckListItemId":@0};
    [[NSUserDefaults standardUserDefaults]registerDefaults:dictionary];
}
-(NSInteger)indexOfSelectedCheckList{
    return [[NSUserDefaults standardUserDefaults]integerForKey:@"CheckListIndex"];
}
-(void)setIndexOfSelectedCheckList:(NSInteger)index{
    [[NSUserDefaults standardUserDefaults]setInteger:index forKey:@"CheckListIndex"];
}

-(NSString*)documentsDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    return documentsDirectory;
}
-(NSString*)dataFilePath{
    return [[self documentsDirectory]stringByAppendingPathComponent:@"CheckLists.plist"];
}
-(void)saveCheckLists{
    NSMutableData *data = [[NSMutableData alloc]init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:self.lists forKey:@"CheckLists"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}
-(void)loadCheckListLists{
    NSString *path = [self dataFilePath];
    if([[NSFileManager defaultManager]fileExistsAtPath:path]){
        NSData *data = [[NSData alloc]initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        self.lists = [unarchiver decodeObjectForKey:@"CheckLists"];
        [unarchiver finishDecoding];
    }else{
        self.lists = [[NSMutableArray alloc]initWithCapacity:20];
    }
}

@end
