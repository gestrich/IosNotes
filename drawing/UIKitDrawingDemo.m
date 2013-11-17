//
//  UIKitDrawingDemo.m
//  IosNotes
//
//  Created by William Gestrich on 5/31/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "UIKitDrawingDemo.h"

@implementation UIKitDrawingDemo

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self drawImage];
    [self drawRectangle];
    [self drawBezierCurve];
    [self drawFont];
}

-(void)drawRectangle{
    
    //UIKit offers limited drawing functions
    // Draw a Rectangle
    [[UIColor redColor] setFill];
    UIRectFill((CGRect){10,10,10,100}); //notice not even obj-c code -- but is UIKit
}

- (void)drawImage
{
    UIImage *image = [UIImage imageNamed:@"img045.jpg"];
    [image drawAtPoint:(CGPoint){0,0}];
}


- (void)drawFont
{
    UIFont *font = [UIFont systemFontOfSize:12];
    
    NSString * testString = @"Drawing with NSString";
    [testString drawAtPoint:(CGPoint){50,50} withFont:font];
}
/* Draw a flower
 using a bezier path.
 Bezier paths are a UIKit drawing mechanism that can draw
 arcs, lines, rectangles & ovals
 */
-(void)drawBezierCurve{
    CGSize size = self.bounds.size;
    CGFloat margin = 10; //margins are 5,5,5,5
    
    //Radius of each arc will be 1/4 of height or width, whichever is smaller
    //rint is for rounding to nearest integer
    CGFloat radius = rint(MIN(size.height - margin,
                              size.width - margin) / 4);
    
    
    //This section calculates where to begin the flower (upper left corner of flower)
    CGFloat xOffset, yOffset;
    //If view is perfect square, offset will be 0
    //If view is wider than tall, offset will be negative
    //If view is taller than wide, offset will be positive
    CGFloat offset = rint((size.height - size.width) / 2);
    if (offset > 0) {
        //View taller than wide
        xOffset = rint(margin / 2); // x offset will be all the way to left
        yOffset = offset; // y offset will be extra height divided by 2 (so centered)
    }else {
        //View wider than tall -- same logic as above -- only reversed
        xOffset = -offset;
        yOffset = rintf(margin / 2);
    }
    
    //Set the fill/stroke for drawing -- seems to always be case when drawing
    [[UIColor redColor] setFill];
    [[UIColor greenColor] setStroke];
    
    //Create the Bezier path -- just mathematical coordinates for drawing
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //Top circle
    
    [path addArcWithCenter:CGPointMake(radius *2 + xOffset,
                                       radius + yOffset)
                    radius:radius
                startAngle:-M_PI
                  endAngle:0
                 clockwise:YES];
    
    //Right circle
    [path addArcWithCenter:CGPointMake(radius *3 + xOffset,
                                       radius *2 + yOffset)
                    radius:radius
                startAngle:-M_PI_2
                  endAngle:M_PI_2
                 clockwise:YES];
    
    //Bottom circle
    [path addArcWithCenter:CGPointMake(radius *2 + xOffset,
                                       radius *3 + yOffset)
                    radius:radius
                startAngle:0
                  endAngle:M_PI
                 clockwise:YES];
    
    //Left circle
    [path addArcWithCenter:CGPointMake(radius + xOffset,
                                       radius * 2 + yOffset)
                    radius:radius
                startAngle:M_PI_2
                  endAngle:-M_PI_2
                 clockwise:YES];
    
    [path closePath];
    
    //Nothing is drawn until you call fill and/or stroke on the Bezier path
    [path stroke];
    [path fill];
    
}


@end
