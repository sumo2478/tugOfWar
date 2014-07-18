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

//- (id) init
//{
//    self = [super init];
//    if (self) {
//
//    }
//    return self;
//}

- (void)setUpConnectionWithName:(NSString *)name
{
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;

    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@kServerAddress, 23316, &readStream, &writeStream);

    self.inputStream = (__bridge NSInputStream *)readStream;
    self.outputStream = (__bridge NSOutputStream *) writeStream;

    [self.inputStream setDelegate:self];
    [self.outputStream setDelegate:self];

    [self.inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];

    [self.inputStream open];
    [self.outputStream open];

    NSString *response = [NSString stringWithFormat:@"{\"action\":1, \"name\":\"%@\"}", name];
    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
    [self.outputStream write:[data bytes] maxLength:[data length]];
}

- (void)sendTug
{
    NSString *response = [NSString stringWithFormat:@"{\"action\":3}"];
    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
    [self.outputStream write:[data bytes] maxLength:[data length]];
}
@end
