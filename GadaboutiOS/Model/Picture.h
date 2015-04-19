//
//  Picture.h
//  GadaboutiOS
//
//  Created by Alex Bardasu on 19/04/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "RLMObject.h"

@interface Picture : RLMObject

@property (nonatomic) NSData *pictureData;
@property (nonatomic) NSString *pictureID;

@end
