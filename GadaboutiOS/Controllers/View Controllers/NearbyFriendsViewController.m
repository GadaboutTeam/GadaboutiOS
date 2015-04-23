//
//  ConversationsViewController.m
//  GadaboutiOS
//
//  Created by David Barsky on 3/26/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "NearbyFriendsViewController.h"


// Frameworks
#import <Realm/Realm.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKCoreKit/FBSDKProfilePictureView.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Parse/Parse.h>

// Components
#import "ComposeInvitationViewController.h"
#import "FriendsManager.h"
#import "PushController.h"
#import "FriendCell.h"
#import "Picture.h"
#import "UserManager.h"

@interface NearbyFriendsViewController ()

// realm
@property (nonatomic, strong) RLMResults *nearbyFriends;
@property (nonatomic, strong) RLMNotificationToken *notification;
@property (nonatomic, retain) NSMutableArray *selectedFriends;

// for accessing friends
@property (nonatomic, strong) FriendsManager *friendsController;

// Facebook
@property (nonatomic, strong) FBSDKAccessToken *accessToken;

@end

@implementation NearbyFriendsViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.nearbyFriends = [User objectsWhere:@"userType = 1"];
    self.friendsController = [FriendsManager sharedFriendsController];
    self.selectedFriends = [[NSMutableArray alloc] init];
    [[self collectionView] setAllowsMultipleSelection:YES];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateFacebookFriends) name:FBSDKProfileDidChangeNotification object:nil];
    if ([[UserManager sharedUserController] isLoggedIn]) {
        [self updateFacebookFriends];
    }

    // updating collection view
    __weak typeof(self) weakSelf = self;
    self.notification = [RLMRealm.defaultRealm addNotificationBlock:^(NSString *notification, RLMRealm *realm) {
        weakSelf.nearbyFriends = [User objectsWhere:@"userType = 1"];
        [weakSelf.collectionView reloadData];
    }];
    [self.collectionView reloadData];


    // Disable the CreateEventButton if no cells are selected
    [RACObserve(self, selectedFriends) subscribeNext:^(NSMutableArray *selected) {
        if ([selected count] != 0) {
            [self.createEventButton setEnabled:YES];
        } else {
            [self.createEventButton setEnabled:NO];
        }
    }];
}

- (void)updateFacebookFriends {
    [self.friendsController getFacebookFriends];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    // Reset selection when view appears
    for (FriendCell *cell in self.collectionView.visibleCells) {
        [cell setSelected:NO];
    }
    NSMutableArray *sf = [self mutableArrayValueForKey:@"selectedFriends"];
    [sf removeAllObjects];

    UIViewController *loginViewController = [[UIStoryboard storyboardWithName:@"Main"
                                                                       bundle:[NSBundle mainBundle]]
                                             instantiateViewControllerWithIdentifier:@"loginScreen"];

    [RACObserve(self, accessToken) subscribeNext:^(FBSDKAccessToken *accessToken) {
        if (![FBSDKAccessToken currentAccessToken]) {
            NSLog(@"User not logged in to Facebook. Presenting login screen.");
            [self presentViewController:loginViewController animated:YES completion:nil];
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.nearbyFriends.count;
}

- (FriendCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FriendCell *cell = (FriendCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    User *friend = [self.nearbyFriends objectAtIndex:[indexPath row]];

    // Configure the cell
    [[cell displayName] setText:[friend getFirstName]];
    [self.friendsController getPictureForID:friend onCompletion:^{
        @autoreleasepool {
            UIImage *image = [UIImage imageWithData:[[Picture objectForPrimaryKey:[friend facebookID]] pictureData]];
            [[cell profilePictureView] setImage:[self getRoundedRectImageFromImage:image onReferenceView:cell.profilePictureView withCornerRadius:cell.profilePictureView.frame.size.width/2]];
        }
    }];

    return cell;
}

- (UIImage *)getRoundedRectImageFromImage :(UIImage *)image onReferenceView :(UIImageView*)imageView withCornerRadius :(float)cornerRadius
{
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, NO, 1.0);
    [[UIBezierPath bezierPathWithRoundedRect:imageView.bounds
                                cornerRadius:cornerRadius] addClip];
    [image drawInRect:imageView.bounds];
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return finalImage;
}


#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FriendCell *cell = (FriendCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    [cell setCellState:CellStateSelected];
    [cell setSelected:YES];
    [cell setNeedsDisplay];
    NSLog(@"Cell %ld selected", (long)[indexPath row]);

    //Add friend to selected array
    User *friend = [self.nearbyFriends objectAtIndex:[indexPath row]];
    [self addSelectedFriendsObject:friend];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    FriendCell *cell = (FriendCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    [cell setCellState:CellStateDeselected];
    [cell setSelected:NO];
    [cell setNeedsDisplay];
    NSLog(@"Cell %ld deselected", (long)[indexPath row]);

    //Remove friend from selected array
    User *friend = [self.nearbyFriends objectAtIndex:[indexPath row]];
    [self removeSelectedFriendsObject:friend];
}

// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}



// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ComposeInvitationViewController *destinationVC = (ComposeInvitationViewController *)[segue destinationViewController];
    [destinationVC setFriendsArray:self.selectedFriends];
}


/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {

}
*/

#pragma - KVO Compliant setters/getters

- (NSUInteger)countOfSelectedFriends {
    return [self.selectedFriends count];
}

- (void)insertObject:(User *)object inSelectedFriendsAtIndex:(NSUInteger)index {
    [self.selectedFriends insertObject:object atIndex:index];
}

- (id)objectInSelectedFriendsAtIndex:(NSUInteger)index {
    return [self.selectedFriends objectAtIndex:index];
}

- (void)removeObjectFromSelectedFriendsAtIndex:(NSUInteger)index {
    [self.selectedFriends removeObjectAtIndex:index];
}

- (void)addSelectedFriendsObject:(User *)object {
    [self.selectedFriends addObject:object];
}

- (void)removeSelectedFriendsObject:(User *)object {
    [self.selectedFriends removeObject:object];
}

@end
