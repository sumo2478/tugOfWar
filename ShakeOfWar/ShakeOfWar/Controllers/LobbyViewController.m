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

@property BOOL greenPlayer;

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

- (void) viewDidAppear:(BOOL)animated
{
    [self.connectionHandler setDelegate:self];
    self.greenPlayer = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)joinLobby:(id)sender
{
    [self showAlertWithTitle:@"Waiting" Label:@"Waiting for opponent..." WithDelay:NO];
    [self.connectionHandler setUpConnectionWithName:nameTextField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)handleJoinGame:(NSString *)name
{
    NSLog(@"Handle Join");
    [self hideHUD];
    GameViewController *gameController = [[GameViewController alloc] init];
    gameController.connectionHandler = [self connectionHandler];
    [gameController.connectionHandler setDelegate:gameController];
    gameController.opponentName = name;
    gameController.greenPlayer = self.greenPlayer;
    [self presentViewController:gameController animated:YES completion:nil];
}

- (void)handleWaiting
{
    self.greenPlayer = YES;
    [self.nameTextField resignFirstResponder];
}

@end
