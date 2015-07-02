//
//  ViewController.m
//  HHSliderControl
//
//  Created by Devarajan on 01/07/15.
//  Copyright (c) 2015 Devarajan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    HHSlider *slider;
}

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect rect = CGRectMake(20, 20, self.view.frame.size.width - 40, 100);
    NSArray *labels = @[
            @"strict",
            @"okayish",
            @"default",
            @"linient",
            @"free"
    ];
    slider = [[HHSlider alloc] initWithFrame:rect labels:labels];
    [slider setDelegate:self];
    [self.view addSubview:slider];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)didSelectStepWithLabel:(NSString *)label atIndex:(NSUInteger)index {
    NSLog(@"Selected Step %@ at Index %d", label, index);
}

@end
