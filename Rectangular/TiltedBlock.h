//
//  TiltedBlock.h
//  Rectangular
//
//  Created by Samuel Noyes on 2/18/14.
//  Copyright (c) 2014 Samuel Noyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "Passage.h"

@interface TiltedBlock : Passage

//*****************************************************************

@property (nonatomic) double tilt;
@property (nonatomic) int rand;
@property (nonatomic) double startTopGapX;
@property (nonatomic) int endTopGapX;
@property (nonatomic) double startBottomGapX;
@property (nonatomic) int endBottomGapX;

//*****************************************************************

- (id) init;
- (id) initRandomTiltedBlockWithSpace:(int)SPACE andNumOfViews:(int)top inView:(UIView *) selfView difficulty:(int) difficulty rectSize:(float)rectSize;

- (CGFloat) generateStartWithRand: (int) rand view:(UIView *) selfView difficulty: (int) difficulty;
- (void) generateSubviewsInView:(UIView *) selfView rectSize: (float) rectSize;

//*****************************************************************

@end
