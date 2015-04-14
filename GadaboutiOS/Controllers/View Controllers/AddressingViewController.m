//
//  AddressingViewController.m
//  GadaboutiOS
//
//  Created by David Barsky on 4/14/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

// Frameworks
#import <VENTokenField/VENTokenField.h>
#import <Realm/Realm.h>

// Project Imports
#import "AddressingViewController.h"
#import "SignalsTableViewCell.h"
#import "User.h"

@interface AddressingViewController () <VENTokenFieldDataSource, VENTokenFieldDelegate>

// token field
@property (weak, nonatomic) IBOutlet VENTokenField *tokenField;
@property (strong, nonatomic) NSMutableArray *names;

// table view & data source
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) RLMResults *array;
@property (nonatomic, strong) RLMNotificationToken *notification;

@end

static NSString *const cellID = @"Cell";

@implementation AddressingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // token field setup
    [self setupTokenField];
    self.names = [NSMutableArray array];
    
    // table view setup
    __weak typeof(self) weakSelf = self;
    self.notification = [RLMRealm.defaultRealm addNotificationBlock:^(NSString *notification, RLMRealm *realm) {
        [weakSelf.tableView reloadData];
    }];
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

- (void)tokenField:(VENTokenField *)tokenField didChangeText:(NSString *)text {
    [self tableView:self.tableView filterUsingText:text];
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

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (SignalsTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SignalsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[SignalsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    User *user = self.array[indexPath.row];
    cell.nameLabel.text = user.displayName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView filterUsingText:(NSString *)text {
    RLMResults *filteredResults = [User objectsWhere:@"displayName CONTAINS '%@'", text];
    self.array = filteredResults;
    [tableView reloadData];
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
