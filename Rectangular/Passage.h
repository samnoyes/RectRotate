//
//  Passage.h
//  RectRotate
//
//  Created by Sam Noyes on 7/8/14.
//  Copyright (c) 2014 Samuel Noyes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Passage : UIView

@property (nonatomic) float rectSize;
@property (strong, nonatomic) UIView *selfView;
@property (nonatomic) int space;
@property (strong, nonatomic) NSMutableArray *subviewArray;
@property (nonatomic) float buffer;
@property (nonatomic) int numOfSubViews;
@property (nonatomic) CGFloat subviewSize;
@property (nonatomic) BOOL beaten;

- (int) reverseDifficulty : (int) difficulty;
- (int) generatePosOrNeg;
- (double) getBufferWithView:(UIView *)selfView;
- (double) getMaxTiltWithView:(UIView *) selfView andDifficulty: (int) difficulty;
- (double) generateTiltWithView: (UIView *)selfView andDifficulty: (int) difficulty max:(int) max min: (int) min;
- (double) generateMultiplierWithDifficulty: (int) difficulty;
- (void) addSubviewsWithSpace:(CGFloat) space spaceXValue:(CGFloat) spaceX height: (CGFloat) height YCoord: (CGFloat) y andViewWidth:(CGFloat)viewWidth;
- (void) becomeBeaten;
- (BOOL) isBeaten;

@end
