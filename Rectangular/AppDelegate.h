//
//  AppDelegate.h
//  Rectangular
//
//  Created by Samuel Noyes on 2/12/14.
//  Copyright (c) 2014 Samuel Noyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RevMobAds/RevMobAds.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, RevMobAdsDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) BOOL paused;
@property (nonatomic) BOOL adSessionStarted;
@end
