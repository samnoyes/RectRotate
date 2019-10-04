//
//  GameOverView.m
//  RectRotate
//
//  Created by Sam Noyes on 7/16/14.
//  Copyright (c) 2014 Samuel Noyes. All rights reserved.
//

#import "GameOverView.h"

@implementation GameOverView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        self.opaque = NO;
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    UIBezierPath *rr = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.frame.size.width/5];
    [rr addClip];
    [[UIColor redColor] setFill];
    [rr fill];
}


@end
