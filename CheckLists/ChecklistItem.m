//
//  ChecklistItem.m
//  Checklists
//
//  Created by happybubsy on 12/5/13.
//  Copyright (c) 2013 happybubsy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChecklistItem.h"
#import "DataModel.h"

@implementation ChecklistItem

-(id)init{
    if((self = [super init])){
        self.itemId = [DataModel nextCheckListItemId];
    }
    return self;
}
// 初始化并编码
-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.text = [aDecoder decodeObjectForKey:@"Text"];
        self.checked = [aDecoder decodeBoolForKey:@"Checked"];
        self.dueDate = [aDecoder decodeObjectForKey:@"DueDate"];
        self.shouldRemind = [aDecoder decodeBoolForKey:@"ShouldRemind"];
        self.itemId = [aDecoder decodeIntegerForKey:@"ItemId"];
    }
    return self;
}
// 编码
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.text forKey:@"Text"];
    [aCoder encodeBool:self.checked forKey:@"Checked"];
    [aCoder encodeObject:self.dueDate forKey:@"DueDate"];
    [aCoder encodeBool: self.shouldRemind forKey:@"ShouldRemind"];
    [aCoder encodeInteger:self.itemId forKey:@"ItemId"];
}


-(void)toggleChecked{
    
    self.checked = !self.checked;
}
-(void)scheduleNotification{
    
    UILocalNotification *existingNotification = [self notificationForThisItem];
    
    if (existingNotification != nil) {
        NSLog(@"Found an exisint notification %@",existingNotification);
        [[UIApplication sharedApplication]cancelLocalNotification:existingNotification];
    }
    
    
    if (self.shouldRemind && [self.dueDate compare:[NSDate date]] != NSOrderedAscending) {
        UILocalNotification *localNotification = [[UILocalNotification alloc]init];
        localNotification.fireDate = self.dueDate;
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.alertBody = self.text;
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        localNotification.userInfo = @{@"ItemId":@(self.itemId)};
        [[UIApplication sharedApplication]scheduleLocalNotification:localNotification];
        NSLog(@"Scheduled natification %@ for itemId %ld",localNotification,(long)self.itemId);
        
    }
    
}
-(UILocalNotification*)notificationForThisItem{
    NSArray *allNotifications = [[UIApplication sharedApplication]scheduledLocalNotifications];
    
    for(UILocalNotification *notification in allNotifications){
        NSNumber *number = [notification.userInfo objectForKey:@"ItemId"];
        if(number != nil &&[number integerValue] == self.itemId){
            return notification;
        }
    }
    return nil;
}
//删除时调用
-(void)dealloc{
    UILocalNotification *existingNotification = [self notificationForThisItem];
    if(existingNotification !=nil){
        NSLog(@"Removing exisint notification %@",existingNotification);
        [[UIApplication sharedApplication]cancelLocalNotification:existingNotification];
    }
}

@end
