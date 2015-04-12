//
//  ConversationsViewController.m
//  GadaboutiOS
//
//  Created by David Barsky on 4/7/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "ConversationsViewController.h"
#import <Realm/Realm.h>

@interface ConversationsViewController ()

@property (nonatomic, strong) RLMResults *array;
@property (nonatomic, strong) RLMNotificationToken *notification;

@end

@implementation ConversationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

@end
