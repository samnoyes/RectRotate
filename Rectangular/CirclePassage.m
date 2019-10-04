//
//  CirclePassage.m
//  RectRotate
//
//  Created by Sam Noyes on 7/7/14.
//  Copyright (c) 2014 Samuel Noyes. All rights reserved.
//

#import "CirclePassage.h"

@implementation CirclePassage

- (id) initWithRadius:(CGFloat)r andNumOfSubviews: (int) numOfSubviews andSubviewSize: (CGFloat) subviewSize withViewWidth:(CGFloat)viewWidth andSpaceCenterX: (CGFloat) spaceCX andSpaceWidth:(CGFloat) spaceWidth {//USE THE SPACEX
    self = [super init];
    if (self) {
        if (numOfSubviews%2 == 0) {
            numOfSubviews++;
        }
        self.subviewSize = subviewSize;
        self.numOfSubViews = numOfSubviews;
        [self setFrame:CGRectMake(0, 0, viewWidth, numOfSubviews*subviewSize)];
        float multiplier = pow(r, 1.0/((self.numOfSubViews-1)/2+1));
        
        [self addSubviewsWithSpace:r*2 spaceXValue:(spaceCX-r) height:subviewSize YCoord:(CGFloat)(self.frame.size.height/2-subviewSize/2) andViewWidth:viewWidth];
        for (int i = 0; i<(self.numOfSubViews-1)/2; i++) {
            float newMultiplier = multiplier;
            for (int j = 0; j<i; j++) {
                newMultiplier *= multiplier;
            }
            [self addSubviewsWithSpace:r*2-newMultiplier spaceXValue:spaceCX-r+newMultiplier/2 height:subviewSize YCoord:((subviewSize*numOfSubviews)/2-subviewSize*3.0/2.0)-i*subviewSize andViewWidth:viewWidth];
            [self addSubviewsWithSpace:r*2-newMultiplier spaceXValue:spaceCX-r+newMultiplier/2 height:subviewSize YCoord:((subviewSize*numOfSubviews)/2+subviewSize/2)+i*subviewSize andViewWidth:viewWidth];
        }
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
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
