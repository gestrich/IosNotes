//
//  UndoFeature.m
//  IosNotes
//
//  Created by William Gestrich on 4/7/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "UndoFeature.h"

@interface UndoFeature()

    
@property (nonatomic, readonly, strong) NSUndoManager *undoManager;

@end




@implementation UndoFeature

-(id)initWithString:(NSString*)aString{
    if(self = [super init]){
        //Create the undo manager and sets its first inverse operation to
        //be this operation
        _undoManager = [[NSUndoManager alloc] init];
        [[_undoManager prepareWithInvocationTarget:self] setString:aString];
        
        _string = aString;
    }
    return self;
}

-(void)setString:(NSString *)aString{
    if ( ! [aString isEqualToString:self.string]){
        //Add last action to the undo manager stack of NSInvocations
        [[self.undoManager prepareWithInvocationTarget:self] setString:_string];
        //Perform the action
        _string = aString;
    }
}

-(void)undo{
    [self.undoManager undo];
}


@end
