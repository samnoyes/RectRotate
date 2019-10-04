//
//  CirclePassage.h
//  RectRotate
//
//  Created by Sam Noyes on 7/7/14.
//  Copyright (c) 2014 Samuel Noyes. All rights reserved.
//

#import "Passage.h"

@interface CirclePassage : Passage

- (id) initWithRadius:(CGFloat)r andNumOfSubviews: (int) numOfSubviews andSubviewSize: (CGFloat) subviewSize withViewWidth:(CGFloat)viewWidth andSpaceCenterX: (CGFloat) spaceCX andSpaceWidth:(CGFloat) spaceWidth;
@end
