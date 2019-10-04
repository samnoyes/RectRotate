//
//  AudioPlayer.h
//  RectRotate
//
//  Created by Sam Noyes on 6/11/14.
//  Copyright (c) 2014 Samuel Noyes. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface AudioPlayer : AVAudioPlayer

+(AudioPlayer *) sharedAudioPlayer;


@end
