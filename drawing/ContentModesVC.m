//
//  ContentModesVC.m
//  IosNotes
//
//  Created by William Gestrich on 4/29/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "ContentModesVC.h"
#import "CustomView.h"
#import "UIKitDrawingDemo.h"

#define CUSTOM_VIEW_TAG 1000

@interface ContentModesVC (){
    UIViewContentMode mode;
}

@end

@implementation ContentModesVC

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
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:(CGRect){0,0, self.view.frame.size.width, 50}];
    [self.view addSubview:toolbar];
    UIBarButtonItem *increaseButton = [[UIBarButtonItem alloc] initWithTitle:@"Increase" style:UIBarButtonItemStyleBordered target:self action:@selector(increaseViewSize)];
    UIBarButtonItem *decreaseButton = [[UIBarButtonItem alloc] initWithTitle:@"Decrease" style:UIBarButtonItemStyleBordered target:self action:@selector(decreaseViewSize)];
    toolbar.items = @[increaseButton, decreaseButton];
    
    CustomView * customView = [[CustomView alloc] initWithFrame:(CGRect){0.0, toolbar.frame.size.height,
        (CGSize){self.view.frame.size.width/2., self.view.frame.size.height/2.}}];
    customView.contentMode = UIViewContentModeCenter;
    customView.tag = CUSTOM_VIEW_TAG;
    [self.view addSubview:customView];
    customView.backgroundColor = [UIColor lightGrayColor];
    
    
    UIKitDrawingDemo * uiKitView = [[UIKitDrawingDemo alloc] initWithFrame:(CGRect){self.view.frame.size.width/2, toolbar.frame.size.height,
        (CGSize){self.view.frame.size.width/2., self.view.frame.size.height/2.}}];
    UILabel *uiKitLabel = [[UILabel alloc] init];
    uiKitLabel.text = @"Drawing with UIKit";
    uiKitLabel.font = [UIFont systemFontOfSize:12];
    [uiKitLabel sizeToFit];
    uiKitLabel.center = (CGPoint){uiKitView.bounds.size.width/2, uiKitLabel.bounds.size.height/2};
    [uiKitView addSubview:uiKitLabel];
    uiKitView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:uiKitView];
}

-(void)increaseViewSize{
    UIView *customView = [self.view viewWithTag:CUSTOM_VIEW_TAG];
    customView.frame = (CGRect){customView.frame.origin.x,
        customView.frame.origin.y,
        customView.frame.size.width+1,
        customView.frame.size.height+1};
}

-(void)decreaseViewSize{
    UIView *customView = [self.view viewWithTag:CUSTOM_VIEW_TAG];
    customView.frame = (CGRect){customView.frame.origin.x,
        customView.frame.origin.y,
        customView.frame.size.width-1,
        customView.frame.size.height-1};
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
