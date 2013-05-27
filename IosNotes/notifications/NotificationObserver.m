//
//  NotificationObserver.m
//  IosNotes
//
//  Created by William Gestrich on 4/8/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "NotificationObserver.h"
#import "NotificationMaker.h"

@interface NotificationObserver(){
    
}

@property (strong, readwrite) NotificationMaker *maker;

@end

@implementation NotificationObserver

-(id)init{
    self = [super init];
    _maker = [[NotificationMaker alloc] init];
    
    //Good to set notification in init and remove in dealloc
    //Set the object if you want to listen to specific object
    //If you have a ton of objects you are listening to, it is better
    //to set object to nil, which listens for all, then inspect the received
    //notification when you receive it. (better than registering to listen to a ton
    //of objects and having to unregister for each one when done)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(makerDidSomething:) name:NotificationsMakerDidAction object:_maker];
    
    return self;
}
-(void)makerDidSomething:(id)sender{
    NSLog(@"Notification received");
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
