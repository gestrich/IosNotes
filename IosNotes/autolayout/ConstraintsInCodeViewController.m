//
//  ConstraintsInCodeViewController.m
//  IosNotes
//
//  Created by William Gestrich on 4/25/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "ConstraintsInCodeViewController.h"

@interface ConstraintsInCodeViewController ()

@end

@implementation ConstraintsInCodeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    //When creating constraints in code, new views will automatically
    //have constraints set... You usually don't want this if you are setting
    //all the constraints yourself (can cause crash). So turn off by setting
    //setTranslatesAutoresizingMaskIntoConstraints to NO
    UIView *leftView = [[UIView alloc] init];
    [leftView setTranslatesAutoresizingMaskIntoConstraints:NO];
    leftView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:leftView];
  
    /* This section sets constraints using the NSLayoutConstraint
     * class method (no visual format language). This is provides
     * the most flexibility, as there are some thing visual format
     * langauge cannot do
     */
    NSLayoutConstraint *centerXCon = [NSLayoutConstraint constraintWithItem:leftView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    [self.view addConstraint:centerXCon];
    
    NSLayoutConstraint *centerYCon = [NSLayoutConstraint constraintWithItem:leftView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.view addConstraint:centerYCon];

    //Setting just the size ,not relative to any other view
    // So "toItem" is nil and attribute is NSLayoutAttributeNotAnAttribute 
    NSLayoutConstraint *widthCon = [NSLayoutConstraint constraintWithItem:leftView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.0];
    [self.view addConstraint:widthCon];
    
    NSLayoutConstraint *heigthCon = [NSLayoutConstraint constraintWithItem:leftView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.0];
    [self.view addConstraint:heigthCon];
    
    
   /*Visual Format Language Example
    */
   
    //Sizing constraints for right view
    UIView *rightView = [[UIView alloc] init];
    rightView.backgroundColor = [UIColor purpleColor];
    [rightView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:rightView];
    
    //vertical positioning constraints for right view
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[leftView][rightView(50)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(leftView, rightView)];
    [self.view addConstraints:constraints];
    
    //horizontal positioning constraints for right view
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[leftView][rightView(50)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(leftView, rightView)];
    [self.view addConstraints:constraints];
}


@end
