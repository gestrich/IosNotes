//
//  NotificationMaker.h
//  IosNotes
//
//  Created by William Gestrich on 4/8/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import <Foundation/Foundation.h>

//Always put extern const declarations outside interface/implementation sections of .h & .m files
//Also, const comes after the * or else not really a const
extern NSString * const NotificationsMakerDidAction;

@interface NotificationMaker : NSObject

@end
