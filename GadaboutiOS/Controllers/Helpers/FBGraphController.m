//
//  FBGraphController.m
//  GadaboutiOS
//
//  Created by David Barsky on 2/20/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "FBGraphController.h"

@implementation FBGraphController

+ (id)sharedLocationController {
    static FBGraphController *graphController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        graphController = [[self alloc] init];
    });
    
    return graphController;
}

- (id)init {
    if (self = [super init]) {
        NSLog(@"Graph Controller Initialized");
    }
    return self;
}

-(void)getUserFriends {
    [FBRequestConnection startWithGraphPath:@"/me/friends" parameters:nil HTTPMethod:@"GET"
                          completionHandler:^( FBRequestConnection *connection, id result, NSError *error) {
                              /* handle the result */
                          }];
}

@end
