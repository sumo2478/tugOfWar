//
//  DataPoints.h
//  ShakeOfWar
//
//  Created by Collin Yen on 7/17/14.
//  Copyright (c) 2014 LinkedIn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataPoints : NSObject

@property double y;

@property long atTimeMilliseconds;

- (id) initWithY:(double) y Time:(long)milliSeconds;

@end
