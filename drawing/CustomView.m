//
//  CustomView.m
//  IosNotes
//
//  Created by William Gestrich on 4/29/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "CustomView.h"

const CGFloat kXScale = 5.0;
const CGFloat kYScale = 100.0;

@interface CustomView()
@property NSMutableArray *values;
@end


@implementation CustomView{
    dispatch_source_t _timer;
}



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

    //Used by drawGraph
    //Creates timer to call updateValues
    //which will update array of values to draw
    
    [self setupTimer];
    return self;
}

-(void)dealloc{
    dispatch_source_cancel(_timer);
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
    //[self drawBezierCurve];
    //[self drawBezierCurveWithAffineMatrix];
    //[self drawLine:UIGraphicsGetCurrentContext()];
    //[self pixelAlignment:UIGraphicsGetCurrentContext()];
   // [self drawGraph];
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

/*
 * Timer used to animate graph
 */
-(void)setupTimer{
    _values = [NSMutableArray array];
    
    __weak id weakSelf = self;
    double delayInSeconds = 0.25;
    //Monitor low-level events -- in this case timer
    _timer =
    dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,
                           dispatch_get_main_queue());
    dispatch_source_set_timer(
                              _timer, dispatch_walltime(NULL, 0),
                              (unsigned)(delayInSeconds * NSEC_PER_SEC), 0);
    dispatch_source_set_event_handler(_timer, ^{
        [weakSelf updateValues];
    });
    //Resume the invocation of block objects on a dispatch object
    dispatch_resume(_timer);
    
    
    
}


/*Used by draw graph
 *create array of values
 * to draw
 */
- (void)updateValues {
    double nextValue = sin(CFAbsoluteTimeGetCurrent())
    + ((double)rand()/(double)RAND_MAX);
    [self.values addObject:
     [NSNumber numberWithDouble:nextValue]];
    CGSize size = self.bounds.size;
    CGFloat maxDimension = MAX(size.height, size.width);
    NSUInteger maxValues =
    (NSUInteger)floorl(maxDimension / kXScale);
    
    if ([self.values count] > maxValues) {
        [self.values removeObjectsInRange:
         NSMakeRange(0, [self.values count] - maxValues)];
    }
   
    //Notify drawing needs done
    [self setNeedsDisplay];
}

-(void)drawGraph{
    
    if ([self.values count] == 0) {
        return;
    }
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ctx,
                                     [[UIColor redColor] CGColor]);
    
    //Set style for connected lines in graphics context
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextSetLineWidth(ctx, 5);
   
    //Start the new path
    //Mutable path required to be used with
    // CGPathAddLineToPoint
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGFloat yOffset = self.bounds.size.height / 2;
    CGAffineTransform transform =
    CGAffineTransformMakeScaleTranslate(kXScale, kYScale,
                                        0, yOffset);
    
    CGFloat y = [[self.values objectAtIndex:0] floatValue];
    CGPathMoveToPoint(path, &transform, 0, y);

    //Gets the y for each x and adds
    //to path of points to draw
    for (NSUInteger x = 1; x < [self.values count]; ++x) {
        y = [[self.values objectAtIndex:x] floatValue];
        CGPathAddLineToPoint(path, &transform, x, y);
    }
    
    CGContextAddPath(ctx, path);
    CGPathRelease(path);
    CGContextStrokePath(ctx); 
    
}

@end
