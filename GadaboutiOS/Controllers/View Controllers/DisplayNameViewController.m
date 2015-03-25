//
//  DisplayNameViewController.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 24/03/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "DisplayNameViewController.h"

@interface DisplayNameViewController ()
@property IBOutlet UITextField *displayNameTextField;
@property IBOutlet UIButton *doneButton;
@property (nonatomic, retain) NSString *displayName;
@end

@implementation DisplayNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction) doneButtonWasPressed:(id) sender {
    [self.view endEditing:YES];
    _displayName = [NSString stringWithString:[_displayNameTextField text]];

    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    [self presentViewController:[mainStoryboard instantiateViewControllerWithIdentifier:@"TabBarController"] animated:YES completion:nil];
}

@end
