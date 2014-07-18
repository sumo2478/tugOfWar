//
//  BaseViewController.m
//  ShakeOfWar
//
//  Created by Collin Yen on 7/17/14.
//  Copyright (c) 2014 LinkedIn. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

@synthesize connectionHandler;

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
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleJoinGame:(NSString *)name
{
    NSLog(@"Shouldn't be called");
    // To be handled by subclass
}

- (void)handleWaiting
{
    // To be handled by subclass
}

- (void)handleScoreUpdate:(NSInteger) score
{
    // To be handled by subclass
}

- (void)showAlertWithTitle:(NSString *)title Label:(NSString *)label WithDelay:(BOOL) withDelay
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];

	HUD.labelText = title;
	HUD.detailsLabelText = label;
	HUD.square = YES;

    [HUD show:YES];
    if (withDelay) {
        [HUD hide:YES afterDelay:2.5f];
    }

}

@end
