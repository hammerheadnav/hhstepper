//
//  ViewController.m
//  HHSlider
//
//  Created by Devarajan on 01/07/15.
//  Copyright (c) 2015 Devarajan. All rights reserved.
//

#import "ViewController.h"
#import "HHSlider.h"

@interface ViewController () {
    HHSlider *slider;
}

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect rect = CGRectMake(20, 20, self.view.frame.size.width - 40, 50);
    slider = [[HHSlider alloc] initWithFrame:rect];
    [self.view addSubview:slider];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
