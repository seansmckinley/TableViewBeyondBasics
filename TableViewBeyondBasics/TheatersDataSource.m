//
//  MoviesDataSource.m
//  TableViewBasics
//
//  Created by AAK on 2/24/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "TheatersDataSource.h"

@interface TheatersDataSource() {
    BOOL _debug;
}

@property (nonatomic, copy) NSString *theatersURLString;
@property (nonatomic) NSData *theatersNSData;
@property (nonatomic) NSMutableArray *movieTheaters;
@property (nonatomic) DownloadAssistant *downloadAssistant;


@end

@implementation TheatersDataSource

-(NSMutableArray *) movieTheaters
{
    if( ! _movieTheaters )
        _movieTheaters = [[NSMutableArray alloc] init];
    return _movieTheaters;
}

-(instancetype) initWithTheatersAtURLString: (NSString *) mURL
{
    if( (self = [super init]) == nil )
        return nil;
    self.theatersURLString = mURL;
    _debug = YES;
    _downloadAssistant = [[DownloadAssistant alloc] init];
    
    self.downloadAssistant.delegate = self;
    self.dataReadyForUse = NO;
    
    NSURL *url = [NSURL URLWithString: self.theatersURLString];
    [self.downloadAssistant downloadContentsOfURL:url];
    
    return self;
}

-(void) processMoviesJSON
{
    NSError *parseError = nil;
    NSArray *jsonString =  [NSJSONSerialization JSONObjectWithData:self.theatersNSData options:0 error:&parseError];
    if( _debug )
        NSLog(@"%@", jsonString);
    if( parseError ) {
        NSLog(@"Badly formed JSON string. %@", [parseError localizedDescription] );
        return;
    }
    for ( NSDictionary *theaterTuple in jsonString ) {
        Theater *theater = [[Theater alloc] initWithDictionary:theaterTuple];
        if( _debug) [theater print];
        [self.movieTheaters addObject: theater];
        NSLog(@"num movies %@", @([self.movieTheaters count]));
    }
    self.theatersNSData = nil;
    if( [self.delegate respondsToSelector: @selector( dataSourceReadyForUse:)])
        [self.delegate performSelector: @selector(dataSourceReadyForUse:) withObject:self];
}

-(void) print
{
    for( Theater *t in self.movieTheaters )
        [t print];
}

-(void) acceptWebData:(NSData *)webData forURL:(NSURL *)url
{
    self.theatersNSData = webData;
    [self processMoviesJSON];
    [self print];
    NSLog(@"Completing printing movies.");
    self.dataReadyForUse = YES;
}

-(Theater *) theaterWithName: (NSString *) theaterName
{
    // Not complete...
    
    if(  [self.movieTheaters count] == 0 )
        return nil;
    for( Theater *t in self.movieTheaters )
        if( [t.theaterName isEqualToString: theaterName] )
            return t;
    return nil;
}

-(NSArray *) getTheaters
{
    return self.movieTheaters;
}

-(void) limitToTheater: (NSString *) theater
{
    
}

-(NSInteger) numberOfTheaters
{
    return [self.movieTheaters count];
}
-(BOOL) deleteTheaterAtIndex: (NSInteger) idx
{
    [self.movieTheaters removeObjectAtIndex:idx];
    return YES;
}

-(Theater *) theaterAtIndex: (NSInteger) idx
{
    if( idx >= [self.movieTheaters count] )
        return nil;
    return [self.movieTheaters objectAtIndex: idx];
}

-(NSString *) theatersTabBarTitle
{
    return @"Theaters";
}

-(NSString *) theatersBarButtonItemBackButtonTitle
{
    return @"Theaters";
}

-(NSString *) theatersTabBarImage
{
    return @"46-movie2.png";
}

@end
