//
//  TiltedBlock.m
//  Rectangular
//
//  Created by Samuel Noyes on 2/18/14.
//  Copyright (c) 2014 Samuel Noyes. All rights reserved.
//

#import "TiltedBlock.h"

@interface TiltedBlock()
@end

@implementation TiltedBlock


//#define self.subviewSize (rectSize*2)/self.numOfSubViews


- (id) init {
    self = [super init];
    return self;
}

-(id) initRandomTiltedBlockWithSpace:(int)space andNumOfViews:(int)numOfSubViews inView:(UIView *) selfView difficulty:(int)difficulty rectSize:(float)rectSize  {
    self = [super init];
    if (self){
        
        self.space = space;
        self.numOfSubViews = numOfSubViews;
        self.rectSize = rectSize;
        self.selfView = selfView;
        
        self.subviewSize = (rectSize*2)/numOfSubViews;
        
        [self setFrame:CGRectMake(0, -self.subviewSize*numOfSubViews, selfView.frame.size.width, rectSize*2)];
        
        
        difficulty = [self reverseDifficulty:difficulty];
        
        
        self.rand = [self generatePosOrNeg];
        
        self.tilt = [self generateTiltWithView:selfView andDifficulty: difficulty max:-1 min:-1];
        
        //tilt = (selfView.frame.size.width/320)*(6);//This tests what the maximum tilt looks like

        //********************************
        
        self.startTopGapX = [self generateStartWithRand: self.rand view:selfView difficulty:difficulty];
        self.endTopGapX = self.startTopGapX+self.space;
        self.startBottomGapX = self.numOfSubViews*self.tilt*self.rand+self.startTopGapX;
        self.endBottomGapX = self.numOfSubViews*self.tilt*self.rand+self.endTopGapX;
        
        //*******************************
        
        [self generateSubviewsInView: selfView rectSize:rectSize];
        
    }
    return self;
}

- (CGFloat) generateStartWithRand: (int) rand view:(UIView *) selfView difficulty: (int) difficulty {
    CGFloat start;
    if (rand>0) {//means the passage is tilted in this direction: \\\
        
            start = [ViewController generateRandomNumberBetweenMin:[self getBufferWithView: self.selfView] Max:selfView.frame.size.width-self.space-[self getMaxTiltWithView:selfView andDifficulty:difficulty]*self.numOfSubViews-[self getBufferWithView: self.selfView]];
        
    }
    else {// passage is tilted like this: ///
            start = [ViewController generateRandomNumberBetweenMin:[self getMaxTiltWithView:selfView andDifficulty:difficulty]*self.numOfSubViews+[self getBufferWithView: self.selfView] Max:selfView.frame.size.width-self.space-[self getBufferWithView: self.selfView]];
    }
    return start;
}

- (void) generateSubviewsInView:(UIView *) selfView rectSize: (float) rectSize {
    for (int i = 0; i<self.numOfSubViews; i++) {//generate the subviews and place them
        [self addSubviewsWithSpace:self.space spaceXValue:self.startTopGapX+(i*self.tilt)*self.rand height: self.subviewSize YCoord: i*self.subviewSize andViewWidth:selfView.frame.size.width];
    }
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



@end
