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

    UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    [backgroundView setBackgroundColor:[UIColor blueColor]];
    [backgroundView setAlpha:0.5];
    [self setSelectedBackgroundView:backgroundView];

    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    if ([self isHighlighted]) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetRGBFillColor(context, 1, 0, 0, 1);
        CGContextFillRect(context, self.bounds);
    }
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];

    if ([self isSelected]) {
        
    } else {

    }
    [self setNeedsDisplay];
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
}

- (void)animateOnTap {
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.9, 0.9)];
    springAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
    springAnimation.springBounciness = 20.0f;
    [self.viewForBaselineLayout pop_addAnimation:springAnimation forKey:@"BounceOnTap"];
}

- (void)prepareForReuse {
    [self setCellState:CellStateDeselected];
}

- (void)setCellState:(CellState)cellState {
    self.state = cellState;
}

- (CellState)cellState {
    return self.state;
}

@end
