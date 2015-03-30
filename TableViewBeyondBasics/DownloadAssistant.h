//
//  DownloadAssistant.h
//  SharedServicesActivityReportingSystem
//
//  Created by Ali Kooshesh on 12/25/13.
//  Copyright (c) 2013 Ali Kooshesh. All rights reserved.
//
//  Edited by Sean McKinley

#import <Foundation/Foundation.h>

@protocol WebDataReadyDelegate;

@interface DownloadAssistant : NSObject<NSURLConnectionDelegate>

@property (nonatomic) id<WebDataReadyDelegate> delegate;

-(void) downloadContentsOfURL: (NSURL *) url;
-(NSData *) downloadedData;

@end

@protocol WebDataReadyDelegate<NSObject>

@required

-(void) acceptWebData: (NSData *) webData forURL: (NSURL *) url;

@end
