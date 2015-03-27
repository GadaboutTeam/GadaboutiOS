//
//  NetworkingManager.h
//  GadaboutiOS
//
//  Created by David Barsky on 2/27/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "AFNetworking.h"
#import "User.h"

FOUNDATION_EXPORT NSString *const DomainURL;

@interface NetworkingManager : AFHTTPSessionManager {
    AFHTTPRequestOperationManager *manager;
}

+ (id)sharedNetworkingManger;
- (void)sendDictionary:(NSDictionary*)dictionary toService:(NSString*)service;
- (void)requestWithDictionary:(NSDictionary *)dictionary fromService:(NSString *)service completion:(void (^)(id, NSError *))completion;
@end
