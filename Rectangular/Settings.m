//
//  Settings.m
//  RectRotate
//
//  Created by Sam Noyes on 7/13/14.
//  Copyright (c) 2014 Samuel Noyes. All rights reserved.
//

#import "Settings.h"
#import "OptionsViewController.h"

@implementation Settings

#define SETTINGS_KEY @"settings7"
#define DEFAULT_SETTING_NUM 1

- (id) initWithSettingNum: (NSUInteger) i {
    self = [super init];
    if (self) {
        _backgroundColor = [[OptionsViewController backgroundColorArray] objectAtIndex:i];
        _rectColor = [[OptionsViewController rectColorArray] objectAtIndex:i];
        _passageColor = [[OptionsViewController passageColorArray] objectAtIndex:i];
        _labelColor = [[OptionsViewController labelColorArray] objectAtIndex:i];
        _schemeString = [[OptionsViewController colorStringArray] objectAtIndex:i];
        
    }
    return self;
}

+ (Settings *) getSavedSettings {
    Settings *s = nil;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_KEY]) {
        NSData *encodedObject = [[NSUserDefaults standardUserDefaults] objectForKey:SETTINGS_KEY];
        s = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    }
    if (!s) {
        s = [[Settings alloc] initWithSettingNum:DEFAULT_SETTING_NUM];
    }
    return s;
}
             

- (void) saveCurrentSettings {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:SETTINGS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#define RECT_COLOR @"rectColor3"
#define BACKGROUND_COLOR @"backgroundColor3"
#define PASSAGE_COLOR @"passageColor3"
#define SCHEME_STRING @"schemeString3"
#define LABEL_COLOR @"labelColor3"

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.rectColor forKey:RECT_COLOR];
    [encoder encodeObject:self.backgroundColor forKey:BACKGROUND_COLOR];
    [encoder encodeObject:self.passageColor forKey:PASSAGE_COLOR];
    [encoder encodeObject:self.labelColor forKey:LABEL_COLOR];
    [encoder encodeObject:self.schemeString forKey:SCHEME_STRING];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.rectColor = [decoder decodeObjectForKey:RECT_COLOR];
        self.backgroundColor = [decoder decodeObjectForKey:BACKGROUND_COLOR];
        self.passageColor = [decoder decodeObjectForKey:PASSAGE_COLOR];
        self.schemeString = [decoder decodeObjectForKey:SCHEME_STRING];
        self.labelColor = [decoder decodeObjectForKey:LABEL_COLOR];
    }
    return self;
}

- (NSString *) description {
    return self.schemeString;
}

@end
