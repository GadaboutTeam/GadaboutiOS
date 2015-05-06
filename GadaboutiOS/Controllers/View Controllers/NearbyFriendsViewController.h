//
//  ConversationsViewController.h
//  GadaboutiOS
//
//  Created by David Barsky on 3/26/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearbyFriendsViewController : UICollectionViewController <UICollectionViewDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, retain) IBOutlet UIBarButtonItem *createEventButton;

@end
