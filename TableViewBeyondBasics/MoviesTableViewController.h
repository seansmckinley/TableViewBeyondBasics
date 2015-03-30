//
//  MoviesTableViewController.h
//  CS470Feb27
//
//  Created by AAK on 2/27/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//
//  Edited by Sean McKinley

#import <UIKit/UIKit.h>
#import "MoviesDataSource.h"

@interface MoviesTableViewController : UITableViewController<MoviesDataSourceReadyForUseDelegate,UITableViewDelegate,UITableViewDataSource>
    @property (nonatomic, retain) NSString *theater_namem;
@end
