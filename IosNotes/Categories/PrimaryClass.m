//
//  PrimaryClass.m
//  IosNotes
//
//  Created by William Gestrich on 4/13/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "PrimaryClass.h"

@interface PrimaryClass(){
    
    NSString *privateIvar;
}

@property NSString *privateProperty;

-(NSString*)privateMethod;
    
@end

@implementation PrimaryClass{
    NSString *privateIvar;
}


-(void)publicMethod{
    
        NSLog(@"Public method result");
}


-(NSString*)privateMethod{
    
        return @"Private method result";
}
@end
