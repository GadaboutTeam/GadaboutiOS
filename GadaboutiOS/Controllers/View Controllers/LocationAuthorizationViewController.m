//
//  LocationAuthorizationViewController.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 03/02/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "LocationAuthorizationViewController.h"


@interface LocationAuthorizationViewController ()

@end

@implementation LocationAuthorizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    locationController = [[LocationManager alloc] init];
    locationController.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)requestAuthorization:(id)sender {
    [locationController startUpdatingLocation];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

- (void)permissionStatusChanged:(id)locationController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
