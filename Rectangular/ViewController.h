//
//  ViewController.h
//  Rectangular
//
//  Created by Samuel Noyes on 2/12/14.
//  Copyright (c) 2014 Samuel Noyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiltedBlock.h"
#import <QuartzCore/QuartzCore.h>
#import "ButtonMakerViewController.h"
#import <RevMobAds/RevMobAds.h>

@interface ViewController : ButtonMakerViewController <UIAccelerometerDelegate, UIAlertViewDelegate, RevMobAdsDelegate>

+(int)generateRandomNumberBetweenMin:(int)min Max:(int)max;
+ (NSString *) highscoreKey;
+ (int) getTiltedBlockNumOfSubviews;
- (void) loadFullVersion;
@end
