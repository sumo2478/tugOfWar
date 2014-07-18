//
//  ConnectionHandler.m
//  ShakeOfWar
//
//  Created by Collin Yen on 7/17/14.
//  Copyright (c) 2014 LinkedIn. All rights reserved.
//

#import "ConnectionHandler.h"
#import "Constants.h"

@implementation ConnectionHandler

- (id) init
{
    self = [super init];
    if (self) {
        self.socket = [PKJSONSocket socketWithDelegate:self];
        [self.socket connectToHost:@kServerAddress onPort:kServerPort error:nil];
        [self.socket listenOnPort:kServerPort error:nil];
    }
    return self;
}

- (void)setUpConnection
{
    NSDictionary *joinRequest = @{@"action": @1, @"name": @"Collin Yen"};
    [self sendMessage:joinRequest];
}

- (void)socket:(PKJSONSocket *)socket didReceiveMessage:(PKJSONSocketMessage *)dictionary
{
    NSLog(@"Received: %@", [dictionary dictionaryRepresentation]);
}

- (void) sendMessage:(NSDictionary *)dictionary
{
    PKJSONSocketMessage *msg = [PKJSONSocketMessage messageWithDictionary:dictionary];
    [self.socket send:msg];
}
@end
