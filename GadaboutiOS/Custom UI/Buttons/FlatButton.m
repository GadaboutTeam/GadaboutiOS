//
//  GhostButton.m
//  GadaboutiOS
//
//  Created by David Barsky on 2/24/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "FlatButton.h"
#import <pop/POP.h>

@implementation FlatButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setupAppearence];
    [self animationSetup];
}

#pragma mark - UIButton Overrides

- (void)setupAppearence {
    // border
    [self.layer setCornerRadius: 20.0f];

    if([self isEnabled]) {
        [self setEnabledState];
    } else {
        [self setDisabledState];
    }
    
    // font
    self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17.0f];
    self.titleLabel.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
}

#pragma mark - Button State
- (void)setDisabledState {
    self.backgroundColor = [UIColor colorWithRed:0.99 green:0.33 blue:0.33 alpha:0.7];
}

- (void)setEnabledState {
    [self setBackgroundColor:[UIColor colorWithRed:0.25 green:0.62 blue:0.85 alpha:1]];
    self.titleLabel.textColor = [UIColor whiteColor];
}

#pragma mark - Animations

- (void)touchUpInside:(FlatButton *)button {
    
}

- (void)animationSetup {
    [self addTarget:self action:@selector(scaleToSmall) forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    [self addTarget:self action:@selector(scaleAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(scaleToDefault) forControlEvents:UIControlEventTouchDragExit];
}

- (void)scaleToSmall {
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.95f, 0.95f)];
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSmallAnimation"];
}

- (void)scaleAnimation {
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.velocity = [NSValue valueWithCGSize:CGSizeMake(3.f, 3.f)];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    scaleAnimation.springBounciness = 18.0f;
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSpringAnimation"];
}

- (void)scaleToDefault {
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleDefaultAnimation"];
}

@end
