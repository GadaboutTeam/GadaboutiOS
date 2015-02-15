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
    UIViewController *destination = (UIViewController *)self.destinationViewController;
    destination.view.layer.opacity = 0.0f; //Initially the new view controller is transparent

    // Define Animations
    POPSpringAnimation *sourceAnimation = [POPSpringAnimation animation];
    sourceAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    sourceAnimation.toValue = [NSValue valueWithCGRect:CGRectOffset(source.view.frame, 0.0, source.view.frame.size.height)];
    sourceAnimation.springBounciness = 2.0f;
    sourceAnimation.springSpeed = 7.0f;
    sourceAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            [source.navigationController setViewControllers:@[self.destinationViewController] animated:YES];
        }
    };

    POPBasicAnimation *fadeOutAnimation = [POPBasicAnimation animation];
    fadeOutAnimation.property = [POPAnimatableProperty propertyWithName:kPOPLayerOpacity];
    fadeOutAnimation.toValue = @(0.0f);

    POPBasicAnimation *fadeInAnimation = [POPBasicAnimation animation];
    fadeInAnimation.property = [POPAnimatableProperty propertyWithName:kPOPLayerOpacity];
    fadeInAnimation.toValue = @(1.0f);

    [source.view pop_addAnimation:sourceAnimation forKey:@"moveOffScreen"];
    [source.view.layer pop_addAnimation:fadeOutAnimation forKey:@"moveOffScreen"];
    [destination.view.layer pop_addAnimation:fadeInAnimation forKey:@"moveOffScreen"];
}

@end
