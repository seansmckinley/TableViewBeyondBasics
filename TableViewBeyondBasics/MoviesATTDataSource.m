//
//  MoviesATTDataSource.m
//  TableViewBeyondBasics
//
//  Created by Sean McKinley on 3/27/15.
//  Copyright (c) 2015 Ali Kooshesh. All rights reserved.
//

//
//  MoviesDataSource.m
//  TableViewBasics
//
//  Created by AAK on 2/24/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "MoviesATTDataSource.h"

@interface MoviesATTDataSource() {
    BOOL _debug;
}

@property (nonatomic, copy) NSString *moviesURLString;
@property (nonatomic) NSData *moviesNSData;

@property (nonatomic) DownloadAssistant *downloadAssistant;


@end

@implementation MoviesATTDataSource

-(NSMutableArray *) allMoviesAtTheaters
{
    if( ! _allMoviesAtTheaters )
        _allMoviesAtTheaters = [[NSMutableArray alloc] init];
    
    return _allMoviesAtTheaters;
}


-(instancetype) initWithMoviesAtURLString: (NSString *) mURL
{
    if( (self = [super init]) == nil )
        return nil;
    self.moviesURLString = mURL;
    
    _debug = YES;
    _downloadAssistant = [[DownloadAssistant alloc] init];
    
    self.downloadAssistant.delegate = self;
    self.dataReadyForUse = NO;
    
    NSURL *url = [NSURL URLWithString: self.moviesURLString];
    [self.downloadAssistant downloadContentsOfURL:url];
    
    return self;
}
-(void) processMoviesJSON
{
    NSError *parseError = nil;
    NSArray *jsonString =  [NSJSONSerialization JSONObjectWithData:self.moviesNSData options:0 error:&parseError];
    if( _debug )
        NSLog(@"%@", jsonString);
    if( parseError ) {
        NSLog(@"Badly formed JSON string. %@", [parseError localizedDescription] );
        return;
    }
    for ( NSDictionary *movieTuple in jsonString ) {
        MoviesAtTheater *movie = [[MoviesAtTheater alloc] initWithDictionary:movieTuple];
        if( _debug) [movie print];
        [self.allMoviesAtTheaters addObject: movie];
        NSLog(@"num movies %@", @([self.allMoviesAtTheaters count]));
    }
    self.moviesNSData = nil;
    if( [self.delegate respondsToSelector: @selector( dataSourceReadyForUse:)])
        [self.delegate performSelector: @selector(dataSourceReadyForUse:) withObject:self];
}


-(void) print
{
    for( MoviesAtTheater *m in self.allMoviesAtTheaters )
        [m print];
}

-(void) acceptWebData:(NSData *)webData forURL:(NSURL *)url
{
    self.moviesNSData = webData;
    [self processMoviesJSON];
    NSLog(@"Completing printing movies.");
    [self print];
    self.dataReadyForUse = YES;
}

-(MoviesAtTheater *) movieWithTitle: (NSString *) movieTitle
{
    // Not complete...
    
    if(  [self.allMoviesAtTheaters count] == 0 )
        return nil;
    for( MoviesAtTheater *movie in self.allMoviesAtTheaters )
        if( [movie.title isEqualToString: movieTitle] )
            return movie;
    return nil;
}

-(NSArray *) getAllMovies
{
    return self.allMoviesAtTheaters;
}

-(void) limitToTheater: (NSString *) theater
{
    
    
}

-(BOOL) deleteMovieAtIndex: (NSInteger) idx
{
    [self.allMoviesAtTheaters removeObjectAtIndex:idx];
    return YES;
}

-(MoviesAtTheater *) movieAtIndex: (NSInteger) idx
{
    if( idx >= [self.allMoviesAtTheaters count] )
        return nil;
    return [self.allMoviesAtTheaters objectAtIndex: idx];
}

-(NSInteger) numberOfMovies
{
    return [self.allMoviesAtTheaters count];
}

-(NSString *) moviesTabBarTitle
{
    return @"Movies";
}

-(NSString *) moviesBarButtonItemBackButtonTitle
{
    return @"Movies";
}

-(NSString *) moviesTabBarImage
{
    return @"46-movie2.png";
}

@end
