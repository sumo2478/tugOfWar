//
//  ConnectionHandler.h
//  ShakeOfWar
//
//  Created by Collin Yen on 7/17/14.
//  Copyright (c) 2014 LinkedIn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKJSONSocket.h"

@interface ConnectionHandler : NSObject <PKJSONSocketDelegate>

@property (nonatomic, strong) PKJSONSocket *socket;

- (void)setUpConnection;

- (void) sendMessage:(NSDictionary *)dictionary;

@end
