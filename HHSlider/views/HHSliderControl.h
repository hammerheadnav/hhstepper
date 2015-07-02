//
//  HHSliderControl.h
//  HHSliderControl
//
//  Created by Devarajan on 01/07/15.
//  Copyright (c) 2015 Devarajan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHSliderStepLayer;
@protocol HHSliderDelegate;

@protocol HHSliderControlDelegate <NSObject>
- (void) didSelectStepAtIndex:(NSUInteger) index;
@end

@interface HHSliderControl : UIControl

@property (weak, nonatomic) id <HHSliderControlDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame totalSteps:(NSUInteger)numberOfSteps defaultStep:(NSUInteger)defaultStep;

- (CGPoint) positionOfStepAtIndex:(NSUInteger) index;
@end
