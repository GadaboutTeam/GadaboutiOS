//
//  TokenField.m
//  GadaboutiOS
//
//  Created by David Barsky on 3/7/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "TokenField.h"

@implementation TokenField

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupAppearence];
}

- (void)setupAppearence {
    CGFloat borderWidth = 0.5f;

    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1].CGColor;
}

@end
