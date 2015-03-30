//
//  MoviesTableViewController.m
//  CS470Feb27
//
//  Created by AAK on 2/27/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "MoviesATTableViewController.h"
#import "MoviesATDataSource.h"

@interface MoviesATTableViewController ()

@property(nonatomic) MoviesATDataSource *dataSource;
@property(nonatomic) UIActivityIndicatorView *activityIndicator;


@end

enum { MOVIE_VIEW_HEIGHT = 90, GAP_BTWN_VIEWS = 5, IMAGE_HEIGHT = 80, IMAGE_WIDTH = 80 };

static NSString *CellIdentifier = @"Cell";

@implementation MoviesATTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    self.title = @"Movies";
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    NSString *moviesURLString = @"http://www.cs.sonoma.edu/~mckinley/movies/dbInterface.py?rType=moviesAtTheaters";
    
    self.dataSource = [[MoviesATDataSource alloc] initWithMoviesAtURLString:moviesURLString];
    //    [self.dataSource setDelegate: self];
    self.dataSource.delegate = self;
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refreshTableView:) forControlEvents:UIControlEventValueChanged];
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.activityIndicator setCenter: self.view.center];
    [self.view addSubview: self.activityIndicator];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dataSourceReadyForUse:(MoviesATDataSource *) dataSource
{
    [self.tableView reloadData];
    [self.activityIndicator stopAnimating];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if( ! [self.dataSource dataReadyForUse] ) {
        [self.activityIndicator startAnimating];
        [self.activityIndicator setHidesWhenStopped: YES];
    }
    return 1;
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MOVIE_VIEW_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"Number of rows in the table: %@", @([self.dataSource numberOfMovies]));
    return [self.dataSource numberOfMovies];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell = [self movieViewForIndex:[indexPath row] withTableViewCell:cell];
    
    return cell;
}

-(void) refreshTableView: (UIRefreshControl *) sender
{
    [self.tableView reloadData];
    [sender endRefreshing];
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataSource deleteMovieAtIndex:[indexPath row]];
    [self.tableView deleteRowsAtIndexPaths: @[indexPath] withRowAnimation: UITableViewRowAnimationAutomatic];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Movie *movie = [self.dataSource movieAtIndex:[indexPath row]];
    MoviesDetailedViewController *mController = [[MoviesDetailedViewController alloc] initWithMovie: movie];
    [self.navigationController pushViewController:mController animated:YES];
}

-(UITableViewCell *) movieViewForIndex: (NSInteger) rowIndex withTableViewCell: (UITableViewCell *) cell
{
    enum { MAIN_VIEW_TAG = 50, LABEL_TAG = 30};
    
    Movie *movie = [self.dataSource movieAtIndex: rowIndex];
    UIView *view = [cell viewWithTag: MAIN_VIEW_TAG];
    
    if( view ) {
        UILabel *aLabel = (UILabel *) [view viewWithTag: LABEL_TAG];
        aLabel.attributedText = [movie descriptionForListEntry];
        return cell;
    }
    
    CGRect bounds = [[UIScreen mainScreen] applicationFrame];
    CGRect viewFrame = CGRectMake(0, 0, bounds.size.width, MOVIE_VIEW_HEIGHT);
    
    UIView *thisView = [[UIView alloc] initWithFrame: viewFrame];
    UILabel *movieInfoLabel = [[UILabel alloc]
                               initWithFrame:CGRectMake(IMAGE_WIDTH + 2 * 10, 5,
                                                        viewFrame.size.width - IMAGE_WIDTH - 10,
                                                        viewFrame.size.height -5)];
    
    movieInfoLabel.tag = LABEL_TAG;
    NSAttributedString *desc = [movie descriptionForListEntry];
    movieInfoLabel.attributedText = desc;
    movieInfoLabel.numberOfLines = 0;
    [thisView addSubview: movieInfoLabel];
    thisView.tag = MAIN_VIEW_TAG;
    [[cell contentView] addSubview:thisView];
    
    return cell;
}


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

@end
