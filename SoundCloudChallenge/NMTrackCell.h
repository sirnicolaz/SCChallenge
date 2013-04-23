//
//  NMTrackCell.h
//  SoundCloudChallenge
//
//  Created by Nicola Miotto on 4/22/13.
//  Copyright (c) 2013 Nicola Miotto. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kNMTrackCellReusableIdentifier;

@interface NMTrackCell : UITableViewCell

@property IBOutlet UILabel      *titleLabel;
@property IBOutlet UILabel      *creationDateLabel;
@property IBOutlet UIImageView  *waveFormImage;

@property NSBlockOperation *backgroundOperation;

@end
