//
//  NMViewController.m
//  SoundCloudChallenge
//
//  Created by Nicola Miotto on 4/18/13.
//  Copyright (c) 2013 Nicola Miotto. All rights reserved.
//

#import "NMViewController.h"
#import "NMLoginViewController.h"

@interface NMViewController ()

@end

@implementation NMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self handleAuthentication];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Internals

- (void)handleAuthentication
{
    if([SCSoundCloud account]){
        // Authenticated
        // Show track list view controller
        NSLog(@"Authenticated");
    }
    else {
        // Not authenticated
        NMLoginViewController *loginVC = [[NMLoginViewController alloc] initWithNibName:@"NMLoginViewController"
                                                                                 bundle:nil
                                                                               delegate:self];
        [self presentModalViewController:loginVC animated:YES];
    }
}

#pragma mark - NMLoginDelegate

- (void)authenticationDidCancel
{
    
}

- (void)authenticationDidFail:(NSError *)error
{
    
}

- (void)authenticationDidSucceed
{
    [self dismissModalViewControllerAnimated:YES];
    
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Authentication succeded!", nil)
                               message:NSLocalizedString(@"You have been successfully authenticated. Enjoy!", nil)
                              delegate:nil
                     cancelButtonTitle:NSLocalizedString(@"OK", nil)
                     otherButtonTitles:nil] show];
}

@end
