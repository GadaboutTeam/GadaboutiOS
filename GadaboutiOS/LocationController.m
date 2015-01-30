//
//  LocationController.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 30/01/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "LocationController.h"

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

    }
    return self;
}

- (void)dealloc {
    
}

@end