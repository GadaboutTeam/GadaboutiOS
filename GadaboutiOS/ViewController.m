//
//  ViewController.m
//  GadaboutiOS
//
//  Created by David Barsky on 1/30/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LocationController *locationController = [[LocationController alloc] init];
    [locationController startUpdatingLocation];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
