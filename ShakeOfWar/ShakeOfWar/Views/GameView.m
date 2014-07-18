//
//  GameView.m
//  ShakeOfWar
//
//  Created by Collin Yen on 7/17/14.
//  Copyright (c) 2014 LinkedIn. All rights reserved.
//

#import "GameView.h"

@implementation GameView

- (id)initWithFrame:(CGRect)frame
{
    NSLog(@"Initializing");
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, 100, 100)];
        testLabel.text = @"Test string";
        [self addSubview:testLabel];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end
