//
//  MoviesDetailedViewController.m
//  TableViewBeyondBasics
//
//  Created by AAK on 3/6/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "MoviesDetailedViewController.h"
#import "MoviesAtTheater.h"
#import "Movie.h"

@interface MoviesDetailedViewController ()

@property(nonatomic) MoviesAtTheater *movie;

@end

enum {IMAGE_LEFT_MARGIN = 60, Y_TOP_OF_IMAGE = 44, DESC_LEFT_MARGIN = 10 };

@implementation MoviesDetailedViewController

- (instancetype) initWithMovie: (MoviesAtTheater *) movie
{
    if( (self = [super init]) == nil )
        return nil;
    
    self.movie = movie;
    self.title = [movie title];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    NSURL *url = [NSURL URLWithString: [self.movie title]];
    NSData *strData= [NSData dataWithContentsOfURL:url];

    CGRect appFrame = [[UIScreen mainScreen] applicationFrame];

    
    UILabel *theaterInfoLabel = [[UILabel alloc]
                                 initWithFrame:CGRectMake(0 + 2 * 10, 5,
                                                          appFrame.size.width - 0 - 10,
                                                          appFrame.size.height -5)];
    
    CGRect bounds = [[UIScreen mainScreen] applicationFrame];
    CGRect viewFrame = CGRectMake(0, 0, bounds.size.width, 90);
    UIView *thisView = [[UIView alloc] initWithFrame: viewFrame];
    NSAttributedString *desc = [self.movie descriptionForListEntry];
    theaterInfoLabel.attributedText = desc;
    theaterInfoLabel.numberOfLines = 0;
    [thisView addSubview: theaterInfoLabel];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
