//
//  NetworkingManager.m
//  GadaboutiOS
//
//  Created by David Barsky on 2/27/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "NetworkingManager.h"
#import <Realm/Realm.h>

NSString *const DomainURL = @"http://104.236.228.143:8080/";

@implementation NetworkingManager

+ (id)sharedNetworkingManger {
    static NetworkingManager *sharedNetworkingManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNetworkingManager = [[self alloc] init];
    });
    
    return sharedNetworkingManager;
}

- (NetworkingManager *)init {
    self = [super init];
    if (self) {
        manager = [AFHTTPRequestOperationManager manager];
    }
    
    return self;
}

- (void)sendDictionary:(NSDictionary *)dictionary toService:(NSString *)service{
    NSString *postURL = [DomainURL stringByAppendingString:service];
    
    [manager POST:postURL
       parameters:dictionary
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"Success");
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Failure: %@", error.description);
          }];
}

- (void)requestWithDictionary:(NSDictionary *)dictionary fromService:(NSString *)service
                 completion:(void (^)(NSError *))completion{

    NSString *postURL = [DomainURL stringByAppendingString:service];

    [manager POST:postURL
       parameters:dictionary
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              completion(nil);
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              completion(error);
          }];

}

@end
