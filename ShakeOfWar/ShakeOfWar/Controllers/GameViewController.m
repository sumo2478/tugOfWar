//
//  GameViewController.m
//  ShakeOfWar
//
//  Created by Collin Yen on 7/17/14.
//  Copyright (c) 2014 LinkedIn. All rights reserved.
//

#import "GameViewController.h"

#import "GameView.h"
#import "DataPoints.h"
#import "ConnectionHandler.h"
#import <CoreMotion/CoreMotion.h>

@interface GameViewController ()

@property (nonatomic, strong) GameView *gameView;

@property CMAcceleration lastAcceleration;
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, strong) NSOperationQueue *queue;
@property NSInteger counter;
@property (nonatomic, strong) NSMutableArray *dataPoints;
@property long long lastShake, lastUpdate;

@property float last_y;

@end

@implementation GameViewController

@synthesize opponentName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.gameView = [[GameView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.gameView];
    [self becomeFirstResponder];

    self.dataPoints = [NSMutableArray array];

    self.motionManager = [[CMMotionManager alloc] init];

    self.queue = [NSOperationQueue currentQueue];

    [self.motionManager startAccelerometerUpdatesToQueue:self.queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
        CMAccelerometerData *accelerationData = [self.motionManager accelerometerData];
        [self didAccelerate:accelerationData.acceleration];
    }];
}

- (void) viewDidAppear:(BOOL)animated
{
    [self showAlertWithTitle:@"Connected!" Label:[NSString stringWithFormat:@"%@ has joined the game", self.opponentName] WithDelay:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#define kIgnoreEventAfterShakes 50
#define kShakeCheckThreshold 0.5
#define kKeepDataPointsFor 300
#define kPositiveCounterThreshhold 1
#define kNegativeCounterThreshold -1
#define kMinimumEachDirection 1

#pragma mark Motion Controls

- (long long) currentTimeInMilliSeconds
{
    long long val =  [[NSDate date] timeIntervalSince1970] * -1000;
    return val * -1;
}

- (BOOL) accelerationIsShaking:(CMAcceleration) last Current:(CMAcceleration) current threshhold:(double) threshold {
    long long currTime = [self currentTimeInMilliSeconds];

    if (self.lastShake != 0 && (currTime - self.lastShake) < kIgnoreEventAfterShakes) {

        return NO;
    }

    double y = current.y;

    BOOL shake = NO;
    if (self.last_y != 0 && self.last_y != y) {
        DataPoints *dp = [[DataPoints alloc] initWithY:(self.last_y - y) Time:currTime];
        [self.dataPoints addObject:dp];

        if ((currTime - self.lastUpdate) > kShakeCheckThreshold) {
            self.lastUpdate = currTime;
            shake = [self checkForShake];
        }
    }

    self.last_y = y;

    return shake;
}

- (BOOL) checkForShake
{
    long long currTime = [self currentTimeInMilliSeconds];
    long long cutOffTime = currTime - kKeepDataPointsFor;

    DataPoints *latestDP = [self.dataPoints objectAtIndex:0];
    while ([self.dataPoints count] > 0 && latestDP.atTimeMilliseconds < cutOffTime) {
        [self.dataPoints removeObjectAtIndex:0];
    }

    int y_pos = 0, y_neg = 0, y_dir = 0;

    for (DataPoints *dp in self.dataPoints) {
        if (dp.y > kPositiveCounterThreshhold && y_dir < 1) {
            ++y_pos;
            y_dir = 1;
        }
        if (dp.y < kNegativeCounterThreshold && y_dir > -1) {
            ++y_neg;
            y_dir = -1;
        }
    }

    if (y_pos >= kMinimumEachDirection && y_neg >= kMinimumEachDirection) {
        self.lastShake = [self currentTimeInMilliSeconds];
        self.last_y = 0;
        [self.dataPoints removeAllObjects];
        return YES;
    }

    return NO;
}

- (void) didAccelerate:(CMAcceleration)acceleration {
	if (self.lastAcceleration.y != 0 || self.lastAcceleration.y != acceleration.y) {
		if ([self accelerationIsShaking:self.lastAcceleration Current:acceleration threshhold:1.0]) {

			/* SHAKE DETECTED. DO HERE WHAT YOU WANT. */
            NSLog(@"Shake Detected: %ld", (long)self.counter);
            self.counter++;

            [self.connectionHandler sendTug];
        }
    }

    self.lastAcceleration = acceleration;
}

@end
