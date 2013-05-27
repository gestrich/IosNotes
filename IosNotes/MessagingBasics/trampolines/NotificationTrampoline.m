//
//  NotificationTrampoline.m
//  IosNotes
//
//  Created by William Gestrich on 4/5/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "NotificationTrampoline.h"

@interface NotificationTrampoline()
    
@property Protocol *protocol;
@property NSMutableSet *observers;

@end


@implementation NotificationTrampoline

-(id)initWithProtocol:(Protocol *)protocol observers:(NSSet *)observers{
    if (self = [super init]){
        
        _protocol = protocol;
        _observers = [observers mutableCopy];
        
    }
    
    return self;
}

-(void)addObserver:(id)observer{
    NSAssert([observer conformsToProtocol:self.protocol],
             @"Observer must conform to protocol");
    [self.observers addObject:observer];
}

-(void)removeObserver:(id)observer{
    [self.observers removeObject:observer];
}

/*
 *
 Called by obj-c, after it is found this object does not repond to 
 the unknown selector. This is used by obj-c to create the invocation
 object that is passed to forwardInvocation
 *
 */
-(NSMethodSignature*)methodSignatureForSelector:(SEL)aSelector{
    
   // Check if the trampoline itself has the method signature
    NSMethodSignature *result = [super methodSignatureForSelector:aSelector];
    if(result){
        return result;
    }
   
    // Now the real work
    //Look for a "required" method of the protocol
    struct objc_method_description desc = protocol_getMethodDescription(self.protocol, aSelector, YES, YES);
    
    if (desc.name == NULL){
        //Couldn't find it, maybe its optional
        desc = protocol_getMethodDescription(self.protocol, aSelector, NO, YES);
    }
    
    if (desc.name == NULL){
        //Couldn't find it. Raise NSInvalidArgumentException
        [self doesNotRecognizeSelector:aSelector];
        return nil;
    }
    
    return [NSMethodSignature signatureWithObjCTypes:desc.types];
}

-(void)forwardInvocation:(NSInvocation *)anInvocation{
    SEL selector = [anInvocation selector];
    for (id responder in self.observers){
        if ([responder respondsToSelector:selector]){
            [anInvocation setTarget:responder];
            [anInvocation invoke]; // the SEL and signature were already created before this was called
        }
    }
    
}

@end
