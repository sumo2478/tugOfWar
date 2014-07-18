//
//  LobbyViewController.m
//  ShakeOfWar
//
//  Created by Collin Yen on 7/17/14.
//  Copyright (c) 2014 LinkedIn. All rights reserved.
//

#import "LobbyViewController.h"
#import "ConnectionHandler.h"

@interface LobbyViewController ()

@property (nonatomic, strong) ConnectionHandler *connectionHandler;

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

@end
