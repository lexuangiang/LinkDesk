//
//  AppDelegate.m
//  Link Desk
//
//  Created by GiangLe on 3/6/18.
//  Copyright © 2018 GiangLe. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (){
    int ticker ;
    NSTimer *timer;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self timer];
    
    
    return YES;
}
-(void)timer{
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countTime) userInfo:nil repeats:YES];
}
-(void)countTime{
    // Get date
    NSDate *curDate = [NSDate date];
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSRange daysRange =
    [currentCalendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:curDate];
    NSDateComponents* components = [currentCalendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:curDate];
    NSInteger day = [components day];
    if (day == daysRange.length){
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setDateFormat:@"HH:mm:ss"];
        NSString *newDateString = [outputFormatter stringFromDate:curDate];
        if ([newDateString isEqualToString:@"23:59:59"]){
            NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
//            [userDefaults removeObjectForKey:@"seat-1"];
//            [userDefaults removeObjectForKey:@"seat-2"];
//            [userDefaults removeObjectForKey:@"seat-3"];
//            [userDefaults removeObjectForKey:@"seat-4"];
//            [userDefaults removeObjectForKey:@"seat-5"];
            NSLog(@"newDateString %@", newDateString);
            NSDictionary * dict = [[NSUserDefaults standardUserDefaults] valueForKey:@"arrayDataDesk"];
            for (id key in dict){
                NSLog(@"key: %@", key);
                [userDefaults removeObjectForKey:key];
            }
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
