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
#import "EventConversationViewController.h"
#import "InvitationView.h"
#import "User.h"


@interface ComposeInvitationViewController ()

@property (weak, nonatomic) IBOutlet SignalsTextView *textField;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (nonatomic, retain) Event *event;

@end

@implementation ComposeInvitationViewController

- (id)init {
    if (self = [super init]) {

    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.event = [[Event alloc] init];

    // initial, default state
    [self setInitalState];
    [self configureNextButton];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];

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
    [self.nextButton setTitleColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.2] forState:UIControlStateDisabled];
}

- (void)configureNextButton {
    
}

#pragma mark - IBActions

- (IBAction)cancelWasPressed:(id)sender {
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)nextWasPressed:(id)sender {
    [self.nextButton setEnabled:NO];
    [self sendEvent];
}

- (void)sendEvent {
    NSLog(@"Event request was sent.");

    // Cosmetic user feedback
    [self startActivityFeedback];

    [EventController requestEventCreation:self.event withParticipants:self.friendsArray andBlock:^(id response, NSError *error) {
        if(error == nil) {
            NSLog(@"Event was created.");
            [self performSegueWithIdentifier:@"CreateEventSegue" sender:self];
        } else {
            NSLog(@"Event creation failed: %@", [error description]);
        }
        [self stopActivityFeedback];
    }];
}

- (void)startActivityFeedback {
    [self.spinner startAnimating];

    [self.textView endEditing:YES];
    [self.textView setHidden:YES];

    POPSpringAnimation *spinnerAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    [spinnerAnimation setToValue:[NSValue valueWithCGPoint:CGPointMake(1.2, 1.2)]];
    [spinnerAnimation setFromValue:[NSValue valueWithCGPoint:CGPointMake(0.8, 0.8)]];
    [spinnerAnimation setRepeatForever:YES];
    [self.spinner pop_addAnimation:spinnerAnimation forKey:@"springAnimation"];
}

- (void)stopActivityFeedback {
    [self.spinner stopAnimating];
    [self.spinner pop_removeAllAnimations];

    [self.textView setText:@""];
    [self.textView setHidden:NO];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    EventConversationViewController *ecvc = (EventConversationViewController *)[segue destinationViewController];
    ecvc.event = self.event;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    NSLog(@"Event name: %@ length: %ld", [textView text], (long)[[textView text] length]);
    [self.event setName:[textView text]];

    if ([[textView text] length] > 2) {
        [self.nextButton setEnabled:YES];
    } else {
        [self.nextButton setEnabled:NO];
    }
}

@end
