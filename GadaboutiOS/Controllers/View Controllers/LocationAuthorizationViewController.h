//
//  LocationAuthorizationViewController.h
//  GadaboutiOS
//
//  Created by Alex Bardasu on 03/02/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewController.h"
#import "LocationController.h"

@interface LocationAuthorizationViewController : UIViewController <LocationControllerDelegate> {
    LocationController *locationController;
}

@property IBOutlet UIButton *requestAuthorizationButton;
- (IBAction)requestAuthorization:(id)sender;

@end
