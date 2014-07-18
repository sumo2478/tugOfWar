//
//  GameView.m
//  ShakeOfWar
//
//  Created by Collin Yen on 7/17/14.
//  Copyright (c) 2014 LinkedIn. All rights reserved.
//

#import "GameView.h"

@implementation GameView

@synthesize flash;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rope.jpg"]];

        flash = [[UIView alloc] initWithFrame:self.frame];
        [self addSubview:flash];
    }
    return self;
}

- (void) showFlash:(NSInteger)score GreenPlayer:(BOOL)greenPlayer {
    [self.flash setAlpha:1.0];
    if ((score >= 0 && greenPlayer) || (score <= 0 && !greenPlayer)) {
        [self.flash setBackgroundColor:[UIColor greenColor]];
    }else {
        [self.flash setBackgroundColor:[UIColor redColor]];
    }
}

@end
