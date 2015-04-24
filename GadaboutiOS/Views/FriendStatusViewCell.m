//
//  FriendStatusViewCell.m
//  GadaboutiOS
//
//  Created by David Barsky on 4/20/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "FriendStatusViewCell.h"

@implementation FriendStatusViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [[self.profilePicture layer] setCornerRadius:self.profilePicture.frame.size.width/2];
    [[self.profilePicture layer] setMasksToBounds:YES];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsDisplay];
}

@end
