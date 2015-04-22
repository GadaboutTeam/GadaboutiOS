//
//  ActionButton.h
//  GadaboutiOS
//
//  Created by David Barsky on 4/20/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface ActionButton : UIButton

// Enums aren’t supported by IB, but booleans are. Ugly workaround.
@property IBInspectable (nonatomic) BOOL isAffirmative;

@end
