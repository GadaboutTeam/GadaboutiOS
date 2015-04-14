//
//  AddressingViewController.m
//  GadaboutiOS
//
//  Created by David Barsky on 4/14/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

// Frameworks
#import <VENTokenField/VENTokenField.h>

// Project Imports
#import "AddressingViewController.h"

@interface AddressingViewController () <VENTokenFieldDataSource, VENTokenFieldDelegate>

@property (weak, nonatomic) IBOutlet VENTokenField *tokenField;
@property (strong, nonatomic) NSMutableArray *names;

@end

@implementation AddressingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTokenField];
    self.names = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup Token Field

- (void)setupTokenField {
    self.tokenField.delegate = self;
    self.tokenField.dataSource = self;
    self.tokenField.placeholderText = NSLocalizedString(@"Enter Names Here", nil);
    self.tokenField.toLabelText = NSLocalizedString(@"To:", nil);
    
    [self.tokenField setColorScheme:[UIColor colorWithRed:0.27 green:0.52 blue:0.98 alpha:1]];
    [self.tokenField becomeFirstResponder];
}

#pragma mark - VENTokenFieldDelegate

- (void)tokenField:(VENTokenField *)tokenField didEnterText:(NSString *)text {
    [self.names addObject:text];
    [self.tokenField reloadData];
}

- (void)tokenField:(VENTokenField *)tokenField didDeleteTokenAtIndex:(NSUInteger)index {
    [self.names removeObjectAtIndex:index];
    [self.tokenField reloadData];
}

#pragma mark - Token Field Datasource

- (NSString *)tokenField:(VENTokenField *)tokenField titleForTokenAtIndex:(NSUInteger)index {
    return self.names[index];
}

- (NSUInteger)numberOfTokensInTokenField:(VENTokenField *)tokenField {
    return [self.names count];
}

- (NSString *)tokenFieldCollapsedText:(VENTokenField *)tokenField {
    return [NSString stringWithFormat:@"%tu people", [self.names count]];
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
