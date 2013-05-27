//
//  NotificationMaker.m
//  IosNotes
//
//  Created by William Gestrich on 4/8/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "NotificationMaker.h"

NSString * const NotificationsMakerDidAction = @"NotificationsMakerDidAction";

@interface NotificationMaker(){
}

@end

@implementation NotificationMaker{
    
}


-(id)init{
    
    self = [super init];
    
    [self performSelector:@selector(postTestNotification) withObject:self afterDelay:2.0f];
    return self;
}

-(void)postTestNotification{
   
    //If you send "nil" instead of self, the notifications won't be registered with this object
   [[NSNotificationCenter defaultCenter] postNotificationName:NotificationsMakerDidAction object:self];
    
}
@end



