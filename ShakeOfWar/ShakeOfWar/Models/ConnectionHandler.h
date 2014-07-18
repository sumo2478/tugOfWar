//
//  ConnectionHandler.h
//  ShakeOfWar
//
//  Created by Collin Yen on 7/17/14.
//  Copyright (c) 2014 LinkedIn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKJSONSocket.h"

@interface ConnectionHandler : NSObject <NSStreamDelegate>

- (void)setUpConnectionWithName:(NSString *)name;

- (void)sendTug;

@end
