//
//  FBLoginViewController.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 03/02/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>
#import <pop/POP.h>
#import "FBLoginViewController.h"
#import "PushStoryBoardSegue.h"

@interface FBLoginViewController ()

@end

@implementation FBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    _fbLoginView.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    _fbLoginView.delegate = self;
    [_welcomeLabel.layer setOpacity:0.0];
    [_fbLoginView.layer setOpacity:0.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [self animateWelcomeLabel];
    [self animateLoginButton];
}

- (void)animateWelcomeLabel {
    //Pulse Animation
    POPSpringAnimation *pulse = [POPSpringAnimation animation];
    pulse.property = [POPAnimatableProperty propertyWithName:kPOPLayerScaleXY];
    pulse.toValue = [NSValue valueWithCGPoint:CGPointMake(1.5, 1.5)];
    pulse.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
    pulse.springBounciness = 18.0;
    pulse.springSpeed = 8.0;

    //FadeIn Animation
    POPBasicAnimation *fadeIn = [POPBasicAnimation animation];
    fadeIn.property = [POPAnimatableProperty propertyWithName:kPOPLayerOpacity];
    fadeIn.toValue = @(1.0);
    fadeIn.duration = 0.5;

    [_welcomeLabel.layer pop_addAnimation:fadeIn forKey:@"fadeInAnimation"];
    [_welcomeLabel.layer pop_addAnimation:pulse forKey:@"pulseAnimation"];
}

- (void)animateLoginButton {
    //FadeInAnimation
    POPBasicAnimation *fadeIn = [POPBasicAnimation animation];
    fadeIn.property = [POPAnimatableProperty propertyWithName:kPOPLayerOpacity];
    fadeIn.toValue = @(1.0);
    fadeIn.duration = 1;

    [_fbLoginView.layer pop_addAnimation:fadeIn forKey:@"fadeInAnimation"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - FBLoginViewDelegate methods
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
    NSLog(@"User %@ has logged in. ID: %@", user.name, user.id);

    //Segue to the main screen
    [self performSegueWithIdentifier:@"CollectionView@Main" sender:self];
}

// Handle possible errors that can occur during login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;

    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];

        // This code will handle session closures that happen outside of the app
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";

        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");

        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }

    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

#pragma mark - UIViewControllerTransitioningDelegate methods

//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
//
//
//
//}

@end
