//
//  AppDelegate.m
//  CheckLists
//
//  Created by nanwei on 14-7-21.
//  Copyright (c) 2014年 nanwei. All rights reserved.
//

#import "AppDelegate.h"
#import "AllListsViewController.h"
#import "DataModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate{
    DataModel *_dataModel;
}
            
// 程序启动是调用
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"%s,%d",__FUNCTION__,__LINE__);
    
//    [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    // Override point for customization after application launch.
    _dataModel = [[DataModel alloc]init];
    UINavigationController *navigationController = (UINavigationController*)self.window.rootViewController;
    AllListsViewController *controller = navigationController.viewControllers[0];
    controller.dataModel = _dataModel;
    
    //local notification
//    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:10];
//    UILocalNotification *localNotification = [[UILocalNotification alloc]init];
//    localNotification.fireDate = date;
//    localNotification.timeZone = [NSTimeZone defaultTimeZone];
//    localNotification.alertBody = @"2014年到了，马上有钱!";
////    localNotification.soundName = UILocalNotificationDefaultSoundName;
//    [[UIApplication sharedApplication]scheduleLocalNotification:localNotification];
    return YES;
}
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSLog(@"%s,%d",__FUNCTION__,__LINE__);
    NSLog(@"didReceivedLocalNotification %@",notification);
}

//应用程序取消活动状态
- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"%s,%d",__FUNCTION__,__LINE__);
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
//程序进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"%s,%d",__FUNCTION__,__LINE__);
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self saveData];
//    [controller];
}
-(void)saveData{
    [_dataModel saveCheckLists];
}
// 程序将要进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"%s,%d",__FUNCTION__,__LINE__);
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}
//应用程序变成活动状态
- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"%s,%d",__FUNCTION__,__LINE__);
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
//程序退出
- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"%s,%d",__FUNCTION__,__LINE__);
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self saveData];
}

@end
