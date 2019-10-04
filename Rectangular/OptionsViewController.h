//
//  OptionsViewController.h
//  RectRotate
//
//  Created by Sam Noyes on 3/6/14.
//  Copyright (c) 2014 Samuel Noyes. All rights reserved.
//


//NOT IN USE

#import <UIKit/UIKit.h>
#import "ButtonMakerViewController.h"

@interface OptionsViewController : ButtonMakerViewController <UIAlertViewDelegate, UINavigationControllerDelegate>

+ (NSMutableArray *) rectColorArray;
+ (NSMutableArray *) backgroundColorArray;
+ (NSMutableArray *) colorStringArray;
+ (NSMutableArray *) passageColorArray;
+ (NSMutableArray *) labelColorArray;

@end
