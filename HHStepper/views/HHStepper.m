//
// Created by Devarajan on 01/07/15.
// Copyright (c) 2015 Devarajan. All rights reserved.
//

#import "HHStepper.h"


@implementation HHStepper {
    HHStepperControl *_sliderControl;
    UIView *_labelContaniner;
}

- (instancetype)initWithFrame:(CGRect)frame labels:(NSArray *)labels {
    self = [super initWithFrame:frame];
    if (self) {
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self setFrames:labels];

        [self setLabels:labels];

        [self addSubview:_sliderControl];
        [self addSubview:_labelContaniner];
    }
    return self;
}

- (void)setFrames:(NSArray *)labels {
    int margin = 20;
    CGRect rect = CGRectMake(margin, margin, self.frame.size.width - margin * 2, self.frame.size.height / 2);
    _sliderControl = [[HHStepperControl alloc] initWithFrame:rect totalSteps:labels.count defaultStep:0];
    _sliderControl.delegate = self;
    _labelContaniner = [[UIView alloc] initWithFrame:CGRectMake(margin,( self.frame.size.height / 2), self.frame.size.width - margin * 2, self.frame.size.height / 2)];
}

- (void)reload {
    if(_labels.count > 0){
        [[_labelContaniner subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        for(NSUInteger i=0; i< _labels.count;i++) {
            UILabel *label = [self createLabel:i];
            [_labelContaniner addSubview:label];
        }
    }
}

- (void)setLabels:(NSArray *)labels {
    _labels = labels;
    [self reload];
}

- (UILabel *)createLabel:(NSUInteger) i {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setCenter:[_sliderControl positionOfStepAtIndex:i]];
    [label setText:_labels[i]];
    [label setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    [label setTextColor:[UIColor grayColor]];
    return label;
}

- (void)didSelectStepAtIndex:(NSUInteger)index {
    if([_delegate respondsToSelector:@selector(didSelectStepWithLabel:atIndex:)]){
        [_delegate didSelectStepWithLabel:_labels[index] atIndex:index];
    }
}


@end