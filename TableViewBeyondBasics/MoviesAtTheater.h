//
//  MoviesAtTheater.h
//  TableViewBeyondBasics
//
//  Created by Sean McKinley on 3/27/15.
//  Copyright (c) 2015 Ali Kooshesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoviesAtTheater : NSObject
-(id) initWithDictionary: (NSDictionary *) dictionary;
-(void) addValue: (NSString *) attrVal forAttribute: (NSString *) attrName;

-(NSString *) getValueForAttribute: (NSString *) attr;
-(NSString *) title;
-(NSString *) theater;
-(NSAttributedString *) titleForListEntry;
-(NSAttributedString *) theaterNameForListEntry;
-(NSAttributedString *) cityNameForListEntry;


-(NSAttributedString *) descriptionForListEntry;
-(void) print;
@end
