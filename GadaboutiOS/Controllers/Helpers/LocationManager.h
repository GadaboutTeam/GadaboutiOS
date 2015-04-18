//
//  LocationController.h
//  GadaboutiOS
//
//  Created by Alex Bardasu on 30/01/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class LocationManager;

@protocol LocationControllerDelegate
- (void)permissionStatusChanged:(id)locationController;
@end

@interface LocationManager : NSObject<CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}

@property (nonatomic, assign)id delegate;

- (void)startUpdatingLocation;
- (BOOL)hasAskedForAuthorization;

@end