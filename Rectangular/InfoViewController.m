//
//  InfoViewController.m
//  RectRotate
//
//  Created by Samuel Noyes on 3/4/14.
//  Copyright (c) 2014 Samuel Noyes. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()
@property (strong, nonatomic) IBOutlet UIButton *mainMenu;
@property (strong, nonatomic) IBOutlet UIButton *contactMe;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation InfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#define BUTTON_WIDTH self.view.frame.size.width/2
#define BUTTON_HEIGHT self.view.frame.size.height/11.72

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"INFO:\n\nHow to Play:\nTap either side of the screen to rotate the blue rectangle, and tilt the device to move the rectcangle side to side.  The object of the game is to avoid the black blocks by navigating through their small gaps.  Every time a block is avoided, a point is added to the user's score.  The score is indicated in the middle at the top of the screen.\n\nI would love to hear your comments, suggestions, and feedback!  Just click the link below to contact me!"]];
    [str addAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"OCRAStd" size:self.view.frame.size.height/35]} range:NSMakeRange(0, [str length])];
    [str addAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"OCRAStd" size:self.view.frame.size.width/10], NSStrokeWidthAttributeName : @-8} range:[[str string] rangeOfString:@"INFO:"]];
    self.textView.attributedText = str;
    [self.textView sizeToFit];
    
    
    self.contactMe = [self createGenericButtonForView:self.view rightAligned:NO leftAligned:NO centered:YES yCoord:((self.view.frame.size.height - (self.textView.frame.origin.y + self.textView.frame.size.height))/3)+self.textView.frame.size.height+self.textView.frame.origin.y centeredOnY:YES withText:@"Contact Me"];
    [self.contactMe addTarget:self action:@selector(contact) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.contactMe];
    
    self.mainMenu = [self createGenericButtonForView:self.view rightAligned:NO leftAligned:NO centered:YES yCoord:((self.view.frame.size.height - (self.textView.frame.origin.y + self.textView.frame.size.height))/3)*2+self.textView.frame.size.height+self.textView.frame.origin.y centeredOnY:YES withText:@"Main Menu"];
    [self.mainMenu addTarget:self action:@selector(goToMainMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.mainMenu];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) goToMainMenu {
    UIViewController* vc =
    [self.storyboard instantiateViewControllerWithIdentifier:@"main"];
    
    [self presentViewController:vc animated:YES completion:nil];
}

-(void) contact {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
        controller.mailComposeDelegate = self;
        [controller setSubject:@"Support"];
        [controller setMessageBody:@"" isHTML:NO];
        [controller setToRecipients:[NSArray arrayWithObjects:@"nancynoyesprogramming@gmail.com", nil]];
        if (controller) [self presentViewController:controller animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You're device is not set up for email support.  Sorry about that!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
