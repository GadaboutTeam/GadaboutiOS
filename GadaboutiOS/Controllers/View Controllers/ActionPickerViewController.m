//
//  ActionPickerViewController.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 06/05/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "ActionPickerViewController.h"

#import <pop/POP.h>

@interface ActionPickerViewController()

@property (nonatomic, retain) UIView *splashView;

@end

@implementation ActionPickerViewController

- (void)viewDidLoad {
    [self.makePlanButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:24.0f]];
    [self.currentPlansButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:24.0f]];

    self.splashView = (UIView *)[[[NSBundle mainBundle] loadNibNamed:@"LaunchScreen" owner:self options:nil] objectAtIndex:0];
    [self.splashView setFrame:[self.view frame]];
    [self.view addSubview:self.splashView];

    [self.makePlanButton setHidden:YES];
    [self.currentPlansButton setHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
    [self fadeOutSplashScreen];
}

- (void)fadeOutSplashScreen {
    UILabel *titleLabel = (UILabel *)[[self.splashView subviews] firstObject];
    CGRect oldFrame = titleLabel.frame;
    CGRect newFrame = CGRectApplyAffineTransform(oldFrame, CGAffineTransformMakeTranslation(0, -[UIScreen mainScreen].bounds.size.height/2+titleLabel.bounds.size.height));
    [titleLabel setHidden:YES];
    [self.view addSubview:titleLabel];

    POPSpringAnimation *slideTitleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    slideTitleAnimation.fromValue = [NSValue valueWithCGRect:oldFrame];
    slideTitleAnimation.toValue = [NSValue valueWithCGRect:newFrame];
    slideTitleAnimation.springBounciness = 0;
    slideTitleAnimation.springSpeed = 1;
    [slideTitleAnimation setCompletionBlock:^(POPAnimation *animation, BOOL completed) {
        [self.makePlanButton setHidden:NO];
        [self.currentPlansButton setHidden:NO];
        [self slideInFromLeft:self.makePlanButton];
        [self slideInFromRight:self.currentPlansButton];
    }];

    POPSpringAnimation *fadeBackground = [POPSpringAnimation animationWithPropertyNamed:kPOPViewBackgroundColor];
    fadeBackground.toValue = [UIColor clearColor];
    fadeBackground.springBounciness = 0;
    fadeBackground.springSpeed = 2;
    [fadeBackground setCompletionBlock:^(POPAnimation *animation, BOOL completed) {
        [titleLabel setHidden:NO];
        [self.splashView removeFromSuperview];
        [titleLabel pop_addAnimation:slideTitleAnimation forKey:@"Slide Title"];
    }];

    [self.splashView pop_addAnimation:fadeBackground forKey:@"Fade Background"];
}

- (void)slideInFromLeft:(UIButton *)button {
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGPoint finalCenter = CGPointMake(screenBounds.size.width/2, button.center.y);
    CGPoint startingCenter = CGPointMake(-button.frame.size.width, button.center.y);
    [self translateButton:button from:startingCenter to:finalCenter];
}

- (void)slideInFromRight:(UIButton *)button {
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGPoint finalCenter = CGPointMake(screenBounds.size.width/2, button.center.y);
    CGPoint startingCenter = CGPointMake(screenBounds.size.width+button.frame.size.width, button.center.y);
    [self translateButton:button from:startingCenter to:finalCenter];
}

- (void)translateButton:(UIButton *)button from:(CGPoint)fromCenter to:(CGPoint)toCenter {
    POPSpringAnimation *translateAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    translateAnimation.fromValue = [NSValue valueWithCGPoint:fromCenter];
    translateAnimation.toValue = [NSValue valueWithCGPoint:toCenter];
    translateAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(0.8, 0.8)];
    translateAnimation.springSpeed = 1.0f;
    translateAnimation.springBounciness = 1.0f;

    [button pop_addAnimation:translateAnimation forKey:@"translateAnimation"];
}

@end
