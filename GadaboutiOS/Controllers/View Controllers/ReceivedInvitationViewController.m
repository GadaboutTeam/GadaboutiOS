//
//  ReceivedInvitationViewController.m
//  GadaboutiOS
//
//  Created by David Barsky on 4/20/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//


// Frameworks
#import <Realm/Realm.h>

// App Imports
#import "ReceivedInvitationViewController.h"
#import "FriendStatusViewCell.h"
#import "User.h"
#import "Invitation.h"

NSString const *reuseIdentifier = @"Cell";

@interface ReceivedInvitationViewController ()

// IBOutlets
@property (weak, nonatomic) IBOutlet UITextView *invitationNote;
@property (weak, nonatomic) IBOutlet UICollectionView *friendStatusView;

// Realm
@property (nonatomic, strong) RLMResults *friends;
@property (nonatomic, strong) RLMNotificationToken *notification;

@end

@implementation ReceivedInvitationViewController

#pragma mark — View Loading

- (void)viewDidLoad {
    [super viewDidLoad];

    // table view setup
    __weak typeof(self) weakSelf = self;
    self.notification = [RLMRealm.defaultRealm addNotificationBlock:^(NSString *notification, RLMRealm *realm) {
        [weakSelf.friendStatusView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"User info: %@", self.userInfo);
}

#pragma mark - Collection View Setup


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.friends.count;
}

- (FriendStatusViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FriendStatusViewCell *cell = (FriendStatusViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    #warning needs to be pulled from inviation
    User *friend = [self.friends objectAtIndex:[indexPath row]];
    
//    // Configure the cell
//    [[cell s] setText:[friend getFirstName]];
//    [self.friendsController getPictureForID:friend onCompletion:^{
//        @autoreleasepool {
//            UIImage *image = [UIImage imageWithData:[[Picture objectForPrimaryKey:[friend facebookID]] pictureData]];
//            [[cell profilePictureView] setImage:image];
//        }
//    }];
    
    return cell;
}

#pragma mark - IBActions
- (IBAction)closeButtonWasPressed:(id)sender {

}

- (IBAction)yesButtonWasPressed:(id)sender {
    
}

- (IBAction)noButtonWasPressed:(id)sender {
    
}

@end
