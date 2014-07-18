//
//  ConnectionHandler.h
//  ShakeOfWar
//
//  Created by Collin Yen on 7/17/14.
//  Copyright (c) 2014 LinkedIn. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ConnectionHandlerDelegate <NSObject>
@optional
- (void)handleJoinGame:(NSString *)name;

- (void)handleWaiting;

- (void)handleScoreUpdate:(NSInteger) score;
@end

@interface ConnectionHandler : NSObject <NSStreamDelegate>

@property (weak) id <ConnectionHandlerDelegate> delegate;

- (void)setUpConnectionWithName:(NSString *)name;

- (void)sendTug;

@end
