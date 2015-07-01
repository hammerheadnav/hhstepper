//
// Created by Devarajan on 01/07/15.
// Copyright (c) 2015 Devarajan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIView.h>


@interface HHSliderWithTitle : UIView
    @property (strong, nonatomic) NSArray *labels;
- (instancetype)initWithFrame:(CGRect)frame totalSteps:(NSUInteger)numberOfSteps defaultStep:(NSUInteger)defaultStep;
@end