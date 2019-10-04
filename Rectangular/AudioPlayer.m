//
//  AudioPlayer.m
//  RectRotate
//
//  Created by Sam Noyes on 6/11/14.
//  Copyright (c) 2014 Samuel Noyes. All rights reserved.
//

#import "AudioPlayer.h"
//THIS IS A SINGLETON CLASS

@implementation AudioPlayer

+(AudioPlayer *) sharedAudioPlayer {
    static AudioPlayer *sharedPlayer = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        NSURL *soundFileURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/RectRotate Music 2 4.mp3",[[NSBundle mainBundle] resourcePath]]];
        sharedPlayer = [[AudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
        sharedPlayer.numberOfLoops = -1;
    });
    return sharedPlayer;
}

@end
