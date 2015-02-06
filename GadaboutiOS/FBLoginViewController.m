//
//  FBLoginViewController.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 03/02/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>
#import <pop/POP.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "FBLoginViewController.h"
#import "PushStoryBoardSegue.h"


@interface FBLoginViewController ()

@end

@implementation FBLoginViewController
@synthesize customView;
@synthesize sidebarImages;

- (void)viewDidLoad {
    [super viewDidLoad];
    customView = (FacebookLoginView *)self.view;
    // Do any additional setup after loading the view.
    customView.fbLoginView.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    customView.fbLoginView.delegate = self;
    [customView setupLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [customView runAnimations];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    sidebarImages = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"profilePicture",[UIImage imageNamed:@"menu"], nil];

    return self;
}



#pragma mark - Navigation

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (void)setupMenu {
//    //Get the current user
//    //TODO: Looks like theres an error with getting the values from the sidebarImages dictionary
//    RLMResults *result = [User allObjects];
//    User *user = [result firstObject];
//    UIImage *image = [UIImage imageWithData:user.profilePhoto];
////    [sidebarImages setObject:image forKey:@"profilePicture"];
//
////    NSArray *images = [sidebarImages allValues];
//    NSArray *images = @[image];
//}

#pragma mark - FBLoginViewDelegate methods
- (void)loginViewFetchedUserInfo:(FacebookLoginView *)loginView user:(id<FBGraphUser>)user {
    NSLog(@"User %@ has logged in. ID: %@", user.name, user.objectID);

    // Store user pic; Asynchronously of course
    NSString *imageURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", user.objectID];
    [SDWebImageDownloader.sharedDownloader downloadImageWithURL:[NSURL URLWithString:imageURL]
                                                        options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                            NSLog(@".");
                                                        }completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                                                            if (image && finished) {
//                                                                User *user = [[User allObjects] firstObject];
//                                                                user.profilePhoto = UIImagePNGRepresentation(image);

//                                                                RLMRealm *realm = [RLMRealm defaultRealm];
//                                                                [realm beginWriteTransaction];
//                                                                [realm addObject:user];
//                                                                [realm commitWriteTransaction];

                                                                // Reinitialize sidebar
//                                                                [self setupMenu];
                                                            }
                                                        }];

//    //Segue to the main screen
//    [self performSegueWithIdentifier:@"CollectionView@Main" sender:self];
}

// Handle possible errors that can occur during login
- (void)loginView:(FacebookLoginView *)loginView handleError:(NSError *)error {
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

// #pragma mark - UIViewControllerTransitioningDelegate methods

//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
//
//
//
//}

- (IBAction)showMenu:(id)sender {
    MFSideMenuContainerViewController *menuViewController = (MFSideMenuContainerViewController *)self.customView.window.rootViewController;
    [menuViewController toggleLeftSideMenuCompletion:^{
        NSLog(@"Menu triggered.");
    }];
}

@end
