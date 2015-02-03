//
//  PushStoryBoardSegue.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 03/02/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "PushStoryBoardSegue.h"

@implementation PushStoryBoardSegue

+ (UIViewController *)sceneNamed:(NSString *)identifier {
    NSArray *info = [identifier componentsSeparatedByString:@"@"];


    NSLog(@"identifier: %@", info);
    NSString *storyboard_name = info[1];
    NSString *scene_name = info[0];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboard_name bundle:nil];
    UIViewController *scene = nil;

    if (scene_name.length == 0) {
        scene = [storyboard instantiateInitialViewController];
    } else {
        scene = [storyboard instantiateViewControllerWithIdentifier:scene_name];
    }

    return scene;
}

- (id)initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination {
    return [super initWithIdentifier:identifier
                              source:source
                         destination:[PushStoryBoardSegue sceneNamed:identifier]];
}

- (void)perform {
    UIViewController *source = (UIViewController *)self.sourceViewController;
    [source.navigationController setViewControllers:@[self.destinationViewController] animated:YES];
}

@end
