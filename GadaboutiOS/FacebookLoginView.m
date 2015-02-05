//
//  FBLoginView.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 03/02/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "FacebookLoginView.h"

@implementation FacebookLoginView
@synthesize welcomeLabel;
@synthesize fbLoginView;
@synthesize menuButton;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)aRect {
    self = [super initWithFrame:aRect];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];

    return self;
}

- (void)setupLayout {
    [menuButton setImageTintColor:[UIColor grayColor] forState:UIControlStateNormal];
    [menuButton setImageTintColor:[UIColor blackColor] forState:UIControlStateHighlighted];
}

- (void)runAnimations {
    [self animateWelcomeLabel];
    [self animateLoginButton];
}

- (void)animateWelcomeLabel {
    //Pulse Animation
    POPSpringAnimation *pulse = [POPSpringAnimation animation];
    pulse.property = [POPAnimatableProperty propertyWithName:kPOPLayerScaleXY];
    pulse.toValue = [NSValue valueWithCGPoint:CGPointMake(1.5, 1.5)];
    pulse.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
    pulse.springBounciness = 18.0;
    pulse.springSpeed = 8.0;

    //FadeIn Animation
    POPBasicAnimation *fadeIn = [POPBasicAnimation animation];
    fadeIn.property = [POPAnimatableProperty propertyWithName:kPOPLayerOpacity];
    fadeIn.toValue = @(1.0);
    fadeIn.duration = 0.5;

    [welcomeLabel.layer pop_addAnimation:fadeIn forKey:@"fadeInAnimation"];
    [welcomeLabel.layer pop_addAnimation:pulse forKey:@"pulseAnimation"];
}

- (void)animateLoginButton {
    //FadeInAnimation
    POPBasicAnimation *fadeIn = [POPBasicAnimation animation];
    fadeIn.property = [POPAnimatableProperty propertyWithName:kPOPLayerOpacity];
    fadeIn.toValue = @(1.0);
    fadeIn.duration = 1;

    [fbLoginView.layer pop_addAnimation:fadeIn forKey:@"fadeInAnimation"];
}

@end
