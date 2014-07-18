//
//  LobbyViewController.h
//  ShakeOfWar
//
//  Created by Collin Yen on 7/17/14.
//  Copyright (c) 2014 LinkedIn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LobbyViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *nameTextField;

- (IBAction)joinLobby:(id)sender;

@end
