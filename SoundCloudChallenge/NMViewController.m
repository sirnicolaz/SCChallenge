//
//  NMViewController.m
//  SoundCloudChallenge
//
//  Created by Nicola Miotto on 4/18/13.
//  Copyright (c) 2013 Nicola Miotto. All rights reserved.
//

#import "NMViewController.h"
#import "NMLoginView.h"
#import "NMTracksTableDataSource.h"

#define kNMTracksLimit 4

@interface NMViewController ()

@end

@implementation NMViewController
{
    NMLoginView             *__loginView;
    NMTracksManager         *__manager;
    NMTrack                 *__lastLoadedTrack;
    UIActivityIndicatorView *__activityIndicator;
    BOOL                     __allLoaded;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    __allLoaded = NO;
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

#pragma mark - View setup

- (void)setupTitle:(NSString *)title
      withSubTitle:(NSString *)subTitle
{
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.frame = CGRectMake(0, 0, 250, 22);
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = title;
    
    UILabel *subtitleLabel = [UILabel new];
    subtitleLabel.font = [UIFont systemFontOfSize:11];
    subtitleLabel.backgroundColor = [UIColor clearColor];
    subtitleLabel.frame = CGRectMake(0, CGRectGetMaxY(titleLabel.frame), titleLabel.frame.size.width, 18);
    subtitleLabel.textAlignment = UITextAlignmentCenter;
    subtitleLabel.textColor = [UIColor whiteColor];
    subtitleLabel.text = subTitle;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(SCR_SIZE.width / 2 - titleLabel.frame.size.width / 2,
                                                                 0, titleLabel.frame.size.width, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [titleView addSubview:titleLabel];
    [titleView addSubview:subtitleLabel];
    
    self.navigationItem.titleView = titleView;
}

- (void)setupTracksView
{
    self.dataSource = [NMTracksTableDataSource new];
    //CGRect tableViewFrame = CGRectMake(0, 0, SCR_SIZE.width, SCR_SIZE.height);
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.rowHeight = 126;
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    
    // Footer for showing loader
    __activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, SCR_SIZE.width, 44)];
    __activityIndicator.hidesWhenStopped = YES;
    __activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [__activityIndicator startAnimating];
    self.tableView.tableFooterView = __activityIndicator;
    
    NSOperationQueue *queue = [NSOperationQueue new];
    queue.name = @"Waves Download Queue";
    queue.maxConcurrentOperationCount = 1;
    self.tableView.queue = queue;
    __manager = [NMTracksManager new];
}

- (void)setupLoginView
{
    __loginView = [NMLoginView selfFromNib];
    __loginView.frame = self.view.bounds;
    [__loginView.loginButton addTarget:self
                                action:@selector(login:)
                      forControlEvents:UIControlEventTouchUpInside];
}

- (void)setLoginVisible:(BOOL)visible
{
    // Dismiss login view
    if (!visible) {
        [__loginView removeFromSuperview];
        
        [self setupTracksView];
        
        // Show tracks table
        [self.view addSubview:self.tableView];
        
        // Set title
        [self setupTitle:NSLocalizedString(@"Logged in as", nil) withSubTitle:[SCSoundCloud account].identifier];
    }
    else {
        [self.tableView removeFromSuperview];
        
        [self setupLoginView];
        
        // Show login view
        [self.view addSubview:__loginView];
        
        // Set title
        [self setupTitle:NSLocalizedString(@"Not authenticated", nil) withSubTitle:NSLocalizedString(@"tap the login button to authenticate", nil)];
    }
}

#pragma mark - Logic

- (void)loadTrackFromOffset:(NSInteger)offset
{
    FetchResultBlock handler;
    handler = ^(NSArray *tracks, NSError *error){
        if (tracks.count == 0) {
            __allLoaded = YES;
            self.tableView.tableFooterView = nil;
        }
        else {
            [self.dataSource.tracks addObjectsFromArray:tracks];
            [self.tableView reloadData];
        }
    };
    
    [__manager fetchTracksWithOffset:offset limit:kNMTracksLimit block:handler];
}

- (void)handleAuthentication
{
    if([SCSoundCloud account]){
        /* Authenticated */
        [self setLoginVisible:NO];
        
        // Fetch tracks
        [self loadTrackFromOffset:0];
    }
    else {
        /* Not authenticated */
        [self setLoginVisible:YES];
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
    
    [self setLoginVisible:NO];
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

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIApplication *app = [UIApplication sharedApplication];
    NMTrack *track = [self.dataSource.tracks objectAtIndex:indexPath.row];
    NSString *soundCloudURLString = [NSString stringWithFormat:@"soundcloud:tracks:%d", track.identifier];
    NSURL *soundcloudURL = URL(soundCloudURLString);
    if ([app canOpenURL:soundcloudURL]) {
        [app openURL:soundcloudURL];
    }
    else {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"SoundCloud not found", nil) message:NSLocalizedString(@"You need to install the SoundCloud app in order to listen to you tracks.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!__allLoaded) {
        [self loadTrackFromOffset:self.dataSource.tracks.count];
    }
}

@end
