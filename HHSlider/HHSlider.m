

#import "HHSlider.h"
#import "HHCycleLayer.h"
#import "HHSliderTrackLayer.h"
#import "HHSliderStepLayer.h"

@implementation HHSlider {
    HHSliderTrackLayer *_trackLayer;
    HHSliderStepLayer *_step0Layer;
    HHSliderStepLayer *_step1Layer;
    HHSliderStepLayer *_step2Layer;
    HHSliderStepLayer *_step3Layer;
    HHCycleLayer *_cycleLayer;

    int selectedStep;
    float stepWidth;
    float trackMargin;
    float trackLength;
    CGPoint _previousTouchPoint;

    BOOL animating;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _trackLayer = [HHSliderTrackLayer layer];
        _trackLayer.slider = self;
        [self.layer addSublayer:_trackLayer];

        _step0Layer = [HHSliderStepLayer layer];
        [self.layer addSublayer:_step0Layer];

        _step1Layer = [HHSliderStepLayer layer];
        [self.layer addSublayer:_step1Layer];

        _step2Layer = [HHSliderStepLayer layer];
        [self.layer addSublayer:_step2Layer];

        _step3Layer = [HHSliderStepLayer layer];
        [self.layer addSublayer:_step3Layer];

        _cycleLayer = [HHCycleLayer layer];
        _cycleLayer.slider = self;
        [self.layer addSublayer:_cycleLayer];

        [self setLayerFrames];
    }

    return self;
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    _previousTouchPoint = [touch locationInView:self];
    if(CGRectContainsPoint(_step0Layer.frame, _previousTouchPoint)){
        selectedStep = 0;
    } else if(CGRectContainsPoint(_step1Layer.frame, _previousTouchPoint)){
        selectedStep = 1;
    } else if(CGRectContainsPoint(_step2Layer.frame, _previousTouchPoint)){
        selectedStep = 2;
    } else if(CGRectContainsPoint(_step3Layer.frame, _previousTouchPoint)){
        selectedStep = 3;
    }

    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    return [super continueTrackingWithTouch:touch withEvent:event];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    if(!animating) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
        [animation setFromValue:[NSValue valueWithCGPoint:_cycleLayer.position]];
        float x = [self positionForStepIndex:selectedStep];

        [animation setToValue:[NSValue valueWithCGPoint:CGPointMake(x + (stepWidth / 2), _cycleLayer.position.y)]];
        [animation setDelegate:self];
        [animation setDuration:.5];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [animation setFillMode:kCAFillModeForwards];
        [animation setRemovedOnCompletion:NO];

        [_cycleLayer addAnimation:animation forKey:@"position"];
        animating = YES;
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    animating = NO;
    float x = [self positionForStepIndex:selectedStep];
    _cycleLayer.position = CGPointMake(x + (stepWidth / 2),_cycleLayer.position.y);
}


- (void)setLayerFrames {
    stepWidth = self.bounds.size.height / 2;

    trackMargin = 20;
    CGFloat trackHeight = self.bounds.size.height / 8;
    trackLength = (self.bounds.size.width - stepWidth) - trackMargin * 2;

    _trackLayer.frame = CGRectMake(stepWidth/2 + trackMargin, self.bounds.size.height / 2 - trackHeight / 2,  trackLength , trackHeight);
    CGRectInset(self.bounds, 0, self.bounds.size.height / 4);
    [_trackLayer setNeedsDisplay];


    CGFloat y = (self.bounds.size.height / 2) - stepWidth / 2;
    _step0Layer.frame = CGRectMake([self positionForStepIndex:0], y, stepWidth, stepWidth);
    [_step0Layer setNeedsDisplay];

    _step1Layer.frame = CGRectMake([self positionForStepIndex:1], y, stepWidth, stepWidth);
    [_step1Layer setNeedsDisplay];

    _step2Layer.frame = CGRectMake([self positionForStepIndex:2], y, stepWidth, stepWidth);
    [_step2Layer setNeedsDisplay];

    _step3Layer.frame = CGRectMake([self positionForStepIndex:3], y, stepWidth, stepWidth);
    [_step3Layer setNeedsDisplay];

    _cycleLayer.frame = CGRectMake([self positionForStepIndex:selectedStep], y, stepWidth, stepWidth);
    [_cycleLayer setNeedsDisplay];
}

- (float) positionForStepIndex: (int) index{
       float stepSpacing = trackLength / 3;
       return trackMargin + index * stepSpacing;
}


@end
