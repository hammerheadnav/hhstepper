//
//  ViewController.m
//  HHStepperControl
//
//  Created by Devarajan on 01/07/15.
//  Copyright (c) 2015 Devarajan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    HHStepper *stepper;
}

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect rect = CGRectMake(20, 20, self.view.frame.size.width - 40, 100);
    NSArray *labels = @[
            @"one",
            @"two",
            @"three",
            @"four",
            @"five"
    ];
    stepper = [[HHStepper alloc] initWithFrame:rect labels:labels];
    [stepper setDelegate:self];
    [self.view addSubview:stepper];
}

- (void)didSelectStepWithLabel:(NSString *)label atIndex:(NSUInteger)index {
    NSLog(@"Selected Step %@ at Index %d", label,(int) index);
}

@end
