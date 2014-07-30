//
//  ChecklistItem.h
//  Checklists
//
//  Created by happybubsy on 12/5/13.
//  Copyright (c) 2013 happybubsy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChecklistItem : NSObject<NSCoding>

@property(nonatomic,copy)NSString *text;
@property(nonatomic,assign)BOOL checked;

@property(nonatomic,copy)NSDate *dueDate;
@property(nonatomic,assign)BOOL shouldRemind;
@property(nonatomic,assign)NSInteger itemId;

-(void)toggleChecked;
-(void)scheduleNotification;

@end
