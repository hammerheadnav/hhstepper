//
//  ViewController.m
//  HHSlider
//
//  Created by Devarajan on 01/07/15.
//  Copyright (c) 2015 Devarajan. All rights reserved.
//

#import "ViewController.h"
#import "HHSlider.h"
#import "HHSliderWithTitle.h"

@interface ViewController () {
    HHSliderWithTitle *slider;
}

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect rect = CGRectMake(20, 20, self.view.frame.size.width - 40, 100);
    slider = [[HHSliderWithTitle alloc] initWithFrame:rect totalSteps:5 defaultStep:2];
    [slider setLabels:@[@"strict", @"okayish", @"default", @"linient", @"free"]];
    [self.view addSubview:slider];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
