//
//  ContactsGrantViewController.m
//  GadaboutiOS
//
//  Created by David Barsky on 3/23/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <APAddressBook.h>
#import "ContactsGrantViewController.h"
#import "DisplayNameViewController.h"

@interface ContactsGrantViewController ()

@end

@implementation ContactsGrantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
- (IBAction)affirmativeWasPressed:(id)sender {
    // [self getContacts];
}

- (IBAction)optOutWasPressed:(id)sender {
    
}

#pragma mark - Contacts Pullin

- (void)getContacts {
    APAddressBook *addressBook = [[APAddressBook alloc] init];
    [addressBook loadContacts:^(NSArray *contacts, NSError *error) {
        if (!error) {
            NSLog(@"We got the contacts!");
        } else {
            NSLog(@"%@", error);
        }
    }];
}

@end
