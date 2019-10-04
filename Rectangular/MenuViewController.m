//
//  MenuViewController.m
//  RectRotate
//
//  Created by Sam Noyes on 3/6/14.
//  Copyright (c) 2014 Samuel Noyes. All rights reserved.
//

#import "MenuViewController.h"
#import "AudioPlayer.h"
#import "Appirater.h"
#import "ViewController.h"
#import "Settings.h"
#import "OptionsViewController.h"
#import "InfoViewController.h"

@interface MenuViewController ()
@property (nonatomic) NSUInteger highscore;
@property (strong, nonatomic) UIButton *info;
@property (weak, nonatomic) IBOutlet UIImageView *menuImage;
@property (strong, nonatomic) UIButton *play;
@property (strong, nonatomic) UIButton *options;
@property (nonatomic) int currentTutorialValue;

@end

@implementation MenuViewController

#define SOUND_KEY @"soundKey"
#define ONCE_KEY @"justPlaySoundOnce15"
#define isiPhone5  ([[UIScreen mainScreen] bounds].size.height == 568)?TRUE:FALSE

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currentTutorialValue = 0;
#ifdef LITE
    NSLog(@"Setting Appirater app ID for lite version");
    [Appirater setAppId:@"898610082"];
#else
    NSLog(@"Setting Appirater app ID for full version");
    [Appirater setAppId:@"835923333"];
#endif
    NSLog(@"Configuring Appirater");
    [Appirater setDaysUntilPrompt:2];
    [Appirater setUsesUntilPrompt:10];
    [Appirater setSignificantEventsUntilPrompt:-1];
    [Appirater setTimeBeforeReminding:0];
    [Appirater setDebug:NO];
    
    
    
    //[UIApplication sharedApplication].statusBarHidden = NO;
    
    
    NSLog(@"About to set background image according to model.");
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        NSLog(@"You are on an iPad");
        if ([[Settings getSavedSettings].schemeString isEqualToString:@"Neon"]) {
            NSLog(@"Setting Neon background for iPad");
            [self.menuImage setImage:[UIImage imageNamed:@"RectRotateMenuNeoniPad.png"]];
        }
        else if ([[Settings getSavedSettings].schemeString isEqualToString:@"Classic"]) {
            NSLog(@"Setting Classic background for iPad");
            [self.menuImage setImage:[UIImage imageNamed:@"RectRotateMenuClassiciPad.png"]];
        }
        else {
            NSLog(@"Something is wrong with the settings dictionary.  Setting it to default of Classic for iPad");
            [self.menuImage setImage:[UIImage imageNamed:@"RectRotateMenuClassiciPad.png"]];
        }
    }
    else if (isiPhone5) {
        NSLog(@"You are on an iPhone 5");
        if ([[Settings getSavedSettings].schemeString isEqualToString:@"Neon"]) {
            NSLog(@"Setting Neon background for iPhone 5");
            [self.menuImage setImage:[UIImage imageNamed:@"RectRotateMenuNeoniPhone4-inch.png"]];
        }
        else if ([[Settings getSavedSettings].schemeString isEqualToString:@"Classic"]) {
            NSLog(@"Setting Classic background for iPhone 5");
            [self.menuImage setImage:[UIImage imageNamed:@"RectRotateMenuClassiciPhone.png"]];
        }
        else {
            NSLog(@"Something is wrong with the settings dictionary.  Setting it to default of Classic for iPhone 5");
            [self.menuImage setImage:[UIImage imageNamed:@"RectRotateMenuClassiciPhone.png"]];
        }
    }
    else {
        NSLog(@"You are on an iPhone 3.5-inch");
        if ([[Settings getSavedSettings].schemeString isEqualToString:@"Neon"]) {
            NSLog(@"Setting Neon background for iPhone 3.5-inch");
            [self.menuImage setImage:[UIImage imageNamed:@"RectRotateMenuNeoniPhone3-inch.png"]];
        }
        else if ([[Settings getSavedSettings].schemeString isEqualToString:@"Classic"]) {
            NSLog(@"Setting Classic background for iPhone 3.5-inch");
            [self.menuImage setImage:[UIImage imageNamed:@"RectRotateMenuClassiciPod3-inch.png"]];
        }
        else {
            NSLog(@"Something is wrong with the settings dictionary.  Setting it to default of Classic for iPhone 3.5-inch");
            [self.menuImage setImage:[UIImage imageNamed:@"RectRotateMenuClassiciPod3-inch.png"]];
        }
    }
    NSLog(@"Now setting menuImage");
    [self.menuImage setFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    

    NSLog(@"About to create the info button");
    self.info = [self createGenericButtonForView:self.view rightAligned:NO leftAligned:NO centered:YES yCoord:self.view.frame.size.height*(4.25f/7.0f) centeredOnY:YES withText:@"Info" withSize:self.view.frame.size.width/7];
    [self.view addSubview: self.info];
    [self.info addTarget:self action:@selector(presentViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    NSLog(@"About to create the options button");
    self.options = [self createGenericButtonForView:self.view rightAligned:NO leftAligned:NO centered:YES yCoord:(self.info.frame.origin.y-self.info.frame.size.height)*(9.0f/10.0f) centeredOnY:NO withText:@"Options" withSize:self.view.frame.size.width/7];
    [self.view addSubview: self.options];
    [self.options addTarget:self action:@selector(presentViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    NSLog(@"About to create the play button");
    self.play = [self createGenericButtonForView:self.view rightAligned:NO leftAligned:NO centered:YES yCoord:self.options.frame.origin.y-self.options.frame.size.height - (self.info.frame.origin.y-(self.options.frame.origin.y+self.options.frame.size.height)) centeredOnY:NO withText:@"Play" withSize:self.view.frame.size.width/7];
    [self.view addSubview: self.play];
    [self.play addTarget:self action:@selector(presentViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.highscore = [[NSUserDefaults standardUserDefaults] integerForKey:[ViewController highscoreKey]];
    [self createHighScoreLabel];
    
    if (self.doTutorial) {
        [self grayOut];
        [self performTutorial];
    }
    else if (![[NSUserDefaults standardUserDefaults] boolForKey:ONCE_KEY]) {
        NSLog(@"This is the first time the user has opened the app.  Starting the music.");
        [self grayOut];
        [self performTutorial];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:SOUND_KEY];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:ONCE_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:SOUND_KEY]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self primeAudioPlayer];
        });
    }
}

#define INSET self.view.frame.size.width/16

- (void) performTutorial {
    NSLog(@"In Tutorial");
    UIImageView *view = [[self tutorialImages] objectAtIndex:self.currentTutorialValue];
    [self.view addSubview:view];
    CGFloat yCoord = (self.view.frame.size.height/7)*4;
    UIButton *button;
    if (self.currentTutorialValue == [[self tutorialImages] count]-1) {
        button = [self createGenericButtonForView:self.view rightAligned:NO leftAligned:NO centered:YES yCoord:yCoord centeredOnY:YES withText:@"Done"];
    }
    else {
        button = [self createGenericButtonForView:self.view rightAligned:NO leftAligned:NO centered:YES yCoord:yCoord centeredOnY:YES withText:@"Next"];
    }
    [button addTarget:self action:@selector(advanceTutorial) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    //[grayView removeFromSuperview];
}

- (void) advanceTutorial {
    self.currentTutorialValue++;
    if (self.currentTutorialValue >= [[self tutorialImages] count]) {
        UIStoryboard *storyboard = self.storyboard;
        OptionsViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"main"];
        [self presentViewController:vc animated:NO completion:nil];
    }
    else {
        [self performTutorial];
    }
}

- (UIView *) grayOut {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [view setBackgroundColor:[UIColor blackColor]];
    view.alpha = .8;
    [self.view addSubview:view];
    return view;
}

- (NSArray *) tutorialImages {
    CGFloat viewHeight = self.view.frame.size.height-INSET*2;
    CGFloat viewWidth = viewHeight*(320.0/568.0);
    NSLog(@"viewWidth = %f, viewHeight = %f",viewWidth,viewHeight);
    UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TiltTutorial.png"]];
    [view setFrame:CGRectMake(self.view.frame.size.width/2-viewWidth/2, INSET, viewWidth, viewHeight)];
    UIImageView *view2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Tutorial.png"]];
    [view2 setFrame:CGRectMake(self.view.frame.size.width/2-viewWidth/2, INSET, viewWidth,viewHeight)];
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-viewWidth/2, INSET, viewWidth, viewHeight)];
    [view3 setBackgroundColor:[[OptionsViewController backgroundColorArray] objectAtIndex:1]];
    UITextView *label = [[UITextView alloc] initWithFrame:CGRectMake(INSET, INSET*3, view3.frame.size.width-INSET*2, self.view.frame.size.height)];
    label.text = @"That's it! Enjoy the game!";
    label.font = [UIFont fontWithName:@"OCRAStd" size:self.view.frame.size.width/15];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    label.userInteractionEnabled = NO;
    [view3 addSubview:label];
    return @[view, view2, view3];
}

- (void) presentViewController:(UIButton *) sender {
    if ([sender.titleLabel.text isEqual:@"Options"]) {
        UIStoryboard *storyboard = self.storyboard;
        OptionsViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"NavController"];
        [self presentViewController:vc animated:YES completion:nil];
    }
    else if ([sender.titleLabel.text isEqual:@"Play"]) {
        UIStoryboard *storyboard = self.storyboard;
        ViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"game"];
        [self presentViewController:vc animated:YES completion:nil];
    }
    else if ([sender.titleLabel.text isEqual: @"Info"]) {
        UIStoryboard *storyboard = self.storyboard;
        InfoViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Info"];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

-(void)primeAudioPlayer {
    [[AudioPlayer sharedAudioPlayer] prepareToPlay];
    [[AudioPlayer sharedAudioPlayer] play];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (NSString *) getSoundKey {
    return SOUND_KEY;
}

- (void) createHighScoreLabel {
    NSString *text = [NSString stringWithFormat:@"Highscore: %lu",(unsigned long)self.highscore];
    UIFont *font = [UIFont fontWithName:@"OCRAStd" size:self.view.frame.size.width/8];
    CGFloat width = self.view.frame.size.width * .75;
    UILabel *highscoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-width/2, self.info.frame.origin.y + self.info.frame.size.height + (((self.view.frame.size.height-(self.info.frame.origin.y + self.info.frame.size.height))*(4.0f/13.0f)-(self.info.frame.size.height/2))), width, 500)];
    highscoreLabel.adjustsFontSizeToFitWidth = YES;
    highscoreLabel.minimumScaleFactor = 0;
    highscoreLabel.font = font;
    highscoreLabel.text = text;
    CGSize size = [text sizeWithFont:highscoreLabel.font];
    [highscoreLabel setFrame:CGRectMake(highscoreLabel.frame.origin.x, highscoreLabel.frame.origin.y, highscoreLabel.frame.size.width, size.height)];
    [self.view addSubview:highscoreLabel];
    [highscoreLabel setTextColor:[Settings getSavedSettings].labelColor];
    [highscoreLabel setBackgroundColor:[UIColor clearColor]];
}

/*
- (void) createHighScoreLabel {
    int width = 10000;
    int height = self.info.frame.size.height-10;
    int numHeight = height;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-width/2, self.info.frame.origin.y + self.info.frame.size.height + (((self.view.frame.size.height-(self.info.frame.origin.y + self.info.frame.size.height))*(4.0f/13.0f)-(self.info.frame.size.height/2))), 0, height)];
    UIImageView *highscore = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width*(4.0f/7.0f), height)];
    highscore.image = [UIImage imageNamed:[NSString stringWithFormat:@"Highscore2.png"]];
    [view addSubview:highscore];
    UIView *imageString = [self createImageStringWithX:highscore.frame.origin.x+highscore.frame.size.width Y:0 height:numHeight];
    [view addSubview:imageString];
    width = highscore.frame.size.width+imageString.frame.size.width;
    view.frame = CGRectMake(self.view.frame.size.width/2-width/2, view.frame.origin.y, width, view.frame.size.height);
    [self.view addSubview:view];
}
*/
/*
- (UIView *) createImageStringWithX:(int)x Y:(int)y height:(int) height {
    NSString *highscoreString = [NSString stringWithFormat:@"%lu",(unsigned long)self.highscore];
    unsigned long int len = [highscoreString length];
    unichar buffer[len + 1];
    int singleNumWidth = self.view.frame.size.width/15;
    [highscoreString getCharacters:buffer range:NSMakeRange(0, len)];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, singleNumWidth*len, height)];
    for(int i = 0; i < len; ++i) {
        char current = buffer[i];
        UIImageView *num = [[UIImageView alloc] initWithFrame:CGRectMake(i*singleNumWidth+10, 3, singleNumWidth, height-10)];
        num.image = [UIImage imageNamed:[NSString stringWithFormat:@"%c2.png", current]];
        [view addSubview:num];
    }
    return view;
}
*/
@end
