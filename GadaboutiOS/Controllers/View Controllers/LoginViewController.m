//
//  FBLoginViewController.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 03/02/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <pop/POP.h>
#import <TwitterKit/TwitterKit.h>
#import "ContactsGrantViewController.h"
#import "LoginViewController.h"
#import "PushStoryBoardSegue.h"
#import "User.h"

@interface LoginViewController ()
@property User *user;
@property RLMRealm *defaultRealm;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    if ([[User objectsWhere:@"userType = 0"] count] == 0) {
        _user = [[User alloc] init];
        [_user setPhoneNumber:@"phone number"];
        [_user setUserType:UserTypeSelf];
    } else {
        _user = [[User objectsWhere:@"userType = 0"] firstObject];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {

}

- (IBAction)loginWasPressed:(id)sender {
    DGTAppearance *appearance = [[DGTAppearance alloc] init];
    
    appearance.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
    appearance.accentColor = [UIColor colorWithRed:0.99 green:0.33 blue:0.33 alpha:1];
   
    Digits *digits = [Digits sharedInstance];
    [digits authenticateWithDigitsAppearance:appearance
                              viewController:nil
                                       title:nil
                                  completion:^(DGTSession *session, NSError *error) {
                                        if (session) {
                                            NSLog(@"Logged in!");

                                            [_user setAuthToken:session.authToken];
                                            [_user setPhoneNumber:session.phoneNumber];
                                        } else {
                                            NSLog(@"Something went weird!");
                                        }
                                  }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ContactsGrantViewController *contactsVC = (ContactsGrantViewController *)segue.destinationViewController;
    contactsVC.user = _user;
}

#pragma mark - UIViewControllerTransitioningDelegate methods

//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
//
//
//
//}

@end
