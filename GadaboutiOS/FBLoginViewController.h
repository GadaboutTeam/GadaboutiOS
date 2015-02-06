//
//  FBLoginViewController.h
//  GadaboutiOS
//
//  Created by Alex Bardasu on 03/02/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MFSideMenu/MFSideMenu.h>
#import "FacebookLoginView.h"
#import "User.h"

@interface FBLoginViewController : UIViewController <FBLoginViewDelegate, UIViewControllerTransitioningDelegate>
@property FacebookLoginView *customView;
@property NSMutableDictionary *sidebarImages;

- (IBAction)showMenu:(id)sender;
@end
