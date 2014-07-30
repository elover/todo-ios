//
//  AllListsViewController.h
//  CheckLists
//
//  Created by nanwei on 14-7-23.
//  Copyright (c) 2014年 nanwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListDetailViewController.h"
@class DataModel;

@interface AllListsViewController : UITableViewController<ListDetailViewControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)DataModel *dataModel;
@end
