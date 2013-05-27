//
//  CollectionVcViewController.h
//  IosNotes
//
//  Created by William Gestrich on 4/16/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

/*Description
 * Get start with Colleciton Views -- The following can be added
 * to the main view controller of this app to load this controller inside
 * with the collection views
 */

/*
 UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
 layout.footerReferenceSize = (CGSize){320, 20};
 CollectionVcViewController *coll = [[CollectionVcViewController alloc] initWithCollectionViewLayout:layout];
 coll.view.frame = (CGRect){0,0, 320, self.view.frame.size.height};
 [self.view addSubview:coll.view];
 [self addChildViewController:coll];
 */

#import <UIKit/UIKit.h>

@interface CollectionVcViewController : UICollectionViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@end
