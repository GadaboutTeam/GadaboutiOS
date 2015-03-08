//
//  NewMessageViewController.m
//  GadaboutiOS
//
//  Created by David Barsky on 3/5/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "NewMessageViewController.h"
#import "TokenField.h"

@interface NewMessageViewController () <VENTokenFieldDelegate, VENTokenFieldDataSource>

@property (weak, nonatomic) IBOutlet TokenField *tokenField;
@property (strong, nonatomic) NSMutableArray *names;

@end

@implementation NewMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTokenField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - VENTokenField/Setup

- (void)setupTokenField {
    // progamatic setup
    self.names = [NSMutableArray array];
    self.tokenField.delegate = self;
    self.tokenField.dataSource = self;
    self.tokenField.placeholderText = NSLocalizedString(@"Name", nil);
    self.tokenField.toLabelText = NSLocalizedString(@"To:", nil);
    [self.tokenField becomeFirstResponder];
}

#pragma mark - VENTokenField/Delegate

- (void)tokenField:(VENTokenField *)tokenField didEnterText:(NSString *)text {
    [self.names addObject:text];
    [self.tokenField reloadData];
    NSLog(@"%@", self.names);
}

- (void)tokenField:(VENTokenField *)tokenField didDeleteTokenAtIndex:(NSUInteger)index {
    [self.names removeObjectAtIndex:index];
    [self.tokenField reloadData];
}

#pragma mark - VENTokenField/Data Source

- (NSString *)tokenField:(VENTokenField *)tokenField titleForTokenAtIndex:(NSUInteger)index {
    return self.names[index];
}

- (NSUInteger)numberOfTokensInTokenField:(VENTokenField *)tokenField {
    return [self.names count];
}

- (NSString *)tokenFieldCollapsedText:(VENTokenField *)tokenField {
    return [NSString stringWithFormat:@"%tu people", [self.names count]];
}

#pragma mark - IBActions

- (IBAction)sendWasPressed:(id)sender {
    [self dismissSelf];
}

- (IBAction)cancelWasPressed:(id)sender {
    [self dismissSelf];
}

- (void)dismissSelf {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
