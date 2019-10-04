//
//  ButtonMakerViewController.h
//  RectRotate
//
//  Created by Sam Noyes on 6/28/14.
//  Copyright (c) 2014 Samuel Noyes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonMakerViewController : UIViewController

- (UIButton *) createGenericButtonForView: (UIView *) view rightAligned: (BOOL) right leftAligned:(BOOL) left centered: (BOOL) center yCoord: (double) y centeredOnY: (BOOL) centeredOnY withText: (NSString *) text;

- (UIButton *) createGenericButtonForView: (UIView *) view rightAligned: (BOOL) right leftAligned:(BOOL) left centered: (BOOL) center yCoord: (double) y centeredOnY: (BOOL) centeredOnY withText: (NSString *) text withSize: (CGFloat) size;


@end
