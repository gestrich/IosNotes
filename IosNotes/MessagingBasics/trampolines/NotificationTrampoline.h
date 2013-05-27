//
//  NotificationTrampoline.h
//  IosNotes
//
//  Created by William Gestrich on 4/5/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//


/*
 * Description:
 *
 A trampoline "bounces" a message from one object to another.
 Useful for notifications, moving messages to another thread, caching results, or coalescing messages
 Basically, send the message to the trampoline (make it type id), 
 instead of the intended object. The trampoline can
 perform these intermediate processing before sending to intended object(s)
 *
 This class is the "trampoline" It bounces incoming messages to its observors
 The trampoline is implemented using forwardInvocation:, a method called by the
 runtime when an object does not respond to a selector (this object). I believe 
 forwardInvovation was used so that the class be generic -- it can respond to messages
 that are not defined in it. To use forwardInvocation, you also have to implement 
 methodSignatureForSelector: which will be called when objc creates the invocation object for
 forwardInvocation.
 *
 These "unknown" messages  are checked for exitence in the protocol this class is initialized with
 Then the messages are forwarded to all the observors of the class that respond to the message
 *
 So the benefit of using this is you have a manager that can distribute one arbitrary
 message to many observers, as long as the observers conform to the protocol this class
 was initialized with. The book says that this is faster and easier than NSNotications when
 you have a lot of notifications
 *
 *
 *
 *
 */


#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@protocol test_array_protocol <NSObject>
@optional
-(void)addObject:(id)obj;

@end

@interface NotificationTrampoline : NSObject


-(id) initWithProtocol:(Protocol *)protocol
              observers:(NSSet*)observers;

-(void)addObserver:(id)observer;
-(void)removeObserver:(id)observer;


@end
