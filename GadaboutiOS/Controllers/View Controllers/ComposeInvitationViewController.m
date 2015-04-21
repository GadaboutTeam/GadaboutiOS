//
//  InvitationViewController.m
//  GadaboutiOS
//
//  Created by David Barsky on 4/13/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

// Framework Import

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <pop/POP.h>

// Projects
#import "AddressingViewController.h"
#import "ComposeInvitationViewController.h"
#import "Event.h"
#import "EventController.h"
#import "InvitationView.h"
#import "User.h"


@interface ComposeInvitationViewController ()

@property (weak, nonatomic) IBOutlet SignalsTextView *textField;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (nonatomic, retain) Event *event;

@end

@implementation ComposeInvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // initial, default state
    [self setInitalState];

    [self configureNextButton];

    self.event = [[Event alloc] init];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    NSLog(@"Final friends: %@", self.friendsArray);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ReactiveCocoa Setup

- (void)setInitalState {
    [self.nextButton setEnabled:NO];
    [self.nextButton setTitleColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
}

- (void)configureNextButton {
    
}

#pragma mark - IBActions

- (IBAction)cancelWasPressed:(id)sender {
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)nextWasPressed:(id)sender {
    [self sendEvent];
}

- (void)sendEvent {
    NSLog(@"Event request was sent.");
    [EventController requestEventCreation:self.event withParticipants:self.friendsArray andBlock:^(id response, NSError *error) {
        if(error == nil) {
            NSLog(@"Event was created.");
            [self performSegueWithIdentifier:@"CreateEventSegue" sender:self];
        } else {
            NSLog(@"Event creation failed: %@", [error description]);
        }
    }];
}

#pragma mark - Navigation

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    AddressingViewController *nextViewController = (AddressingViewController *)[[segue destinationViewController] topViewController];
//    nextViewController.message = self.textField.text;
//}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    NSLog(@"Event name: %@ length: %ld", [textView text], (long)[[textView text] length]);
    [self.event setName:[textView text]];

    if ([[textView text] length] > 5) {
        [self.nextButton setEnabled:YES];
    } else {
        [self.nextButton setEnabled:NO];
    }
}

@end
