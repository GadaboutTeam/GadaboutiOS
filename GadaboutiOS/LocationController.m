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
    if (IS_OS_8_OR_LATER) {
        [self getAuthorization];
    }

    [locationManager startUpdatingLocation];
}


- (void)getAuthorization {
    NSLog(@"Requesting location tracking permission");
    NSUInteger authCode = [CLLocationManager authorizationStatus];
    if (authCode == kCLAuthorizationStatusNotDetermined && ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
        if ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
            [locationManager requestWhenInUseAuthorization];
        }
    }
}

@end