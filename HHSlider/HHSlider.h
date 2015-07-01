//
//  HHSlider.h
//  HHSlider
//
//  Created by Devarajan on 01/07/15.
//  Copyright (c) 2015 Devarajan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHSlider : UIControl

- (instancetype)initWithFrame:(CGRect)frame totalSteps:(NSUInteger)numberOfSteps defaultStep:(NSUInteger)defaultStep;
@end
