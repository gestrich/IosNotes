//
//  SharedSingleton.h
//  IosNotes
//
//  Created by William Gestrich on 4/9/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedSingleton : NSObject

@property (nonatomic, readwrite, strong) NSDate *timeCreated;

+(SharedSingleton*)sharedSharedSingleton;

@end
