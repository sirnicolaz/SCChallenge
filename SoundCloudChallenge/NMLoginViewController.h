//
//  NMLoginViewController.h
//  SoundCloudChallenge
//
//  Created by Nicola Miotto on 4/21/13.
//  Copyright (c) 2013 Nicola Miotto. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NMLoginDelegate <NSObject>

- (void)authenticationDidSucceed;
- (void)authenticationDidCancel;
- (void)authenticationDidFail:(NSError *)error;

@end

@interface NMLoginViewController : UIViewController

@property (assign) id<NMLoginDelegate> delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
             delegate:(id<NMLoginDelegate>)delegate;

- (IBAction)login:(id)sender;

@end
