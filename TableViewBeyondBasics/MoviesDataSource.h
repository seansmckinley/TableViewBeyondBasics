//
//  MoviesDataSource.h
//  TableViewBasics
//
//  Created by AAK on 2/24/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"
#import "MoviesAtTheater.h"
#import "DownloadAssistant.h"

@protocol MoviesDataSourceReadyForUseDelegate;

@interface MoviesDataSource : NSObject<WebDataReadyDelegate>

@property (nonatomic) id<MoviesDataSourceReadyForUseDelegate> delegate;
@property (nonatomic) BOOL dataReadyForUse;

-(instancetype) initWithMoviesAtURLString: (NSString *) mURL;

-(Movie *) movieWithTitle: (NSString *) movieTitle;

-(NSMutableArray *) getAllMovies;
-(Movie *) movieAtIndex: (NSInteger) idx;


-(NSInteger) numberOfMovies;
-(NSString *) moviesTabBarTitle;
-(NSString *) moviesTabBarImage;
-(NSString *) moviesBarButtonItemBackButtonTitle;
-(BOOL) deleteMovieAtIndex: (NSInteger) idx;


@end

@protocol MoviesDataSourceReadyForUseDelegate <NSObject>

@optional

-(void) dataSourceReadyForUse: (MoviesDataSource *) dataSource;

@end
