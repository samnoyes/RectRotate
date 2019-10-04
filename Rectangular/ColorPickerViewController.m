//
//  ColorPickerViewController.m
//  RectRotate
//
//  Created by Sam Noyes on 6/30/14.
//  Copyright (c) 2014 Samuel Noyes. All rights reserved.
//

#import "ColorPickerViewController.h"
#import "OptionsViewController.h"
#import "Settings.h"

@interface ColorPickerViewController ()
@property (nonatomic, weak) IBOutlet UIPickerView *colorPicker;
@end

@implementation ColorPickerViewController

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
    self.colorPicker.delegate = self;
    self.colorPicker.dataSource = self;
    [self.colorPicker sizeToFit];
    self.colorPicker.frame = CGRectMake(0, (self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height)+(self.view.frame.size.height-(self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height))/2-self.colorPicker.frame.size.height/2, self.view.frame.size.width, self.colorPicker.frame.size.height);
    self.navigationController.navigationBarHidden = NO;
    NSLog(@"savedSettings = %@, ", [Settings getSavedSettings]);
    if ([Settings getSavedSettings] && [[OptionsViewController colorStringArray] indexOfObject:[Settings getSavedSettings].schemeString] != NSNotFound) {
        [self.colorPicker selectRow:[[OptionsViewController colorStringArray] indexOfObject:[Settings getSavedSettings].schemeString] inComponent:0 animated:NO];
    }
    else {
        NSLog(@"Did it");
        [self.colorPicker selectRow:0 inComponent:0 animated:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark pickerView delegate/dataSource methods

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return [[OptionsViewController colorStringArray] count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    return [[OptionsViewController colorStringArray] objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    [self synchronize];
}

- (void) synchronize {
    Settings *settings = [Settings getSavedSettings];
    settings.rectColor = [[OptionsViewController rectColorArray] objectAtIndex: [self.colorPicker selectedRowInComponent:0]];
    settings.passageColor = [[OptionsViewController passageColorArray] objectAtIndex:[self.colorPicker selectedRowInComponent:0]];
    settings.backgroundColor = [[OptionsViewController backgroundColorArray] objectAtIndex:[self.colorPicker selectedRowInComponent:0]];
    settings.labelColor = [[OptionsViewController labelColorArray] objectAtIndex:[self.colorPicker selectedRowInComponent:0]];
    settings.schemeString = [[OptionsViewController colorStringArray] objectAtIndex:[self.colorPicker selectedRowInComponent:0]];
    [settings saveCurrentSettings];
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
