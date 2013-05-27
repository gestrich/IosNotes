//
//  ArcFeatures.m
//  IosNotes
//
//  Created by William Gestrich on 4/11/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "ArcFeatures.h"

@interface ArcFeatures(){

    __strong NSString *strongString; //bumps retain count by one -- the default
    __unsafe_unretained NSString *unretainedString; //Doesn't increase retain count
                                                    //Doens't nil deallocated reference
                                                    //Probably use __weak instead

    __weak NSString *weakString;    //Available after ios 5
                                    //Doesn't increase retain count
                                    //nils deallocated references to avoid crash
                                    //when you access a deallocated pointer
}

@end





@implementation ArcFeatures
    
-(NSString*)autoreleasedVariable{
    
    __autoreleasing NSString *autoreleasedString; //used inside methods only
                                                //It is autoreleased
    
    return autoreleasedString;
    
}
    

/*
 * To use non-arc code, either turn it off for the whole project, 
 * or override a file in the Build Phases / Compile Sources by 
 * adding the flag -fno-objc-arc. The inverse can be done by 
 * using the -fobjc-arc flag, although I don't think I would ever
 * compile a whole project without arc
 *
 */
-(void)useNonArcCode{
    NSDictionary *dict = [NSDictionary dictionaryWithObject:@"test obj" forKey:@"test key"];
    
#if __has_feature(fno_objc_arc)
    [dict retain];
#endif
    
    NSLog(@"Dictionary is allocated: %@", dict);
   
//The has_feature compiler macro, can check if arc is enabled
//or not (for this file).
#if __has_feature(fno_objc_arc)
    [dict release];
#endif
    
}

@end
