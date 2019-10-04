//
//  MenuViewController.h
//  RectRotate
//
//  Created by Sam Noyes on 3/6/14.
//  Copyright (c) 2014 Samuel Noyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonMakerViewController.h"

@interface MenuViewController : ButtonMakerViewController
+ (NSString *) getSoundKey;
@property (nonatomic) BOOL doTutorial;

@end
