//
//  LobbyViewController.m
//  ShakeOfWar
//
//  Created by Collin Yen on 7/17/14.
//  Copyright (c) 2014 LinkedIn. All rights reserved.
//

#import "LobbyViewController.h"
#import "GameViewController.h"
#import "ConnectionHandler.h"

@interface LobbyViewController ()

@end

@implementation LobbyViewController

@synthesize nameTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone; 

    self.connectionHandler = [[ConnectionHandler alloc] init];
    [self.connectionHandler setDelegate:self];
    [self.nameTextField setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)joinLobby:(id)sender
{
    [self.connectionHandler setUpConnectionWithName:nameTextField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)handleJoinGame:(NSString *)name
{
    GameViewController *gameController = [GameViewController new];
    gameController.connectionHandler = [self connectionHandler];
    gameController.opponentName = name;
    [self presentViewController:gameController animated:YES completion:nil];
}

- (void)handleWaiting
{
    [self showAlertWithTitle:@"Waiting" Label:@"Waiting for opponent..." WithDelay:NO];
    [self.nameTextField resignFirstResponder];
}

@end
