//
//  CollectionViewCell.m
//  IosNotes
//
//  Created by William Gestrich on 4/16/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.clipsToBounds = YES;
        
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:1.0];
    }
    return self;
}

-(UIView*)contentView{
    UIView *view = [super contentView];
    [view addSubview:self.imageView];
    return view;
    
}

-(UIImageView*)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc] initWithFrame:(CGRect){0,0,self.frame.size}];
    }
    _imageView.clipsToBounds=YES;
    [_imageView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    return _imageView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
