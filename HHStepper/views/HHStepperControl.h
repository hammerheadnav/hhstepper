//
//  HHStepperControl.h
//  HHStepperControl
//
//  Created by Devarajan on 01/07/15.
//  Copyright (c) 2015 Devarajan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHStepLayer;
@protocol HHStepperDelegate;

@protocol HHSliderControlDelegate <NSObject>
- (void) didSelectStepAtIndex:(NSUInteger) index;
@end

@interface HHStepperControl : UIControl

@property (weak, nonatomic) id <HHSliderControlDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame totalSteps:(NSUInteger)numberOfSteps defaultStep:(NSUInteger)defaultStep;

- (CGPoint) positionOfStepAtIndex:(NSUInteger) index;
@end
