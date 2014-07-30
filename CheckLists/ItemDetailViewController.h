//
//  ItemDetailViewContyroller.h
//  CheckLists
//
//  Created by nanwei on 14-7-21.
//  Copyright (c) 2014年 nanwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemDetailViewController;
@class ChecklistItem;

@protocol ItemDetailViewControllerDelegate <NSObject>
//取消是触发的代理方法
-(void)itemDetailViewController:(ItemDetailViewController*)controller;
//添加成功时触发的代理方法
-(void)itemDetailViewController:(ItemDetailViewController *)controller
              didFinishAddingItem:(ChecklistItem*)item;
//修改成功是触发的代理方法
-(void)itemDetailViewController:(ItemDetailViewController*)controller didFinishEditingItem:(ChecklistItem*)item;

@end

@interface ItemDetailViewController : UITableViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (nonatomic,weak)id<ItemDetailViewControllerDelegate> delegate;
@property(nonatomic,strong) ChecklistItem *itemToEdit;
@property(nonatomic,weak)IBOutlet UISwitch *switchControl;
@property(nonatomic,weak)IBOutlet UILabel *dueDateLabel;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end