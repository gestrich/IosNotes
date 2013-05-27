//
//  PrimaryClass.h
//  IosNotes
//
//  Created by William Gestrich on 4/13/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

/*
 * Description:
 * This demonstrates limitations of categories.
 * You can access public properties/methods/ivars, but nothing private
 * You can't set instance variables (even associated with properties)
 * You can create methods/properties. If you need an iVars (like one associated
 * with property), use associative references.
 *
 *Test this class with something like this:
 
    PrimaryClass *theClass = [[PrimaryClass alloc] init];
    NSLog(@"Property Value: %@", theClass.categoryString );
    theClass.categoryString = @"new value";
    NSLog(@"Property Value: %@", theClass.categoryString );
 *
 */

#import <Foundation/Foundation.h>

@interface PrimaryClass : NSObject{
    NSString *publicIvar;
}

@property NSString *publicProperty;

-(void)publicMethod;

@end
