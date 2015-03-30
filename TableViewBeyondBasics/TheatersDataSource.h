//
//  TheatersDataSource.h
//  TableViewBeyondBasics
//
//  Created by Sean McKinley on 3/26/15.
//  Copyright (c) 2015 Ali Kooshesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Theater.h"
#import "DownloadAssistant.h"

@protocol TheatersDataSourceReadyForUseDelegate;

@interface TheatersDataSource : NSObject<WebDataReadyDelegate>

@property (nonatomic) id<TheatersDataSourceReadyForUseDelegate> delegate;
@property (nonatomic) BOOL dataReadyForUse;

-(instancetype) initWithTheatersAtURLString: (NSString *) mURL;
-(Theater *) theaterWithName: (NSString *) theaterName;
-(NSMutableArray *) getTheaters;
-(Theater *) theaterAtIndex: (NSInteger) idx;
-(NSInteger) numberOfTheaters;
-(NSString *) theatersTabBarTitle;
-(NSString *) theatersTabBarImage;
-(NSString *) theatersBarButtonItemBackButtonTitle;
-(BOOL) deleteTheaterAtIndex: (NSInteger) idx;


@end

@protocol TheatersDataSourceReadyForUseDelegate <NSObject>

@optional

-(void) dataSourceReadyForUse: (TheatersDataSource *) dataSource;

@end
