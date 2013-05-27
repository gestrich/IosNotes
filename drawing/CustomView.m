//
//  CustomView.m
//  IosNotes
//
//  Created by William Gestrich on 4/29/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "CustomView.h"

@interface CustomView(){
}

@end

@implementation CustomView



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    
    //Will cause drawRect to be called after 5 seconds
    //[self performSelector:@selector(setNeedsDisplay) withObject:self afterDelay:5.0];
    
    
    //Will cause layoutSubview to be called after 5 seconds
    //[self performSelector:@selector(setNeedsLayout) withObject:self afterDelay:10.0];
    return self;
}


//Invoked with setNeedsLayout
    //Doesn't cause a redraw -- uses cached bitmaps on in GPU
    //that can be cheaply moved/transformed
-(void)layoutSubviews{
    [super layoutSubviews];
}


//Invoked with setNeedsDisplay
    //Typically, drawRect doesn't do anything with the subviews or layers
//A graphics context (a view graphics context) is provided
//by the system before this is called
    //Includes stroke color, fill color, text color, font, transform & more
- (void)drawRect:(CGRect)rect
{
    //"Painters" model is used -- order determines what shows on top
    
    //The "canvas" is lost between calls to drawRect
    //Everything that was there is erased
   
    
    //[self drawRectangle];
   // [self drawBezierCurve];
    [self drawBezierCurveWithAffineMatrix];
    //[self drawLine:UIGraphicsGetCurrentContext()];
    //[self pixelAlignment:UIGraphicsGetCurrentContext()];
}


/* 
 Draw line using Core Graphics
 This uses a path
 */
-(void)drawLine:(CGContextRef)context{
    
    CGContextSetLineWidth(context, 2.);
    CGContextMoveToPoint(context, 10., 100.0);
    CGContextAddLineToPoint(context, 200., 100.);
    CGContextStrokePath(context);
}



/*
 * Background:
 * This demonstrates issue with pixel alignment.
 * When drawing a line, the line is centered on the
 * coordinate you give it. This can cause fractional pixels
 * to occupy the space you want your line. So anti-aliasing
 * will occur which blends the fractional pixel with the 
 * background color -- making it look blurry. 
 
 * This can occur in the following situations:
 *  -A non even line width is defined (1,3, 5...)
 *  -A coordinate that is given that doesn't fall on pixel boundary.
 * This is not really a problem for retina display since all widths are
 * essentially even (1 point is 2 pixels width). Its also only a problem
 * for horizontal/vertical lines since other lines have to use anti-alias
 
 * Solution to issue:
 *  -If line width is non-even, give coordinate point is .5 increments
 *  (ex: horizontal line should start at y = 10.5 rather than y = 10.
 */
-(void)pixelAlignment:(CGContextRef)context{

    //Blurry line on non-retina display
    CGContextSetLineWidth(context, 3.);
    CGContextMoveToPoint(context, 10., 100.0);
    CGContextAddLineToPoint(context, 200., 100.);
    CGContextStrokePath(context);

    //Offset by .5 so that it isn't blurry
    CGContextSetLineWidth(context, 3.);
    CGContextMoveToPoint(context, 10., 105.5);
    CGContextAddLineToPoint(context, 200., 105.5);
    CGContextStrokePath(context);
}

-(void)drawRectangle{
    
    //UIKit offers limited drawing functions
    // Draw a Rectangle
    [[UIColor redColor] setFill];
    UIRectFill((CGRect){10,10,10,100}); //notice not even obj-c code -- but is UIKit
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

/*Convenient function for performing scaling and translation using Core Graphics
 sx = x scale factor
 sy = y scale factor
 dx = x translation
 dy = y translation
 */
static inline CGAffineTransform CGAffineTransformMakeScaleTranslate(CGFloat sx, CGFloat sy,
                                                                    CGFloat dx, CGFloat dy){
    //The point of making a function inline is to hint to the compiler that it is worth making some form of extra effort to call the function faster than it would otherwise - generally by substituting the code of the function into its caller.
    return CGAffineTransformMake(sx, 0.f, 0.f, sy, dx, dy); //2nd/3rd pos always 0
};


/*
 * Set postition and size of curve using affine matrix
 * This makes coding more simple and flexible
 * It is also faster
 * The matrix stuff at the bottom replaces the top code of drawBezierCurve
 */
-(void)drawBezierCurveWithAffineMatrix{
    CGSize size = self.bounds.size;
    CGFloat margin = 10;
    
    [[UIColor redColor] set];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(0, -1) radius:1 startAngle:-M_PI endAngle:0 clockwise:YES];
    [path addArcWithCenter:CGPointMake(1, 0) radius:1 startAngle:-M_PI_2 endAngle:M_PI_2  clockwise:YES];
    [path addArcWithCenter:CGPointMake(0, 1) radius:1 startAngle:0 endAngle:M_PI  clockwise:YES];
    [path addArcWithCenter:CGPointMake(-1, 0) radius:1 startAngle:M_PI_2 endAngle:-M_PI_2  clockwise:YES];
    [path closePath];
    
    CGFloat scale = floorf( (MIN(size.height, size.width)- margin) / 4);
    
    CGAffineTransform transform;
    
    //Call custom function to get matrix
    transform = CGAffineTransformMakeScaleTranslate(scale, scale, size.width/2, size.height/2);
    
    //You then call applyTransform to apply to the path.
    //You could also apply a transformation to the entire view
    //by calling something like self.tranform = transform;
    [path applyTransform:transform];
    [path fill];
}
@end
