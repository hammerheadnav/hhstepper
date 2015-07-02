# hhstepper
A simple stepper UI control for iOS

![alt tag](https://raw.githubusercontent.com/hammerheadnav/hhstepper/master/images/hhstepper.jpg)


###Usage
```objective-c
CGRect rect = CGRectMake(20, 20, self.view.frame.size.width - 40, 100);
NSArray *labels = @[@"one",@"two",@"three",@"four",@"five"];
HHStepper *stepper = [[HHStepper alloc] initWithFrame:rect labels:labels];
[stepper setDelegate:self];
[self.view addSubview:stepper];
```

###HHStepperDelegate
```objective-c
- (void)didSelectStepWithLabel:(NSString *)label atIndex:(NSUInteger)index {
    NSLog(@"Selected %@ at Index %d", label, index);
}
```
