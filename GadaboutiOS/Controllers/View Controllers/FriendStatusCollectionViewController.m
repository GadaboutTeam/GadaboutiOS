//
//  FriendStatusCollectionViewController.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 24/04/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "FriendStatusCollectionViewController.h"
#import "FriendStatusViewCell.h"
#import "FriendsManager.h"
#import "User.h"
#import "Picture.h"

@implementation FriendStatusCollectionViewController

static NSString* const friendCellIdentifier = @"FriendStatusCell";

- (id)init {
    self = [super init];

    return self;
}

#pragma mark - <UICollectionViewController>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.friendsArray count];
}

- (FriendStatusViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FriendStatusViewCell *cell = (FriendStatusViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:friendCellIdentifier forIndexPath:indexPath];

    User *friend = [self.friendsArray objectAtIndex:[indexPath row]];

    [[FriendsManager sharedFriendsController] getPictureForID:friend onCompletion:^{
        @autoreleasepool {
            UIImage *image = [UIImage imageWithData:[[Picture objectForPrimaryKey:[friend facebookID]] pictureData]];
            [[cell profilePicture] setImage:image];
        }
    }];

    return cell;
}

@end
