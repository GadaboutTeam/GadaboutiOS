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
    [self setTextContainerInset:UIEdgeInsetsMake(13, 44, 0, 0)];
}

@end
