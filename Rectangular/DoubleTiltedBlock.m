//
//  DoubleTiltedBlock.m
//  RectRotate
//
//  Created by Sam Noyes on 7/5/14.
//  Copyright (c) 2014 Samuel Noyes. All rights reserved.
//

#import "DoubleTiltedBlock.h"
#import "CirclePassage.h"

@implementation DoubleTiltedBlock


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (NSMutableArray*) tiltedBlockArray {
    if (!_tiltedBlockArray) {
        _tiltedBlockArray = [[NSMutableArray alloc] init];
    }
    return _tiltedBlockArray;
}

//Designated initializer
- (id) initWithOneTiltedBlock:(TiltedBlock *) tiltedBlock inView: (UIView *) selfView withDifficulty:(int) difficulty {
    self = [super init];
    if (self) {
        self.tiltedBlockArray = [[NSMutableArray alloc] init];
        difficulty = [self reverseDifficulty:difficulty];
        
        [tiltedBlock setFrame:CGRectMake(0, 0, selfView.frame.size.width, tiltedBlock.numOfSubViews*tiltedBlock.subviewSize)];
        
        [self addSubview:tiltedBlock];
        
        
        CirclePassage *straightPassage = [[CirclePassage alloc]initWithRadius:selfView.frame.size.width/5.5 andNumOfSubviews:tiltedBlock.numOfSubViews andSubviewSize:tiltedBlock.subviewSize withViewWidth:selfView.frame.size.width andSpaceCenterX:tiltedBlock.startBottomGapX+tiltedBlock.space/2 andSpaceWidth:tiltedBlock.space];
        [straightPassage setFrame:CGRectMake(0, tiltedBlock.frame.size.height, selfView.frame.size.width, straightPassage.frame.size.height)];
        [self addSubview:straightPassage];
        
        
        TiltedBlock *other = [[TiltedBlock alloc] init];
        other.numOfSubViews = tiltedBlock.numOfSubViews;
        other.rand = -tiltedBlock.rand;
        double max = -1;
        double min = -1;
        if (other.rand>0) {// Tilted like \\\   ;
            if (((selfView.frame.size.width-[self getBufferWithView:selfView])-tiltedBlock.endBottomGapX)/tiltedBlock.numOfSubViews < [self getMaxTiltWithView:selfView andDifficulty:difficulty]) {
                max = ((selfView.frame.size.width-[self getBufferWithView:selfView])-tiltedBlock.endBottomGapX)/tiltedBlock.numOfSubViews;
                min = ((selfView.frame.size.width-[self getBufferWithView:selfView])-tiltedBlock.endBottomGapX)/tiltedBlock.numOfSubViews;
            }
        }
        else {//Tilted like ///
            if ((tiltedBlock.startBottomGapX-[self getBufferWithView:selfView])/tiltedBlock.numOfSubViews < [self getMaxTiltWithView:selfView andDifficulty:difficulty]) {
                max = (tiltedBlock.startBottomGapX-[self getBufferWithView:selfView])/tiltedBlock.numOfSubViews;
                min = (tiltedBlock.startBottomGapX-[self getBufferWithView:selfView])/tiltedBlock.numOfSubViews;
            }
        }
        other.tilt = [self generateTiltWithView:selfView andDifficulty:difficulty max:max min:min];
        other.space = tiltedBlock.space;
        other.startTopGapX = tiltedBlock.startBottomGapX;
        other.subviewSize = tiltedBlock.subviewSize;
        [other generateSubviewsInView:selfView rectSize:tiltedBlock.rectSize];
        [other setFrame:CGRectMake(0, straightPassage.frame.origin.y + straightPassage.frame.size.height, tiltedBlock.frame.size.width, tiltedBlock.frame.size.height)];
        [self addSubview:other];
        
        [self.tiltedBlockArray addObject:tiltedBlock];
        [self.tiltedBlockArray addObject:straightPassage];
        [self.tiltedBlockArray addObject:other];
    
        for (Passage *p in self.tiltedBlockArray) {
            for (UIView *v in p.subviewArray) {
                self.numOfSubViews++;
                [self.subviewArray addObject: v];
            }
        }
        
        [self setFrame:CGRectMake(0, 0, selfView.frame.size.width, tiltedBlock.frame.size.height+other.frame.size.height + straightPassage.frame.size.height)];
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
