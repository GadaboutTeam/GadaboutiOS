//
//  DisplayNameViewController.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 24/03/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "DisplayNameViewController.h"
#import "NetworkingManager.h"
#import "PrimaryButton.h"
#import "User.h"
#import "UserController.h"

@interface DisplayNameViewController ()

@property IBOutlet UITextField *displayNameTextField;
@property IBOutlet PrimaryButton *doneButton;
@property (nonatomic, retain) NSString *displayName;
@property RLMRealm *defaultRealm;
@property User *user;

@end

@implementation DisplayNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _defaultRealm = [RLMRealm defaultRealm];
    _user = [[UserController sharedUserController] getCurrentUser];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)doneButtonWasPressed:(id) sender {
    [self.view endEditing:YES];
    _displayName = [NSString stringWithString:[_displayNameTextField text]];
    [_user setDisplayName:_displayName];
    [[UserController sharedUserController] persistUser:_user];


    NetworkingManager *networkingManager = [NetworkingManager sharedNetworkingManger];
    [networkingManager sendDictionary:[_user JSONDictionary] toService:@"users"];

//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    [self presentViewController:[mainStoryboard instantiateViewControllerWithIdentifier:@"TabBarController"] animated:YES completion:nil];
}

- (IBAction) displayNameChanged:(id) sender {
    if ([[_displayNameTextField text] length] != 0) {
        [_doneButton setEnabled:YES];
        [_doneButton setEnabledState];
    } else {
        [_doneButton setEnabled:NO];
        [_doneButton setDisabledState];
    }
}

@end
