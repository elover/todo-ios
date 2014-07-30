//
//  IconPickerViewControllerTableViewController.h
//  CheckLists
//
//  Created by nanwei on 14-7-24.
//  Copyright (c) 2014年 nanwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IconPickerViewController;
@protocol IconPickerViewControllerDelegate <NSObject>

-(void)iconPicker:(IconPickerViewController*)picker didPickIcon:(NSString*)iconName;

@end



@interface IconPickerViewController : UITableViewController
@property(nonatomic,weak)id<IconPickerViewControllerDelegate> delegate;

@end
