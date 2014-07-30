//
//  ViewController.h
//  CheckLists
//
//  Created by nanwei on 14-7-21.
//  Copyright (c) 2014年 nanwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailViewController.h"
@class CheckList;

@interface ViewController : UITableViewController<ItemDetailViewControllerDelegate>
@property(nonatomic,strong)CheckList *checkList;

@end

