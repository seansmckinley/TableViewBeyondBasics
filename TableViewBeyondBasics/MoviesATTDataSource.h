//
//  MoviesATTDataSource.h
//  TableViewBeyondBasics
//
//  Created by Sean McKinley on 3/27/15.
//  Copyright (c) 2015 Ali Kooshesh. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "MoviesAtTheater.h"
#import "DownloadAssistant.h"

@protocol MoviesATTDataSourceReadyForUseDelegate;

@interface MoviesATTDataSource : NSObject<WebDataReadyDelegate>

@property (nonatomic) id<MoviesATTDataSourceReadyForUseDelegate> delegate;
@property (nonatomic) BOOL dataReadyForUse;

-(instancetype) initWithMoviesAtURLString: (NSString *) mURL;

-(MoviesAtTheater *) movieWithTitle: (NSString *) movieTitle;
-(NSMutableArray *) getAllMovies;
-(MoviesAtTheater *) movieAtIndex: (NSInteger) idx;
-(NSInteger) numberOfMovies;
-(NSString *) moviesTabBarTitle;
-(NSString *) moviesTabBarImage;
-(NSString *) moviesBarButtonItemBackButtonTitle;
-(BOOL) deleteMovieAtIndex: (NSInteger) idx;


@end

@protocol MoviesATTDataSourceReadyForUseDelegate <NSObject>

@optional

-(void) dataSourceReadyForUse: (MoviesATTDataSource *) dataSource;

@end
