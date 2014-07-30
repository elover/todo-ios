//
//  ListDetailViewControllerTableViewController.h
//  CheckLists
//
//  Created by nanwei on 14-7-24.
//  Copyright (c) 2014年 nanwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconPickerViewController.h"

@class CheckList;
@class ListDetailViewController;

@protocol ListDetailViewControllerDelegate <NSObject>
//取消
-(void)listDetailViewControllerDidCancel:(ListDetailViewController*)controller;
//添加成功
-(void)listDetailViewController:(ListDetailViewController*)controller didFinishAddingCheckList:(CheckList*)checkList;
// 修改成功
-(void)listDetailViewController:(ListDetailViewController*)controller didFinishEditingCheckList:(CheckList*)checkList;

@end


@interface ListDetailViewController : UITableViewController<UITextFieldDelegate,IconPickerViewControllerDelegate>
@property(nonatomic,weak)IBOutlet UITextField *textField;
@property(nonatomic,weak)IBOutlet UIBarButtonItem *doneBarButton;
@property(nonatomic,weak)id <ListDetailViewControllerDelegate> delegate;
@property(nonatomic,strong)CheckList *checkListToEdit;

-(IBAction)cancel:(id)sender;
-(IBAction)done:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *iconImagesView;

@end
