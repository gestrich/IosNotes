//
//  ViewController.m
//  IosNotes
//
//  Created by William Gestrich on 4/4/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "ViewController.h"
#import "Messaging.h"
#import "NotificationTrampoline.h"
#import "UndoFeature.h"
#import "NotificationObserver.h"
#import "SharedSingleton.h"
#import "ContentModesVC.h"


@interface ViewController (){
    NotificationObserver *observer;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ContentModesVC *vc = [[ContentModesVC alloc] init];
    vc.view.frame = (CGRect){0,0,self.view.frame.size};
    [self.view addSubview:vc.view];
    [self addChildViewController:vc];

}


@end
