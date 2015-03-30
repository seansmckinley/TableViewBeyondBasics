//
//  TheatersTableViewController.h
//  TableViewBeyondBasics
//
//  Created by Sean McKinley on 3/26/15.
//  Copyright (c) 2015 Ali Kooshesh. All rights reserved.
//
//  Edited by Sean McKinley

#import <UIKit/UIKit.h>
#import "TheatersDataSource.h"

@interface TheatersTableViewController : UITableViewController<TheatersDataSourceReadyForUseDelegate,UITableViewDelegate,UITableViewDataSource>
    @property (nonatomic, retain) NSString *theater_name;
    
@end
