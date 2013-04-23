//
//  NMViewController.h
//  SoundCloudChallenge
//
//  Created by Nicola Miotto on 4/18/13.
//  Copyright (c) 2013 Nicola Miotto. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NMTracksTableDataSource;

@interface NMTracksViewController : UIViewController<UITableViewDelegate>

@property UITableView               *tableView;
@property NMTracksTableDataSource   *dataSource;

@end
