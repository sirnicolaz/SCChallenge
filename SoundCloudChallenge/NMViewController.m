//
//  NMViewController.m
//  SoundCloudChallenge
//
//  Created by Nicola Miotto on 4/18/13.
//  Copyright (c) 2013 Nicola Miotto. All rights reserved.
//

#import "NMViewController.h"
#import "NMLoginView.h"

@interface NMViewController ()

@end

@implementation NMViewController
{
    NMLoginView *__loginView;
}

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
        __loginView = [NMLoginView selfFromNib];
        __loginView.frame = self.view.bounds;
        [__loginView.loginButton addTarget:self
                                  action:@selector(login:)
                        forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:__loginView];
    }
}

#pragma mark - Login managmenet

- (void)handleError:(NSError *)error
{
    NSString *message;
    if (SC_CANCELED(error)) {
        message = NSLocalizedString(@"Login canceled", nil);
    }
    else {
        message = [NSString stringWithFormat:NSLocalizedString(@"Error during authentication: %@", nil), error.localizedDescription];
    }
    
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Authentication failed", nil)
                               message:message
                              delegate:nil
                     cancelButtonTitle:NSLocalizedString(@"OK", nil)
                     otherButtonTitles:nil]
    show];
}

- (void)handleSuccess
{
    
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Authentication succeded!", nil)
                                message:NSLocalizedString(@"You have been successfully authenticated. Enjoy!", nil)
                               delegate:nil
                      cancelButtonTitle:NSLocalizedString(@"OK", nil)
                      otherButtonTitles:nil] show];
    
    // Dismiss login view
    [__loginView removeFromSuperview];
}

#pragma mark - Actions

- (IBAction)login:(id)sender
{
    SCLoginViewControllerCompletionHandler handler = ^(NSError *error) {
        error ? [self handleError:error] : [self handleSuccess];
    };
    
    [SCSoundCloud requestAccessWithPreparedAuthorizationURLHandler:^(NSURL *preparedURL) {
        SCLoginViewController *loginViewController;
        
        loginViewController = [SCLoginViewController
                               loginViewControllerWithPreparedURL:preparedURL
                               completionHandler:handler];
        [self presentModalViewController:loginViewController animated:YES];
    }];
}


@end
