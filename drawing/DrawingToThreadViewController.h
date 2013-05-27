//
//  DrawingToThreadViewController.h
//  IosNotes
//
//  Created by William Gestrich on 5/9/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

/*
 * Description:
 * It is important to perform time consuming tasks
 * on a background thread to avoid blocking drawing/touches etc..
 * But you can't draw anything on completion within a background 
 * thread. Instead, draw on the main thread.
 *
 */

#import <UIKit/UIKit.h>

@interface DrawingToThreadViewController : UIViewController

@end
