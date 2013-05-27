//
//  AssociativeReference.h
//  IosNotes
//
//  Created by William Gestrich on 4/10/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

/*
 * Description
 * Associative references allow you attach objects to any arbitrary object
 * using a key/value
 
 * These are great for categories where you can't have properties
 *
 */

#import <Foundation/Foundation.h>

@interface AssociativeReference : NSObject

@property (nonatomic, readwrite, strong) UIAlertView *alert;

-(void)showMessage;

@end
