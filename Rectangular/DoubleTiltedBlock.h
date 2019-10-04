//
//  DoubleTiltedBlock.h
//  RectRotate
//
//  Created by Sam Noyes on 7/5/14.
//  Copyright (c) 2014 Samuel Noyes. All rights reserved.
//

#import "Passage.h"
#import "TiltedBlock.h"

@interface DoubleTiltedBlock : Passage

@property (nonatomic, strong) NSMutableArray *tiltedBlockArray;
- (id) initWithOneTiltedBlock:(TiltedBlock *) tiltedBlock inView: (UIView *) selfView withDifficulty:(int) difficulty;

@end
