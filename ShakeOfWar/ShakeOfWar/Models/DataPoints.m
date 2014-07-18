//
//  DataPoints.m
//  ShakeOfWar
//
//  Created by Collin Yen on 7/17/14.
//  Copyright (c) 2014 LinkedIn. All rights reserved.
//

#import "DataPoints.h"

@implementation DataPoints

- (id) initWithY:(double) y Time:(long)milliSeconds
{
    self = [super init];
    if (self) {
        self.y = y;
        self.atTimeMilliseconds = milliSeconds;
    }
    return self;
}

@end
