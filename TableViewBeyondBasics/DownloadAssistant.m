//
//  DownloadAssistant.m
//  SharedServicesActivityReportingSystem
//
//  Created by Ali Kooshesh on 12/25/13.
//  Copyright (c) 2013 Ali Kooshesh. All rights reserved.
//
//  Edited by Sean McKinley


#import "DownloadAssistant.h"

@interface DownloadAssistant()

@property (nonatomic) NSMutableData *inData;
@property (nonatomic) NSURLConnection *conn;
@property (nonatomic, strong) NSURL *url;

@end

@implementation DownloadAssistant


-(NSData *) downloadedData
{
    return _inData;
}

-(void) downloadContentsOfURL: (NSURL *) url
{
    self.url = url;
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    if( _conn)
        [_conn cancel];
    _conn = [[NSURLConnection alloc] initWithRequest: request delegate: self startImmediately: YES];
}

-(NSMutableData *) inData
{
    if( ! _inData )
        _inData = [[NSMutableData alloc] init];
    return _inData;
}
-(void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *) response {
    
}

// Called each time some data arrives.
-(void) connection:(NSURLConnection *) connection didReceiveData:(NSData *)data {
    NSLog( @"received %@ bytes.", @([data length]));
    [self.inData appendData: data];
}

// Called when last segment arrives.
-(void) connectionDidFinishLoading: (NSURLConnection *) connection {
    NSLog( @"Finished download." );
    NSLog( @"The file has %@ bytes.", @([_inData length]));
    NSString *string = [[NSString alloc] initWithData:_inData encoding:NSUTF8StringEncoding];
    NSLog( @"%@", string);
    if( [self.delegate respondsToSelector:@selector(acceptWebData:forURL:)] )
        [self.delegate acceptWebData:_inData forURL:_url];
    _inData = nil;
        
}

// Called if the fetch fails.
-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog( @"Connection failed: %@", error );
    _inData = nil;
}


@end
