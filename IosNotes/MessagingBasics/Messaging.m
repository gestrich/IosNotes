//
//  Messaging.m
//  IosNotes
//
//  Created by William Gestrich on 4/5/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "Messaging.h"

@implementation Messaging

/*
 * Purpose: Demonstrates messages wrapped in
 * objects -- NSInvocations
 */
-(void)sendInvocationMessage{
    
    
    //make the selector
    //the selector is just the string of the signature
    SEL sel = @selector(myMethod:);
    NSMethodSignature *signature;
    BOOL signatureByHand = NO;
    
    if(signatureByHand){
        
        //Make the method signature
        //The signature specifies the return type and arguments
        //You usually do not have to do this by hand but this a good example.
        //The symbol "@" represents an obj-c object, an id
        //All objective C objects are represented with "@"
        // ":" is the selector
        //The first encoded string is the return value, it is followed by the first argument
        //The first argument "@" is for the target (they call "self" for some reason. This is always the first arg
        // The second argument ":" is for the selector which is always a parameter
        //Then follows the optional arguments
        
        
        //@encode(type) returns the type -- in this case, "@"
        //You can use this in lieu of looking up the type encoding
        char encodedTypes[100];
        strcpy(encodedTypes, "@@:");
        strcat(encodedTypes, @encode(id));
        
        signature = [NSMethodSignature signatureWithObjCTypes:encodedTypes];
        
    }else{
        //This is the usual way you get the signature
        
        //You can ask an instance for a signature
        signature = [self methodSignatureForSelector:sel];
        
        //Asking classes for signatures is different
        //Ask a class for its instance method signature
        // signature = [[self class] instanceMethodSignatureForSelector:sel];
        
        //Ask a class for its class method signature
        // signature = [[self class] methodSignatureForSelector:sel];
        
    }
    
    //Create the invocation
    //The key here is you must set the signature, target and selector
    //If you want to retain your arguments, see "retainArguments" method in apple docs
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:sel];
    NSArray *array = [NSArray arrayWithObject:@"Single Object"];
    [invocation setArgument:&array atIndex:2];
    
    //Use the invocation
    [invocation invoke];
    
    //Check the return value
    NSString * returnValue;
    [invocation getReturnValue:&returnValue];
    NSLog(@"%@", returnValue);
}


-(NSString*)myMethod:(id)sender{
    NSLog(@"My Method called with argument %@", [sender objectAtIndex:0] );
    return @"Returned String";
}

@end
