//
//  FriendCell.m
//  GadaboutiOS
//
//  Created by David Barsky on 3/27/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "FriendCell.h"

#import <pop/POP.h>

@interface FriendCell()
@property (nonatomic) CellState state;
@end

@implementation FriendCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.state = CellStateDeselected;

    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [[self.profilePictureView layer] setCornerRadius:self.profilePictureView.frame.size.width/2];
    [[self.profilePictureView layer] setMasksToBounds:YES];
    [self.profilePictureView.layer setBorderWidth:3.0];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];

    if (selected) {
        [self.profilePictureView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    } else {
        [self animateOnTap];
        [self.profilePictureView.layer setBorderColor:[[UIColor clearColor] CGColor]];
    }

    [self setNeedsDisplay];
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted) {
        [self animateOnTap];
    }
}

- (void)animateOnTap {
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
    springAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
    springAnimation.springBounciness = 20.0f;

    [self.viewForBaselineLayout pop_addAnimation:springAnimation forKey:@"BounceOnTap"];
}

- (void)prepareForReuse {

}

@end
