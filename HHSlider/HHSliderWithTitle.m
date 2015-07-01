//
// Created by Devarajan on 01/07/15.
// Copyright (c) 2015 Devarajan. All rights reserved.
//

#import "HHSliderWithTitle.h"
#import "HHSlider.h"


@implementation HHSliderWithTitle {
    HHSlider *_slider;
    UIView *_labelContaniner;
}

- (instancetype)initWithFrame:(CGRect)frame totalSteps:(NSUInteger) numberOfSteps defaultStep:(NSUInteger) defaultStep {
    self = [super initWithFrame:frame];
    if (self) {
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        int margin = 20;
        CGRect rect = CGRectMake(margin, margin, self.frame.size.width - margin * 2, self.frame.size.height / 2);
        _slider = [[HHSlider alloc] initWithFrame:rect totalSteps:numberOfSteps defaultStep:defaultStep];
        _labelContaniner = [[UIView alloc] initWithFrame:CGRectMake(margin,( self.frame.size.height / 2), self.frame.size.width - margin * 2, self.frame.size.height / 2)];
        [self addSubview:_slider];
        [self addSubview:_labelContaniner];

    }
    return self;
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
    [label setCenter:[_slider positionOfStepAtIndex:i]];
    [label setText:_labels[i]];
    [label setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    [label setTextColor:[UIColor grayColor]];

    return label;
}


@end