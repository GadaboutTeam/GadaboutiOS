//
//  CollectionViewController.h
//  GadaboutiOS
//
//  Created by David Barsky on 2/2/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationController.h"
#import "LocationAuthorizationViewController.h"

@interface CollectionViewController : UICollectionViewController {
    LocationController *locationController;
}

@end
