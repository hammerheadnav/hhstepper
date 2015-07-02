//
// Created by Devarajan on 01/07/15.
// Copyright (c) 2015 Devarajan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIView.h>
#import "HHStepperControl.h"

@class Step;

@protocol HHStepperDelegate <NSObject>
- (void)didSelectStepWithLabel:(NSString *)label atIndex:(NSUInteger)index;
@end

@interface HHStepper : UIView <HHSliderControlDelegate>

@property (weak, nonatomic) id <HHStepperDelegate> delegate;
@property(strong, nonatomic) NSArray *labels;

- (instancetype)initWithFrame:(CGRect)frame labels:(NSArray *)labels;

- (void)setDelegate:(id <HHStepperDelegate>)delegate;
@end