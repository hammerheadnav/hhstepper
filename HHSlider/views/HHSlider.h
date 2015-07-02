//
// Created by Devarajan on 01/07/15.
// Copyright (c) 2015 Devarajan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIView.h>
#import "HHSliderControl.h"

@class Step;

@protocol HHSliderDelegate <NSObject>
- (void)didSelectStepWithLabel:(NSString *)label atIndex:(NSUInteger)index;
@end

@interface HHSlider : UIView <HHSliderControlDelegate>

@property (weak, nonatomic) id <HHSliderDelegate> delegate;
@property(strong, nonatomic) NSArray *labels;

- (instancetype)initWithFrame:(CGRect)frame labels:(NSArray *)labels;

- (void)setDelegate:(id <HHSliderDelegate>)delegate;
@end