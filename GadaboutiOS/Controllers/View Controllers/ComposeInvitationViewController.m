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
#import "ComposeInvitationViewController.h"
#import "InvitationView.h"
#import "AddressingViewController.h"

@interface ComposeInvitationViewController ()

@property (weak, nonatomic) IBOutlet SignalsTextView *textField;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation ComposeInvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // initial, default state
    [self setInitalState];

    [self configureNextButton];
    [self configureTextField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ReactiveCocoa Setup

- (void)setInitalState {
    [self.nextButton setEnabled:NO];
    [self.nextButton setTitleColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5] forState:UIControlStateNormal];
}

- (void)configureTextField {
    [[self.textField.rac_textSignal filter:^BOOL(NSString *text) {
        // cludgy workaround. since filter only returns true, thereby activating the nextButton,
        // the nextButton doesn’t get *deactivated* if the below condition isn't met anymore.
        [self setInitalState];
        
        return text.length > 5;
    }]
    subscribeNext:^(id x) {
        [self.nextButton setEnabled:YES];
        [self.nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }];
}

- (void)configureNextButton {
    
}

#pragma mark - IBActions

- (IBAction)cancelWasPressed:(id)sender {
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)nextWasPressed:(id)sender {

}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    AddressingViewController *nextViewController = (AddressingViewController *)[[segue destinationViewController] topViewController];
    nextViewController.message = self.textField.text;
}

@end
