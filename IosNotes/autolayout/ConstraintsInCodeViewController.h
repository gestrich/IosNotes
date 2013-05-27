//
//  ConstraintsInCodeViewController.h
//  IosNotes
//
//  Created by William Gestrich on 4/25/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

/*
* Description
* 
 -Demonstrates creates constraints in code using NSLayoutConstraint
 -Demonstrates using Visual Format Language syntax in NSLayoutConstraint
 -You should always "add" the constraint to the view the incorporates all
 the views in the constraint.
    -Example: Constraint involving superview and childview
        -Add the constraint to the superview
    -Example: Constraint involving to sibling views
        -Add the constraint to the superview
    -Example: Constraint involving just one view (for instance, setting size)
        -Add constraint to just that view (the one whose size is being set)
 
 */

#import <UIKit/UIKit.h>

@interface ConstraintsInCodeViewController : UIViewController

@end
