//
//  PushStoryBoardSegue.h
//  GadaboutiOS
//
//  Created by Alex Bardasu on 03/02/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <pop/POP.h>

@interface PushStoryBoardSegue : UIStoryboardSegue
+ (UIViewController *)sceneNamed:(NSString *)identifier;
@end
