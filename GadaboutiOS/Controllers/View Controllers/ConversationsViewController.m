//
//  ConversationsViewController.m
//  GadaboutiOS
//
//  Created by David Barsky on 3/26/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "ConversationsViewController.h"

// Frameworks
#import <Realm/Realm.h>
#import <PureLayout/PureLayout.h>

// Components
#import "PrimaryButton.h"

@interface ConversationsViewController ()

@property (nonatomic, strong) RLMArray *conversations;
@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic, strong) PrimaryButton *findFriendsButton;

@end

@implementation ConversationsViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    if ([self shouldShowFindFriendsButton]) {
        [self.view setNeedsUpdateConstraints];
        // positions button on center
        [self.view addSubview:_findFriendsButton];
        [self updateViewConstraints];
    } else {
        [self.collectionView reloadData];
    }
    
    // Do any additional setup after loading the view.
    [self.collectionView reloadData];
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

#pragma mark Empty State Handling

- (BOOL)shouldShowFindFriendsButton {
    if (_conversations.count == 0) {
        return YES;
    } else {
        return NO;
    }
}

- (void)updateViewConstraints {
    if (!self.didSetupConstraints) {
        [_findFriendsButton autoCenterInSuperview];
        [_findFriendsButton autoSetDimensionsToSize:CGSizeMake(80.0, 50.0)];
        
        self.didSetupConstraints = YES;
    }
    
    [super updateViewConstraints];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _conversations.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
