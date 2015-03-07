//
//  NetworkingManager.m
//  GadaboutiOS
//
//  Created by David Barsky on 2/27/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "NetworkingManager.h"

NSString *const DomainURL = @"http://104.236.228.143/";
NSString *const createUser = @"users";

@implementation NetworkingManager

- (id)init {
    self = [super init];
    if (self) {
        manager = [AFHTTPRequestOperationManager manager];
    }
    
    return self;
}

- (void)sendDictionary:(NSDictionary *)dictionary toService:(NSString *)service{
    NSString *postURL = [DomainURL stringByAppendingString:service];
    User *currentUser = [[User allObjects] firstObject];
    
    [manager POST:postURL
       parameters:dictionary
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"Success");
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Failure");
          }];
}

@end
