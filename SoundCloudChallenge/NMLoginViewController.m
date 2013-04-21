//
//  NMLoginViewController.m
//  SoundCloudChallenge
//
//  Created by Nicola Miotto on 4/21/13.
//  Copyright (c) 2013 Nicola Miotto. All rights reserved.
//

#import "NMLoginViewController.h"

@interface NMLoginViewController ()

@end

@implementation NMLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
             delegate:(id<NMLoginDelegate>)delegate
{
    self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.delegate = delegate;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)login:(id)sender
{
    SCLoginViewControllerCompletionHandler handler = ^(NSError *error) {
        
        if (![self.delegate conformsToProtocol:@protocol(NMLoginDelegate)])
            return;
        
        if (SC_CANCELED(error)) {
            [self.delegate authenticationDidCancel];
        } else if (error) {
            [self.delegate authenticationDidFail:error];
        } else {
            [self.delegate authenticationDidSucceed];
        }
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
