//
// Created by Devarajan on 01/07/15.
// Copyright (c) 2015 Devarajan. All rights reserved.
//

#import "HHCycleLayer.h"
#import "HHSliderControl.h"


@implementation HHCycleLayer {

}

- (void)drawInContext:(CGContextRef)ctx {
    CGRect knobFrame = CGRectInset(self.bounds, 7, 7);
    UIBezierPath *knobPath = [UIBezierPath bezierPathWithRoundedRect:knobFrame
                                                        cornerRadius: (float) (knobFrame.size.height * 1.0 / 2.0)];

    // 1) fill - with a subtle shadow
    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 1), 1.0, [UIColor grayColor].CGColor);
    CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:0.0 green:0.45 blue:0.94 alpha:1.0].CGColor);
    CGContextAddPath(ctx, knobPath.CGPath);
    CGContextFillPath(ctx);

    // 2) outline
    CGContextSetStrokeColorWithColor(ctx, [UIColor grayColor].CGColor);
    CGContextSetLineWidth(ctx, 0.5);
    CGContextAddPath(ctx, knobPath.CGPath);
    CGContextStrokePath(ctx);


    // 3) inner gradient
    CGRect rect = CGRectInset(knobFrame, 2.0, 2.0);
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                        cornerRadius:(float)(rect.size.height * 6.0 / 2.0)];

    CGGradientRef myGradient;
    CGColorSpaceRef myColorspace;
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = { 0.0, 0.0, 0.0 , 0.15,  // Start color
            0.0, 0.0, 0.0, 0.05 }; // End color

    myColorspace = CGColorSpaceCreateDeviceRGB();
    myGradient = CGGradientCreateWithColorComponents (myColorspace, components,
            locations, num_locations);

    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));

    CGContextSaveGState(ctx);
    CGContextAddPath(ctx, clipPath.CGPath);
    CGContextClip(ctx);
    CGContextDrawLinearGradient(ctx, myGradient, startPoint, endPoint, 0);

    CGGradientRelease(myGradient);
    CGColorSpaceRelease(myColorspace);
    CGContextRestoreGState(ctx);
}


@end