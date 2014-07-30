//
//  ListDetailViewControllerTableViewController.m
//  CheckLists
//
//  Created by nanwei on 14-7-24.
//  Copyright (c) 2014年 nanwei. All rights reserved.
//

#import "ListDetailViewController.h"
#import "CheckList.h"

@interface ListDetailViewController ()

@end

@implementation ListDetailViewController{
    NSString *_iconName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.checkListToEdit != nil){
        self.title = @"修改列表";
        self.textField.text = self.checkListToEdit.name;
        self.doneBarButton.enabled = YES;
        _iconName = self.checkListToEdit.iconName;
    }
    self.iconImagesView.image = [UIImage imageNamed:_iconName];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if((self=[super initWithCoder:aDecoder])){
        _iconName = @"Folder";
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)cancel:(id)sender{
    [self.delegate listDetailViewControllerDidCancel:self];
}
-(IBAction)done:(id)sender{
    [self editDone];
 
}
-(IBAction)keyDone:(id)sender{
    [self editDone];
}
-(void)editDone{
    if(self.checkListToEdit == nil){
        CheckList *checkList = [[CheckList alloc]init];
        checkList.name = self.textField.text;
        checkList.iconName = _iconName;
        [self.delegate listDetailViewController:self didFinishAddingCheckList:checkList];
    }else{
        self.checkListToEdit.name = self.textField.text;
        self.checkListToEdit.iconName = _iconName;
        [self.delegate listDetailViewController:self didFinishEditingCheckList:self.checkListToEdit];
    }
}
//选择前触发
-(NSIndexPath *)tableView:(UITableView*)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return indexPath;
    }else{
        return nil;
    }
}
//编辑输入框，检测（是否可以保存）
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    self.doneBarButton.enabled = ([newText length] > 0);
    return YES;
}
//代理方法
-(void)iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString *)iconName{
    _iconName = iconName;
    self.iconImagesView.image = [UIImage imageNamed:_iconName];
    [self.navigationController popViewControllerAnimated:YES];
}



//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
////#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
////#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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


#pragma mark - Navigation
//
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PickIcon"]) {
        IconPickerViewController *controller = segue.destinationViewController;
        controller.delegate = self;
    }
//     Get the new view controller using [segue destinationViewController].
//     Pass the selected object to the new view controller.
}



@end
