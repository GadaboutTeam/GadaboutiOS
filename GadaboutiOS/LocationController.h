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

@interface LocationController : NSObject<CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}

- (void)startUpdatingLocation;

@end