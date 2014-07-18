//
//  BaseViewController.h
//  ShakeOfWar
//
//  Created by Collin Yen on 7/17/14.
//  Copyright (c) 2014 LinkedIn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionHandler.h"
#import "MBProgressHUD.h"

@interface BaseViewController : UIViewController <ConnectionHandlerDelegate>

@property (nonatomic, strong) ConnectionHandler *connectionHandler;

- (void)handleJoinGame:(NSString *)name;

- (void)handleWaiting;

- (void)handleScoreUpdate:(NSInteger) score;

- (void)showAlertWithTitle:(NSString *)title Label:(NSString *)label WithDelay:(BOOL) withDelay;

- (void)hideHUD;

@end
