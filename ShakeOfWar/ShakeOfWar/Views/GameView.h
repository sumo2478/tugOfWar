//
//  GameView.h
//  ShakeOfWar
//
//  Created by Collin Yen on 7/17/14.
//  Copyright (c) 2014 LinkedIn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameView : UIView

@property (nonatomic, strong) UIView *flash;

- (void) showFlash:(NSInteger)score GreenPlayer:(BOOL)greenPlayer;

@end
