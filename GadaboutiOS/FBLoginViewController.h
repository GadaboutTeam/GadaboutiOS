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

@interface FBLoginViewController : UIViewController <FBLoginViewDelegate, UIViewControllerTransitioningDelegate>
@property FacebookLoginView *customView;
@property RNFrostedSidebar *menu;

- (IBAction)showMenu:(id)sender;
@end
