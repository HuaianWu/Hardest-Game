//
//  AppDelegate.m
//  HardestGame
//
//  Created by scsys on 15/10/14.
//  Copyright (c) 2015年 wuhuaian All rights reserved.
//

#import "AppDelegate.h"
#import "SoundTool.h"
#import "StageRecordModel.h"
#import "StageRecordTool.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[SoundTool sharedSoundTool] playBgMusic];
    
    
//    StageRecordModel *m1 = [[StageRecordModel alloc] init];
//    m1.no = 1;
//    m1.score = 22;
////    m1.rank = @"c";
//    m1.unlocked = YES;
//    
//    StageRecordModel *m2 = [[StageRecordModel alloc] init];
//    m2.no = 2;
//    m2.score = 11.6;
//    m2.rank = @"b";
//    m2.unlocked = YES;
//    
//    StageRecordModel *m3 = [[StageRecordModel alloc] init];
//    m3.no = 3;
//    m3.score = 700;
//    m3.rank = @"s";
//    m3.unlocked = YES;
//    
//    StageRecordModel *m4 = [[StageRecordModel alloc] init];
//    m4.no = 4;
//    m4.rank = @"s";
//    m4.unlocked = YES;
//    
//    StageRecordModel *m5 = [[StageRecordModel alloc] init];
//    m5.no = 5;
//    m5.rank = @"s";
//    m5.unlocked = YES;
//    
//    StageRecordModel *m6 = [[StageRecordModel alloc] init];
//    m6.no = 6;
//    m6.unlocked = NO;
//    
//
//    
//    [[StageRecordTool sharedStageRecordTool] saveStageRecord:m1];
//    [[StageRecordTool sharedStageRecordTool] saveStageRecord:m2];
//    [[StageRecordTool sharedStageRecordTool] saveStageRecord:m3];
//    [[StageRecordTool sharedStageRecordTool] saveStageRecord:m4];
//    [[StageRecordTool sharedStageRecordTool] saveStageRecord:m5];
//    [[StageRecordTool sharedStageRecordTool] saveStageRecord:m6];

    
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // 发送通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    //NSNotification *note = [NSNotification notificationWithName:@"applicationWillEnterForeground" object:nil];
    //[center postNotification:note];
    [center postNotificationName:@"applicationWillEnterForeground" object:nil];
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
