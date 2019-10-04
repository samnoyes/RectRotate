//
//  Settings.h
//  RectRotate
//
//  Created by Sam Noyes on 7/13/14.
//  Copyright (c) 2014 Samuel Noyes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject
@property (strong, nonatomic) UIColor *rectColor;
@property (strong, nonatomic) UIColor *backgroundColor;
@property (strong, nonatomic) UIColor *passageColor;
@property (strong, nonatomic) UIColor *labelColor;
@property (strong, nonatomic) NSString *schemeString;
+(Settings *) getSavedSettings;
- (void) saveCurrentSettings;
@end
