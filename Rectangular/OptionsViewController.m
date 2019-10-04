//
//  OptionsViewController.m
//  RectRotate
//
//  Created by Sam Noyes on 3/6/14.
//  Copyright (c) 2014 Samuel Noyes. All rights reserved.
//



//NOT IN USE
#import "OptionsViewController.h"
#import "AudioPlayer.h"
#import "ViewController.h"
#import "MenuViewController.h"
#import "ColorPickerViewController.h"
#import "Settings.h"

@interface OptionsViewController ()
@property (strong, nonatomic) NSMutableDictionary *settingsDictionary;
@property (nonatomic) NSNumber *color;
@property (strong,nonatomic) UIButton *toggleSoundButton;
@property (strong,nonatomic) UIButton *resetHighscoreButton;
@property (strong,nonatomic) UIButton *mainMenuButton;
@property (weak, nonatomic) IBOutlet UILabel *optionsLabel;
@property (strong, nonatomic) UIButton *changeRectColor;
@property (strong, nonatomic) UIButton *tutorial;
@property (strong, nonatomic) NSMutableArray *buttonsArray;
@property (nonatomic) BOOL liteVersion;
@property (strong, nonatomic) UIButton *upgradeButton;
@end

@implementation OptionsViewController

#define SETTINGS_DICTIONARY_KEY @"settingsDictionary3"
#define COLOR_KEY @"color2"
#define BUFFER self.view.frame.size.height/20

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.optionsLabel.textColor = [Settings getSavedSettings].rectColor;
    [self.view setBackgroundColor:[Settings getSavedSettings].backgroundColor];
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.delegate = self;
	// Do any additional setup after loading the view.
    
    [NSTimer scheduledTimerWithTimeInterval:.2 target:self selector:@selector(updateButtons) userInfo:nil repeats:YES];
    [self.optionsLabel setFont:[UIFont fontWithName:@"OCRAStd" size:self.view.frame.size.width/8]];
    NSAttributedString *optionString = [[NSAttributedString alloc] initWithString:@"Options" attributes:@{NSStrokeWidthAttributeName : @(-4)}];
    [self.optionsLabel setAttributedText:optionString];
    [self.optionsLabel sizeToFit];
    [self.optionsLabel setFrame:CGRectMake(self.view.frame.size.width/2-self.optionsLabel.frame.size.width/2, self.optionsLabel.frame.origin.y, self.optionsLabel.frame.size.width, self.optionsLabel.frame.size.height + 20)];
    
    if (!self.changeRectColor) {
        [self initButtons];
    }
    else {
        for (UIButton *but in self.buttonsArray) {
            [but setTitleColor:[Settings getSavedSettings].labelColor forState:UIControlStateNormal];
        }
        [self.mainMenuButton setTitleColor:[Settings getSavedSettings].labelColor forState:UIControlStateNormal];
        [self.view setBackgroundColor:[Settings getSavedSettings].backgroundColor];
        [self.optionsLabel setTextColor:[Settings getSavedSettings].rectColor];
    }
}

- (BOOL) liteVersion {
    BOOL lv = NO;
#ifdef LITE
    lv = YES;
#endif
    return lv;
}

+(NSMutableArray *) labelColorArray {
    static NSMutableArray *_colorArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _colorArray = [[NSMutableArray alloc] init];
        //[_colorArray addObject: [UIColor colorWithRed:7.0/255.0 green:68.0/255.0 blue:33.0/255.0 alpha:1]];
        [_colorArray addObject: [UIColor colorWithRed:57.0/255.0 green:.7 blue:20.0/255.0 alpha:1]];
        [_colorArray addObject: [[[self class] rectColorArray] objectAtIndex:1]];
    });
    return _colorArray;
}

+(NSMutableArray *) passageColorArray {
    static NSMutableArray *_colorArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _colorArray = [[NSMutableArray alloc] init];
        [_colorArray addObject: [[[self class] rectColorArray] objectAtIndex:0]];
        [_colorArray addObject: [UIColor blackColor]];
    });
    return _colorArray;
}

+(NSMutableArray *) backgroundColorArray {
    static NSMutableArray *_colorArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _colorArray = [[NSMutableArray alloc] init];
        [_colorArray addObject: [UIColor blackColor]];
        [_colorArray addObject: [UIColor colorWithRed:105.0/255.0 green:114.0/255.0 blue:228.0/255.0 alpha:1]];
    });
    return _colorArray;
}

+ (NSMutableArray *)rectColorArray
{
    static NSMutableArray *_colorArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _colorArray = [[NSMutableArray alloc] init];
        [_colorArray addObject: [UIColor colorWithRed:57.0/255.0 green:1 blue:20.0/255.0 alpha:1]];
        [_colorArray addObject: [UIColor colorWithRed:11.0/255.0 green:18.0/255.0 blue:122.0/255.0 alpha:1]];
    });
    return _colorArray;
}

+ (NSMutableArray *)colorStringArray
{
    static NSMutableArray *_colorArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _colorArray = [[NSMutableArray alloc] init];
        [_colorArray addObject: @"Neon"];
        [_colorArray addObject: @"Classic"];
    });
    return _colorArray;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[OptionsViewController class]]) {
        [self viewDidLoad];
    }
}

/*
- (void) synchronize {
    self.settingsDictionary =  [[NSMutableDictionary alloc] initWithDictionary:@{COLOR_KEY : self.color}];
    [[NSUserDefaults standardUserDefaults] setObject:self.settingsDictionary forKey:SETTINGS_DICTIONARY_KEY];
}
 */

- (void) goToPickerView: (id) sender {
    UIStoryboard *storyboard = self.storyboard;
    ColorPickerViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ColorPicker"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) initButtons {
    if (!self.liteVersion) {
        self.changeRectColor = [self createGenericButtonForView:self.view rightAligned:NO leftAligned:NO centered:YES yCoord:10 centeredOnY:YES withText:@"Change Colors"];
        [self.changeRectColor addTarget:self action:@selector(goToPickerView:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.changeRectColor];
    }
    else {
        self.upgradeButton = [self createGenericButtonForView:self.view rightAligned:NO leftAligned:NO centered:YES yCoord:10 centeredOnY:YES withText:@"Get Full Version!"];
        [self.upgradeButton addTarget:self action:@selector(upgrade) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.upgradeButton];
    }
    
    if (!self.toggleSoundButton) {
        self.toggleSoundButton = [self createGenericButtonForView:self.view rightAligned:NO leftAligned:NO centered:YES yCoord:0 centeredOnY:YES withText:@"Toggle Sound"];
        [self.toggleSoundButton addTarget:self action:@selector(toggleSound) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.toggleSoundButton];
    }
    
    self.resetHighscoreButton = [self createGenericButtonForView:self.view rightAligned:NO leftAligned:NO centered:YES yCoord:0 centeredOnY:YES withText:@"Reset Highscore"];
    [self.resetHighscoreButton addTarget:self action:@selector(resetHighscore) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.resetHighscoreButton];
    
    self.tutorial = [self createGenericButtonForView:self.view rightAligned:NO leftAligned:NO centered:YES yCoord:0 centeredOnY:YES withText:@"Watch Tutorial"];
    [self.tutorial addTarget:self action:@selector(watchTutorial) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.tutorial];
    
    self.mainMenuButton = [self createGenericButtonForView:self.view rightAligned:NO leftAligned:NO centered:YES yCoord:self.view.frame.size.height-self.view.frame.size.height/32-self.mainMenuButton.frame.size.height centeredOnY:NO withText:@"Main Menu"];
    [self.mainMenuButton setFrame:CGRectMake(self.mainMenuButton.frame.origin.x, self.view.frame.size.height-self.view.frame.size.height/26-self.mainMenuButton.frame.size.height, self.mainMenuButton.frame.size.width, self.mainMenuButton.frame.size.height)];
    [self.mainMenuButton addTarget:self action:@selector(goToMainMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.mainMenuButton];
    
    self.buttonsArray = [[NSMutableArray alloc] init];
    if (!self.liteVersion)
        [self.buttonsArray addObject:self.changeRectColor];
    else
        [self.buttonsArray addObject: self.upgradeButton];
    [self.buttonsArray addObject:self.toggleSoundButton];
    [self.buttonsArray addObject:self.resetHighscoreButton];
    [self.buttonsArray addObject:self.tutorial];
    //[self.buttonsArray addObject:self.mainMenuButton];
    
    
    [self adjustButtons];
    [self updateButtons];
}

-(void) upgrade {
    [self loadFullVersion];
    NSLog(@"Trying");
}

- (void) watchTutorial {
    MenuViewController* vc =
    [self.storyboard instantiateViewControllerWithIdentifier:@"main"];
    vc.doTutorial = YES;
    [self presentViewController:vc animated:YES completion:nil];
}

#define APP_STORE_URL @"itms://itunes.apple.com/app/id835923333"

- (void) loadFullVersion {
    NSURL* redirectToURL = [NSURL URLWithString:APP_STORE_URL];
    [[UIApplication sharedApplication] openURL:redirectToURL];
}

- (void) adjustButtons {
    [self.mainMenuButton setFrame:CGRectMake(self.view.frame.size.width/2-self.mainMenuButton.frame.size.width/2, self.view.frame.size.height * (9.0f/10.0f),self.mainMenuButton.frame.size.width, self.mainMenuButton.frame.size.height)];
    float openSpace = self.view.frame.size.height-(self.optionsLabel.frame.size.height+self.optionsLabel.frame.origin.y)-(self.view.frame.size.height-self.mainMenuButton.frame.origin.y);
    for (UIButton *but in self.buttonsArray) {
        [but setFrame:CGRectMake(but.frame.origin.x,openSpace*((float)[self.buttonsArray indexOfObject:but]/(float)[self.buttonsArray count]), but.frame.size.width,but.frame.size.height)];
    }
    [self shiftButtonsDown];
    
    if (self.liteVersion)
        [self addPromotionText];
}

-(void) addPromotionText {
    CGFloat width = self.view.frame.size.width*.75;
    UITextView *v = [[UITextView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-width/2, self.upgradeButton.frame.origin.y+self.upgradeButton.frame.size.height, width, 5)];
    
    [v setText:@"Includes:\n-NO ADS\n-ALL NEW Neon Mode\n-Exciting 'Double Passages'"];
    [v setFont:[UIFont systemFontOfSize:self.view.frame.size.height/45]];
    [v setTextColor:[UIColor blackColor]];
    [v sizeToFit];
    v.userInteractionEnabled = NO;
    v.backgroundColor = [UIColor clearColor];
    [self.view addSubview:v];
    [v setFrame: CGRectMake(self.upgradeButton.frame.origin.x, v.frame.origin.y, v.frame.size.width, v.frame.size.height)];
}

- (void) shiftButtonsDown {
    for (UIButton *but in self.buttonsArray) {
        CGRect frame = but.frame;
        frame.origin.y += self.optionsLabel.frame.size.height + self.optionsLabel.frame.origin.y + BUFFER;
        but.frame = frame;
    }
    
}

- (void) goToMainMenu {
    UIViewController* vc =
    [self.storyboard instantiateViewControllerWithIdentifier:@"main"];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void) toggleSound {
    if ([AudioPlayer sharedAudioPlayer].isPlaying)
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:[MenuViewController getSoundKey]];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[AudioPlayer sharedAudioPlayer] stop];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[MenuViewController getSoundKey]];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[AudioPlayer sharedAudioPlayer] prepareToPlay];
        [[AudioPlayer sharedAudioPlayer] play];
    }
    [self updateButtons];
}

- (void) updateButtons {
    if ([AudioPlayer sharedAudioPlayer].isPlaying) {
        [self.toggleSoundButton setTitle:@"Turn sound off" forState:UIControlStateNormal];
    }
    else {
        [self.toggleSoundButton setTitle:@"Turn sound on" forState:UIControlStateNormal];
    }
    [self.toggleSoundButton sizeToFit];
    [self.toggleSoundButton setFrame:CGRectMake(self.view.frame.size.width/2-self.toggleSoundButton.frame.size.width/2, self.toggleSoundButton.frame.origin.y, self.toggleSoundButton.frame.size.width, self.toggleSoundButton.frame.size.height)];
}

- (void) resetHighscore {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Really reset?" message:@"Do you really want to reset the highscore?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
    // optional - add more buttons:
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked OK
    if (buttonIndex == 1) {
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:[ViewController highscoreKey]];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
