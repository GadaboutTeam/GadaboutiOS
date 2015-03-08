//
//  TextField.m
//  GadaboutiOS
//
//  Created by David Barsky on 3/7/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "TextField.h"

@implementation TextField

static const CGFloat VENTokenFieldDefaultVerticalInset      = 7.0;
static const CGFloat VENTokenFieldDefaultHorizontalInset    = 15.0;
static const CGFloat VENTokenFieldDefaultToLabelPadding     = 5.0;
static const CGFloat VENTokenFieldDefaultTokenPadding       = 2.0;
static const CGFloat VENTokenFieldDefaultMinInputWidth      = 80.0;
static const CGFloat VENTokenFieldDefaultMaxHeight          = 150.0;

-(void)layoutSubviews {
    [super layoutSubviews];
}

// for insetting the placeholder
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 15, 10);
}

@end
