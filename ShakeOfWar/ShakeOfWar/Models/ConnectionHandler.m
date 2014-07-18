//
//  ConnectionHandler.m
//  ShakeOfWar
//
//  Created by Collin Yen on 7/17/14.
//  Copyright (c) 2014 LinkedIn. All rights reserved.
//

#import "ConnectionHandler.h"
#import "Constants.h"

@interface ConnectionHandler()

@property (nonatomic, strong) NSInputStream *inputStream;
@property (nonatomic, strong) NSOutputStream *outputStream;

@end

@implementation ConnectionHandler

- (void)setUpConnectionWithName:(NSString *)name
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{

        CFReadStreamRef readStream;
        CFWriteStreamRef writeStream;

        CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@kServerAddress, 23316, &readStream, &writeStream);

        self.inputStream = (__bridge NSInputStream *)readStream;
        self.outputStream = (__bridge NSOutputStream *) writeStream;

        [self.inputStream setDelegate:self];
        [self.outputStream setDelegate:self];

        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            [self.outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        });

        [self.inputStream open];
        [self.outputStream open];


        NSString *response = [NSString stringWithFormat:@"{\"action\":1, \"name\":\"%@\"}", name];
        NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
        [self.outputStream write:[data bytes] maxLength:[data length]];
    });
}

- (void) closeConnections
{
    CFReadStreamRef readStream = (__bridge CFReadStreamRef)(self.inputStream);
    CFWriteStreamRef outputStream = (__bridge CFWriteStreamRef)(self.outputStream);


    CFReadStreamClose(readStream);
    CFWriteStreamClose(outputStream);
}

- (void)sendTug
{
    NSString *response = [NSString stringWithFormat:@"{\"action\":3}"];
    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
    [self.outputStream write:[data bytes] maxLength:[data length]];
}

- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
	switch (streamEvent) {

		case NSStreamEventHasBytesAvailable:
			if (theStream == self.inputStream) {

                uint8_t buffer[1024];
                int len;

                while ([self.inputStream hasBytesAvailable]) {

                    len = [self.inputStream read:buffer maxLength:(NSUInteger)sizeof(buffer)];
                    if (len > 0) {

                        NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];

                        if (nil != output) {
                            [self messageReceived:output];
                        }
                    }
                }
            }

		case NSStreamEventEndEncountered:
			break;
            
		default:
            break;
	}
}

- (void) messageReceived:(NSString *)message {
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:[message dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"Response: %@", response);
    switch ([[response objectForKey:@"action"] intValue]) {
        case kResponseJoin:
        {
            NSLog(@"%@ joined your game", [response objectForKey:@"opponent_name"]);
            [self.delegate handleJoinGame:[response objectForKey:@"opponent_name"]];

            break;
        }
        case kResponseWaiting:
        {
            NSLog(@"Waiting for opponent...");
            [self.delegate handleWaiting];
            break;
        }
        case kResponseTug:
        {
            NSLog(@"Score: %d", [[response objectForKey:@"score"] intValue]);
            [self.delegate handleScoreUpdate:[[response objectForKey:@"score"] intValue]];
            break;
        }
        case kResponseDisconnect:
        {
            NSLog(@"Disconnected from game server");
            [self.delegate handleDisconnect];
            break;
        }
        case kResponseWin:
        {
            NSLog(@"Won the game");
            [self.delegate handleEndGameWithWin:YES];
            break;
        }
        case kResponseLose:
        {
            NSLog(@"Lost the game");
            [self.delegate handleEndGameWithWin:NO];
            break;
        }
        default:
            break;
    }
}
@end
