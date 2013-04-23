//
//  NMTracksTableDataSource.m
//  SoundCloudChallenge
//
//  Created by Nicola Miotto on 4/21/13.
//  Copyright (c) 2013 Nicola Miotto. All rights reserved.
//

#import "NMTracksTableDataSource.h"
#import "NMTrackCell.h"

@implementation NMTracksTableDataSource

- (id)init
{
    self = [super init];
    if (self) {
        self.tracks = [NSMutableArray new];
    }
    
    return self;
}

#pragma mark - Internals

- (void)configureCell:(NMTrackCell *)cell
            withTrack:(NMTrack *)track
{
    cell.titleLabel.text          = track.title;
    cell.creationDateLabel.text   = [track.createdAt stringValueWithFormat:@"dd MMM yyyy"];
    
    NMImageManager *manager = [NMImageManager new];
    UIImage *image = [manager imageForURL:track.waveFormURL];
    if (image) {
        // If there is a cached image, no need to refetch
        cell.waveFormImage.image = image;
    }
    else {
        // If the image has not been fetched, add the background fetching operation
        // to the cell, so if the operation is still in progress when the view is
        // reused, we can stop it manually to avoid congestions
        cell.backgroundOperation = [NSBlockOperation blockOperationWithBlock:^{
            [manager fetchImageForURL:track.waveFormURL
                            withBlock:^(UIImage *image) {
                                
                                // Send it back to the main thread
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    cell.waveFormImage.hidden = YES;
                                    cell.waveFormImage.image = image;
                                    [cell.waveFormImage fadeIn];
                                });
                            }];
        }];
        [cell.backgroundOperation start];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tracks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NMTrackCell *cell = [tableView dequeueReusableCellWithIdentifier:kNMTrackCellReusableIdentifier];
    if (!cell) {
        cell = [NMTrackCell selfFromNib];
    }
    else {
        [cell prepareForReuse];
    }
    
    NMTrack *track = [self.tracks objectAtIndex:indexPath.row];
    [self configureCell:cell withTrack:track];
    
    return cell;
}

@end
