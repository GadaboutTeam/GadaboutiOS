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
#import <pop/POP.h>

// Components
#import "ComposeInvitationViewController.h"
#import "FriendsManager.h"
#import "InvitationManager.h"
#import "PushManager.h"
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

// UI
@property (nonatomic, retain) UIButton *continueButton;
@property (nonatomic, retain) ComposeInvitationViewController *nextViewController;

@end

@implementation NearbyFriendsViewController

static NSString * const reuseIdentifier = @"Cell";
static NSString * const nextViewControllerIdentifier = @"ComposeInvitationViewController";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.nearbyFriends = [User objectsWhere:@"userType = 1"];
    self.friendsController = [FriendsManager sharedFriendsController];
    self.selectedFriends = [[NSMutableArray alloc] init];
    [[self collectionView] setAllowsMultipleSelection:YES];

    [self setupNextButton];

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
            [self showNextButton];
        } else {
            [self.createEventButton setEnabled:NO];
            [self hideNextButton];
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

- (void)viewDidDisappear:(BOOL)animated {
    // Deselect cells
    for (FriendCell *cell in self.collectionView.visibleCells) {
        [cell prepareForReuse];
    }
}

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
            [[cell profilePictureView] setImage:image];
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

    [cell setNeedsDisplay];

    //Add friend to selected array
    User *friend = [self.nearbyFriends objectAtIndex:[indexPath row]];
    [self addSelectedFriendsObject:friend];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    FriendCell *cell = (FriendCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    [cell setNeedsDisplay];

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
    self.nextViewController = (ComposeInvitationViewController *)[segue destinationViewController];
    [self.nextViewController setFriendsArray:self.selectedFriends];
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

#pragma - Next Button
// I know this is dirty. It's late and it's gonna look cool.
- (void)setupNextButton {
    CGRect screen = [UIScreen mainScreen].bounds;
    float width = CGRectGetWidth(screen);
    float height = 60.0;

    CGRect frame = CGRectMake(0, CGRectGetHeight(screen) - height*2, width, height);
    self.continueButton = [[UIButton alloc] initWithFrame:frame];
    [self.continueButton setTitle:@"Continue" forState:UIControlStateNormal];
    [self.continueButton setBackgroundColor:[UIColor greenColor]];
    [self.continueButton addTarget:self action:@selector(goToNextScreen:) forControlEvents:UIControlEventTouchUpInside];
    [self.continueButton setHidden:YES];

    [self.collectionView addSubview:self.continueButton];
    [self.collectionView bringSubviewToFront:self.continueButton];
}

- (IBAction)goToNextScreen:(id)sender {
    [self performSegueWithIdentifier:@"ComposeInvitationSegue" sender:self];
}

- (void)hideNextButton {
    float offset = [self.continueButton frame].size.height;
    if ([self.continueButton isEnabled]) {
        [self translateNextButton:CGAffineTransformMakeTranslation(0.0, offset)];
        [self.continueButton setEnabled:NO];
    }
}

- (void)showNextButton {
    float offset = [self.continueButton frame].size.height;
    if (![self.continueButton isEnabled]) {
        if ([self.continueButton isHidden]) {
            [self.continueButton setHidden:NO];
        }
        [self translateNextButton:CGAffineTransformMakeTranslation(0.0, -offset)];
        [self.continueButton setEnabled:YES];
    }
}

- (void)translateNextButton:(CGAffineTransform)transform {
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    springAnimation.toValue = [NSValue valueWithCGRect:
                               CGRectApplyAffineTransform(self.continueButton.frame, transform)];
    springAnimation.velocity = [NSValue valueWithCGRect:CGRectMake(2, 2, 2, 2)];
    springAnimation.springBounciness = 10.0f;

    [self.continueButton pop_addAnimation:springAnimation forKey:@"MoveButtonAnimation"];
}

#pragma mark - TransitionDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.transitionM
}

@end
