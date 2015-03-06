//
//  NetworkingManager.h
//  GadaboutiOS
//
//  Created by David Barsky on 2/27/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "AFNetworking.h"

FOUNDATION_EXPORT NSString *const DomainURL;
FOUNDATION_EXPORT NSString *const createUser;


@interface NetworkingManager : AFHTTPSessionManager {
    AFHTTPRequestOperationManager *manager;
}

- (void)sendDictionary:(NSDictionary*)dictionary toService:(NSString*)service;

@end
