//
//  StrictSingleton.m
//  IosNotes
//
//  Created by William Gestrich on 4/9/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "StrictSingleton.h"

@implementation StrictSingleton

+(StrictSingleton*)sharedSingleton{
    static dispatch_once_t pred;
    static StrictSingleton *instance = nil;
    dispatch_once(&pred, ^{
        instance = [[self alloc] initSingleton];
    });
    
    return instance;
}


-(id)init{
    
    NSAssert(NO, @"Cannot create new instance of singleton");
    
    return nil;
}

//Real (private) initializer
//We made a private initializer because the regular init
//is public and can be called more than once. So we disable that one
// and use use this private one that is restricted to be called only
// once base on our sharedSingleton code.
-(id)initSingleton{
    if(self = [super init]){
            //initialization code
    }

    return self;

}


@end
