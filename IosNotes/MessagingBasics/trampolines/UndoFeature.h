//
//  UndoFeature.h
//  IosNotes
//
//  Created by William Gestrich on 4/7/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

/*
 * Description:
 *
 This is class is not a trampoline but NSUndoManager is. We create an instance of NSUndoManager
 which keeps a stack of NSInvocation objects (messages).
 It works in the following way:
 
 - You call prepareWithInvocationTarget: which records the argument (this class) as 
    the undo operation about to be established. The return value is an instance of NSUndoManager.
    I think it needs this so that it can create a message signature needed to create an NSInvocatin
    in the next step
 
 -You send a message to the return value -- NSUndoManager -- the undo operation. NSUndoManager
    doesn't respond to this message. This is why it is considered a trampoline.
    In forwardInvocation of NSUndoManager, it internally puts the invocation on a stack associated 
    with the object you sent prepareWithInvocationTarget.
 
 -When you call "undo" on NSUndoManager, it pops the NSInvocation off the stack and invokes it.
    This calls the original class.
 
 */
#import <Foundation/Foundation.h>

@interface UndoFeature : NSObject

@property (nonatomic, readwrite, strong) NSString *string;

-(id)initWithString:(NSString*)aString;
-(void)undo;
    
@end
