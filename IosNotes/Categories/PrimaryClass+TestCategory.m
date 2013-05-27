//
//  PrimaryClass+TestCategory.m
//  IosNotes
//
//  Created by William Gestrich on 4/13/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "PrimaryClass+TestCategory.h"
#import <objc/runtime.h>    

static char testStringKey;

@implementation PrimaryClass (TestCategory)



/*
 * Used when category is loaded into memory. This is good 
 * if you need to initialize anything.
 *
 */
+(void)load{

//    objc_setAssociatedObject(self, &testStringKey, @"Value initialized in load method", OBJC_ASSOCIATION_COPY); // however, it seems this won't work
}


-(void)doSomething{
    
    
    //[self privateMethod]; //won't work
    
    NSLog(@"Public iVar = %@", publicIvar );
    //NSLog(@"Private iVar = %@", privateIvar ); //wont work
   
    NSLog(@"Public property = %@", self.publicProperty);
    //NSLog(@"Private property = %@", self.privateProperty); //won't work
    
    
    
}

-(NSString*) categoryString{
    
    NSString *testString = objc_getAssociatedObject(self, &testStringKey);
    
    return testString;
    
}

-(void) setCategoryString:(NSString *)categoryString{
    
    objc_setAssociatedObject(self, &testStringKey, categoryString, OBJC_ASSOCIATION_COPY);
    
}


@end
