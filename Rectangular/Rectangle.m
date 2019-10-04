//
//  Rectangle.m
//  RectRotate
//
//  Created by Sam Noyes on 7/14/14.
//  Copyright (c) 2014 Samuel Noyes. All rights reserved.
//

#import "Rectangle.h"
#import "Settings.h"
#import "OptionsViewController.h"

@implementation Rectangle

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
    if ([[Settings getSavedSettings].schemeString isEqualToString: @"Neon"]) {
        UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.frame.size.height/3.5];
        [roundedRect addClip];
        
        [[UIColor blackColor] setFill];
        [roundedRect fill];
        
        [[Settings getSavedSettings].rectColor setStroke];
        
        [roundedRect setLineWidth:self.frame.size.height/8];
        [roundedRect stroke];
    }
    else {
        [[Settings getSavedSettings].rectColor setFill];
        UIRectFill(self.bounds);
    }
}


@end
