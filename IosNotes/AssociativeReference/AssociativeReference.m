//
//  AssociativeReference.m
//  IosNotes
//
//  Created by William Gestrich on 4/10/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "AssociativeReference.h"
#import <objc/runtime.h>

@implementation AssociativeReference

static char messageKey; //Use an assigned static char as all you need is an address (the key)

-(id)init{
    if(self = [super init]){
        
        _alert = [[UIAlertView alloc] initWithFrame:(CGRect){0,0,100,100}];
        //You manually set the memory managment:
        //OBJC_ASSOCIATION_COPY
        //OBJC_ASSOCIATION_RETAIN
        //OBJC_ASSOCIATION_ASSIGN
        objc_setAssociatedObject(_alert, &messageKey, @"This is the message", OBJC_ASSOCIATION_COPY);
        
    }
    
    return self;
}


-(void)showMessage{
    self.alert.message = objc_getAssociatedObject(self.alert, &messageKey);
    [self.alert show];
}

@end
