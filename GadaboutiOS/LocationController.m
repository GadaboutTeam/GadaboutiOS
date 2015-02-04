//
//  LocationController.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 30/01/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "LocationController.h"

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface LocationController()

@end

@implementation LocationController
@synthesize delegate;

#pragma mark Singleton Methods

+ (id)sharedLocationController {
    static LocationController *locationController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locationController = [[self alloc] init];
    });

    return locationController;
}

- (id)init {
    if (self = [super init]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;

        NSLog(@"Location Manager initialized");
    }
    return self;
}

- (void)dealloc {

}

#pragma mark LocationManager Methods

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Location Manager Error: %@",error.description);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *currentLocation = [locations lastObject];

    if (currentLocation != nil) {
        NSLog(@"Current Location: lat: %.8f long: %.8f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    } else {
        NSLog(@"Current location is nil. Something is wrong.");
    }
}

- (void)startUpdatingLocation {
    [self getAuthorization];
}

- (void)stopUpdatingLocation {
    [locationManager stopUpdatingLocation];
    NSLog(@"The location controller stopped updating the location");
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [locationManager startUpdatingLocation];
            [delegate permissionStatusChanged:self];
            break;
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
            [delegate permissionStatusChanged:self];
            break;
        default:
            NSLog(@"The user did not grant the app location permission");
            break;
    }
}

- (void)getAuthorization {
    if(IS_OS_8_OR_LATER) {
        NSUInteger authCode = [CLLocationManager authorizationStatus];
        NSLog(@"Requesting location tracking permission; Auth status: %lu", (unsigned long)authCode);
        if ((unsigned long)authCode == kCLAuthorizationStatusNotDetermined && [locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [locationManager requestWhenInUseAuthorization];
        }
    }
}

- (BOOL)hasAskedForAuthorization {
    if ((unsigned long)[CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        return false;
    } else {
        return true;
    }
}

@end