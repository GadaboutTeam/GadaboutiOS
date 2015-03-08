//
//  TextField.m
//  GadaboutiOS
//
//  Created by David Barsky on 3/7/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "TextField.h"

@implementation TextField

-(void)layoutSubviews {
    [super layoutSubviews];
    [self setTextContainerInset:UIEdgeInsetsMake(13, 45, 0, 0)];
}

// for insetting the placeholder
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 15, 10);
}

@end
