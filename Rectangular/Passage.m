//
//  Passage.m
//  RectRotate
//
//  Created by Sam Noyes on 7/8/14.
//  Copyright (c) 2014 Samuel Noyes. All rights reserved.
//

#import "Passage.h"
#import "Settings.h"
#import "OptionsViewController.h"

@implementation Passage

#define ARC4RANDOM_MAX      0x100000000
#define BUFFER selfView.frame.size.width/32 //this is just the space between the wall and the passage
#define MAX_TILT 4
#define MIN_TILT 2

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (NSMutableArray *) subviewArray {
    if (!_subviewArray) {
        _subviewArray = [[NSMutableArray alloc] init];
    }
    return _subviewArray;
}

- (int) generatePosOrNeg {
    //The following makes sure to generate either 1 or -1: this will affect the tilt direction
    int rand = (arc4random()%2);
    if (rand == 0) {
        rand = -1;
    }
    return rand;
}

- (int) reverseDifficulty : (int) difficulty {
    int x = difficulty;
    x-=4;
    x*=(-1);//harder difficulty is now higher number - reversed the order because in ViewController, a lower difficulty number is harder
    return x;
}

- (double) getBufferWithView:(UIView *)selfView {
    return BUFFER;
}

- (double) getMaxTiltWithView:(UIView *) selfView andDifficulty: (int) difficulty {
    double tilt = MAX_TILT * [self generateMultiplierWithDifficulty:difficulty] * (selfView.frame.size.width/320);
    return tilt;
}

- (double) generateTiltWithView: (UIView *)selfView andDifficulty: (int) difficulty max:(int) max min: (int) min {
    double tilt;
    
    if (max>=0 && min>=0) {
        tilt = (((double)arc4random() / ARC4RANDOM_MAX)*(max-min)+min);//Generates a number between min and max
    }
    else {
        tilt = (selfView.frame.size.width/320)*(((double)arc4random() / ARC4RANDOM_MAX)*(MAX_TILT-MIN_TILT)+MIN_TILT);
        double multiplier = [self generateMultiplierWithDifficulty:difficulty];//Adds to the steepness of harder levels - when the difficulty is 4 (the hardest - in the ViewController file this would be 0), then the tilt is multiplied by 1.16.  When the difficulty is 0, it isn't changed
        tilt*=multiplier;
    }
    return tilt;
}

- (double) generateMultiplierWithDifficulty: (int) difficulty {
    double mult = 1+((double)difficulty/10);
    return mult;
}

- (void) addSubviewsWithSpace:(CGFloat) space spaceXValue:(CGFloat) spaceX height: (CGFloat) height YCoord: (CGFloat) y andViewWidth:(CGFloat)viewWidth {//Breaking it!!
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, y, spaceX, height)];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(view.frame.size.width + space, view.frame.origin.y, viewWidth-view.frame.size.width-self.space, height)];
    if ([Settings getSavedSettings].passageColor) {
        [view setBackgroundColor:[Settings getSavedSettings].passageColor];
        [view2 setBackgroundColor:[Settings getSavedSettings].passageColor];
    }
    else {
        [view setBackgroundColor:[[OptionsViewController passageColorArray] objectAtIndex:0]];
        [view2 setBackgroundColor:[[OptionsViewController passageColorArray] objectAtIndex:0]];
    }
    [self addSubview:view];
    [self addSubview:view2];
    [self.subviewArray addObject:view];
    [self.subviewArray addObject:view2];
}

- (void) becomeBeaten {
    self.beaten = YES;
}

- (BOOL) isBeaten {
    return self.beaten;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
