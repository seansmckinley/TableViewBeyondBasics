//
//  MoviesATTableViewController.h
//  TableViewBeyondBasics
//
//  Created by Sean McKinley on 3/27/15.
//  Copyright (c) 2015 Ali Kooshesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviesATTableViewController : UITableViewController<MoviesATDataSourceReadyForUseDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain) NSString *theater_namem;
@end
