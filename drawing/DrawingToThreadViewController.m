//
//  DrawingToThreadViewController.m
//  IosNotes
//
//  Created by William Gestrich on 5/9/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "DrawingToThreadViewController.h"

@interface DrawingToThreadViewController ()

@property (nonatomic, strong, readwrite) UIActivityIndicatorView *activity;

@end

@implementation DrawingToThreadViewController

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
    
    //Show indicator
    
    self.activity = [[UIActivityIndicatorView alloc] initWithFrame:(CGRect){50,50,100,100}];
    self.activity.color = [UIColor redColor];
    
    [self.activity startAnimating];
    
    [self.view addSubview:self.activity];
    
    //Do something time consumilng
    dispatch_queue_t bgqueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(bgqueue, ^{
        for(double x = 0; x<1000000000; x++){
            
        }
        dispatch_async(dispatch_get_main_queue(),
        ^{
            //Hide indicator
            [self.activity stopAnimating];
        }
   
   
                       );
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
