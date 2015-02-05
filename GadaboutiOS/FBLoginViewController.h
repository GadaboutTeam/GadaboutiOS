//
//  FBLoginViewController.h
//  GadaboutiOS
//
//  Created by Alex Bardasu on 03/02/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RNFrostedSidebar/RNFrostedSidebar.h>
#import "FacebookLoginView.h"
#import "User.h"

@interface FBLoginViewController : UIViewController <FBLoginViewDelegate, UIViewControllerTransitioningDelegate,
    RNFrostedSidebarDelegate>
@property FacebookLoginView *customView;
@property NSMutableDictionary *sidebarImages;
@property RNFrostedSidebar *menu;

- (IBAction)showMenu:(id)sender;
@end
