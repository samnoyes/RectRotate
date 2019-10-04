//
//  ButtonMakerViewController.m
//  RectRotate
//
//  Created by Sam Noyes on 6/28/14.
//  Copyright (c) 2014 Samuel Noyes. All rights reserved.
//

#import "ButtonMakerViewController.h"
#import "Settings.h"

@interface ButtonMakerViewController ()

@end

@implementation ButtonMakerViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *) createGenericButtonForView: (UIView *) view rightAligned: (BOOL) right leftAligned:(BOOL) left centered: (BOOL) center yCoord: (double) y centeredOnY: (BOOL) centeredOnY withText: (NSString *) text {
    UIButton *but;
    but = [UIButton buttonWithType:UIButtonTypeCustom];
    [but setTitle:text forState:UIControlStateNormal];
    [but.titleLabel setFont: [UIFont fontWithName:@"OCRAStd" size:self.view.frame.size.width/14]];
    UIColor *butColor = [Settings getSavedSettings].labelColor;
    [but setTitleColor:butColor forState:UIControlStateNormal];
    CGSize butSize;
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        // here you go with iOS 7
        NSLog(@"You are running ios 7");
        butSize = [but.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:but.titleLabel.font}];
    }
    else {
        NSLog(@"You are on ios 6");
        butSize = [but.titleLabel.text sizeWithFont:but.titleLabel.font];
    }
    CGFloat width = butSize.width;
    CGFloat height = butSize.height;
    int buffer = 20;
    if (center) {
        [but setFrame:CGRectMake(view.frame.size.width/2-width/2, y, width, height)];
    }
    else if (right) {
        [but setFrame:CGRectMake(view.frame.size.width-width-buffer, y, width, height)];
    }
    else if (left) {
        [but setFrame:CGRectMake(buffer, y, width, height)];
    }
    if (centeredOnY) {
        [but setFrame:CGRectMake(but.frame.origin.x, but.frame.origin.y-but.frame.size.height/2, but.frame.size.width, but.frame.size.height)];
    }
    return but;
}

- (UIButton *) createGenericButtonForView: (UIView *) view rightAligned: (BOOL) right leftAligned:(BOOL) left centered: (BOOL) center yCoord: (double) y centeredOnY: (BOOL) centeredOnY withText: (NSString *) text withSize: (CGFloat) size {
    UIButton *but = [self createGenericButtonForView:view rightAligned:right leftAligned:left centered:center yCoord:y centeredOnY:centeredOnY withText:text];
    but.titleLabel.font = [UIFont fontWithName:but.titleLabel.font.familyName size:size];
    CGSize textSize = [text sizeWithFont:but.titleLabel.font];
    but.frame = CGRectMake(0, 0, textSize.width, textSize.height);
    if (left) {
        but.frame = CGRectMake(view.frame.size.width - textSize.width, 0, textSize.width, textSize.height);
    }
    else if (center) {
        but.frame = CGRectMake(view.frame.size.width/2 - textSize.width/2, 0, textSize.width, textSize.height);
    }
    but.frame = CGRectMake(but.frame.origin.x, y, textSize.width, textSize.height);
    if (centeredOnY) {
        but.frame = CGRectMake(but.frame.origin.x, but.frame.origin.y-but.frame.size.height/2, but.frame.size.width, but.frame.size.height);
    }
    return but;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
