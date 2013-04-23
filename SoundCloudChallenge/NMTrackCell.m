//
//  NMTrackCell.m
//  SoundCloudChallenge
//
//  Created by Nicola Miotto on 4/22/13.
//  Copyright (c) 2013 Nicola Miotto. All rights reserved.
//

#import "NMTrackCell.h"

NSString *const kNMTrackCellReusableIdentifier = @"NMTrackCell";

@implementation NMTrackCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *)reuseIdentifier
{
    return kNMTrackCellReusableIdentifier;
}

- (void)prepareForReuse
{
    [self.backgroundOperation cancel];
    self.waveFormImage.image = nil;
    self.titleLabel.text = nil;
    self.creationDateLabel.text = nil;
}

@end
