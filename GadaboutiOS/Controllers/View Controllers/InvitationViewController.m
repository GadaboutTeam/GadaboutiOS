//
//  InvitationViewController.m
//  GadaboutiOS
//
//  Created by David Barsky on 4/13/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "InvitationViewController.h"
#import "InvitationView.h"
#import "AddressingViewController.h"

@interface InvitationViewController ()

@property (weak, nonatomic) IBOutlet SignalsTextView *textField;

@end

@implementation InvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions


- (IBAction)cancelWasPressed:(id)sender {
    
}

- (IBAction)nextWasPressed:(id)sender {
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//     Get the new view controller using [segue destinationViewController].
//     Pass the selected object to the new view controller.
    
    AddressingViewController *nextViewController = (AddressingViewController *)[[segue destinationViewController] topViewController];
    nextViewController.message = self.textField.text;
}

@end
