

#import "HHSliderControl.h"
#import "HHCycleLayer.h"
#import "HHSliderTrackLayer.h"
#import "HHSliderStepLayer.h"

@implementation HHSliderControl {
    HHSliderTrackLayer *_trackLayer;
    NSArray *_steps;
    HHCycleLayer *_cycleLayer;

    NSUInteger selectedStep;
    float stepWidth;
    float trackMargin;
    float trackLength;
    BOOL animating;
}

- (instancetype)initWithFrame:(CGRect)frame totalSteps:(NSUInteger) numberOfSteps defaultStep:(NSUInteger) defaultStep {
    self = [super initWithFrame:frame];
    if (self) {
        _trackLayer = [HHSliderTrackLayer layer];
        _trackLayer.slider = self;
        [self.layer addSublayer:_trackLayer];

        _steps = [self createSteps:numberOfSteps];
        selectedStep = defaultStep;

        _cycleLayer = [HHCycleLayer layer];
        _cycleLayer.slider = self;
        [self.layer addSublayer:_cycleLayer];

        [self setLayerFrames];
    }

    return self;
}

- (CGPoint)positionOfStepAtIndex:(NSUInteger)index {
    HHSliderStepLayer *step = _steps[index];
    return step.position;
}


- (NSArray *)createSteps:(NSUInteger)numberOfSteps {
    NSMutableArray *steps = [NSMutableArray new];
    for(int i =0 ;i < numberOfSteps; i++){
        HHSliderStepLayer *step = [HHSliderStepLayer layer];
        [self.layer addSublayer:step];
        [steps addObject:step];
    }
    return  steps;
}


- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchPoint = [touch locationInView:self];
    for(NSUInteger i=0; i<_steps.count; i++){
        HHSliderStepLayer *step = _steps[i];
        if(CGRectContainsPoint(step.frame, touchPoint)){
            if(selectedStep == i) {
                return NO;
            } else {
                selectedStep = i;
                break;
            }
        }
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

        if([_delegate respondsToSelector:@selector(didSelectStepAtIndex:)]){
            [_delegate didSelectStepAtIndex:selectedStep];
        }
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
    for(NSUInteger i=0; i<_steps.count; i++){
        HHSliderStepLayer *step = _steps[i];
        step.frame = CGRectMake([self positionForStepIndex:i], y, stepWidth, stepWidth);
        [step setNeedsDisplay];
    }
    _cycleLayer.frame = CGRectMake([self positionForStepIndex:selectedStep], y, stepWidth, stepWidth);
    [_cycleLayer setNeedsDisplay];
}

- (float) positionForStepIndex: (NSUInteger) index{
       float stepSpacing = trackLength / (_steps.count - 1);
       return trackMargin + index * stepSpacing;
}


@end
