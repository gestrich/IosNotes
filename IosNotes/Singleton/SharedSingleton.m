//
//  SharedSingleton.m
//  IosNotes
//
//  Created by William Gestrich on 4/9/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "SharedSingleton.h"


@implementation SharedSingleton

/*
 * Many ways exist to create shared instances but 
 * this uses GCD which is probably the easiest.
 * Singletons will survive the
 * life of the application
 */
+(SharedSingleton*)sharedSharedSingleton{
    static dispatch_once_t pred; //"predicate" used to test whether gcd block below executed or not
                                //static local variables are only assigned once but I don't think
                                //anything is assigned at this point, until dispatch_once is executed
    static SharedSingleton *instance = nil;
    dispatch_once(&pred,^{instance = [[self alloc] init];
        instance.timeCreated = [NSDate date];});
    return instance;
}

@end
