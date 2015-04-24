//
//  FriendStatusCollectionViewController.h
//  GadaboutiOS
//
//  Created by Alex Bardasu on 24/04/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>

@interface FriendStatusCollectionViewController : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, retain) NSArray *friendsArray;
@property (nonatomic, retain) RLMNotificationToken *notification;

@end
