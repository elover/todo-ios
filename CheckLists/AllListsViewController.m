//
//  AllListsViewController.m
//  CheckLists
//
//  Created by nanwei on 14-7-23.
//  Copyright (c) 2014年 nanwei. All rights reserved.
//

#import "AllListsViewController.h"
#import "CheckList.h"
#import "ChecklistItem.h"
#import "ViewController.h"
#import "DataModel.h"

@interface AllListsViewController ()

@end

@implementation AllListsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"文件夹的目录是：%@",[self documentsDirectory]);
//    NSLog(@"数据文件的最终路径是：%@",[self dataFilePath]);
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
//-(id)initWithCoder:(NSCoder *)aDecoder{
//    if((self = [super initWithCoder:aDecoder])){
//        _lists = [[NSMutableArray alloc]initWithCapacity:20];
//        CheckList *list = [[CheckList alloc]init];
//        list.name = @"娱乐";
//        [_lists addObject:list];
//        list = [[CheckList alloc]init];
//        list.name = @"工作";
//        [_lists addObject:list];
//        list = [[CheckList alloc]init];
//        list.name = @"学习";
//        [_lists addObject:list];
//        list = [[CheckList alloc]init];
//        list.name = @"家庭";
//        [_lists addObject:list];
//        for (CheckList *list in  _lists) {
//            ChecklistItem *item = [[ChecklistItem alloc]init];
//            item.text = [NSString stringWithFormat:@"Item for: %@",list.name];
//            [list.items addObject:item];
//        }
//    }
//    return self;
//}
#pragma mark - 加载数据
//-(id)initWithCoder:(NSCoder *)aDecoder{
//    if((self = [super initWithCoder:aDecoder])){
//        [self loadCheckListLists];
//    }
////        if((self = [super initWithCoder:aDecoder])){
////            _lists = [[NSMutableArray alloc]initWithCapacity:20];
////            CheckList *list = [[CheckList alloc]init];
////            list.name = @"娱乐";
////            [_lists addObject:list];
////            list = [[CheckList alloc]init];
////            list.name = @"工作";
////            [_lists addObject:list];
////            list = [[CheckList alloc]init];
////            list.name = @"学习";
////            [_lists addObject:list];
////            list = [[CheckList alloc]init];
////            list.name = @"家庭";
////            [_lists addObject:list];
////            for (CheckList *list in  _lists) {
////                ChecklistItem *item = [[ChecklistItem alloc]init];
////                item.text = [NSString stringWithFormat:@"Item for: %@",list.name];
////                [list.items addObject:item];
////            }
////        }
//    return self;
//}
#pragma mark -


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    // Return the number of sections.
//    return 3;
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.dataModel setIndexOfSelectedCheckList:indexPath.row];
    CheckList *checkList = self.dataModel.lists[indexPath.row];
    [self performSegueWithIdentifier:@"ShowCheckList" sender:checkList];
}
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(viewController == self){
        [self.dataModel setIndexOfSelectedCheckList:-1];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
    NSInteger index = [self.dataModel indexOfSelectedCheckList];
    if (index >= 0 && index < [self.dataModel.lists count]) {
        CheckList *checkList = self.dataModel.lists[index];
        [self performSegueWithIdentifier:@"ShowCheckList" sender:checkList];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"ShowCheckList"]){
        ViewController *controller = segue.destinationViewController;
        controller.checkList = sender;
    }else if([segue.identifier isEqualToString:@"AddCheckList"]){
        UINavigationController *navigationController = segue.destinationViewController;
        ListDetailViewController *controller = (ListDetailViewController*)navigationController.topViewController;
        controller.delegate = self;
        controller.checkListToEdit = nil;
    }
}

-(void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];

}
-(void)listDetailViewController:(ListDetailViewController*)controller didFinishAddingCheckList:(CheckList *)checkList{
//    NSInteger newRowIndex = [self.dataModel.lists count];
    [self.dataModel.lists addObject:checkList];
    [self.dataModel sortCheckLists];
    [self.tableView reloadData];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
//    NSArray *indexPaths = @[indexPath];
//    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
//    [self saveCheckListLists];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)listDetailViewController:(ListDetailViewController *)controller didFinishEditingCheckList:(CheckList *)checkList{
    
    [self.dataModel sortCheckLists];
    [self.tableView reloadData];
    
//    NSInteger index = [self.dataModel.lists indexOfObject:checkList];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
//    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//    cell.textLabel.text = checkList.name;
//    [self saveCheckListLists];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.dataModel.lists removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths = @[indexPath];
//    [self saveCheckListLists];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListNavigationController"];
    ListDetailViewController *controller = (ListDetailViewController *)navigationController.topViewController;
    controller.delegate = self;
    CheckList *checkList = self.dataModel.lists[indexPath.row];
    controller.checkListToEdit = checkList;
    [self presentViewController:navigationController animated:YES completion:nil];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.dataModel.lists count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Celldentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Celldentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Celldentifier];
    }
    CheckList *checkList = self.dataModel.lists[indexPath.row];
    cell.textLabel.text = checkList.name;
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    if([checkList.items count] == 0){
        cell.detailTextLabel.text = @"没有事情";
    }else if ([checkList countUncheckedItems] == 0) {
        cell.detailTextLabel.text = @"全部收工!";
    }else{
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d 待办",[checkList countUncheckedItems]];
    }
    cell.imageView.image = [UIImage imageNamed:checkList.iconName];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
