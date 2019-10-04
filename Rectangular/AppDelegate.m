//
//  AppDelegate.m
//  Rectangular
//
//  Created by Samuel Noyes on 2/12/14.
//  Copyright (c) 2014 Samuel Noyes. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Appirater.h"
#import "AudioPlayer.h"
#import <RevMobAds/RevMobAds.h>
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    //Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    //NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    //if (networkStatus == NotReachable) {
        //NSLog(@"There IS NO internet connection");
    //} else {
        //NSLog(@"There IS internet connection");
        [RevMobAds startSessionWithAppID:@"5398cd8a6417062307c101de" andDelegate:self];
    //}
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    self.paused = YES;
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    self.paused = NO;
    [Appirater appEnteredForeground:YES];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)revmobSessionIsStarted {
    NSLog(@"Started!");
    self.adSessionStarted = YES;
}

-(void)revmobSessionNotStartedWithError:(NSError *)error {
    NSLog(@"[RevMob Sample App] Session failed to start: %@", error);
    self.adSessionStarted = NO;
}

- (void) revmobAdDidFailWithError:(NSError *)error {
    
}

@end
