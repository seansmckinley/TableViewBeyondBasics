//
//  Movie.h
//  TableViewBasics
//
//  Created by AAK on 2/24/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//
//  Edited by Sean McKinley

#import <Foundation/Foundation.h>

@interface Theater : NSObject
-(id) initWithDictionary: (NSDictionary *) dictionary;
-(void) addValue: (NSString *) attrVal forAttribute: (NSString *) attrName;

-(NSString *) getValueForAttribute: (NSString *) attr;
-(NSString *) theaterName;

-(NSAttributedString *) theaterNameForListEntry;
-(NSAttributedString *) addressForListEntry;
-(NSAttributedString *) cityNameForListEntry;
-(NSAttributedString *) stateForListEntry;
-(NSAttributedString *) zipCodeForListEntry;

-(NSAttributedString *) descriptionForListEntry;
-(void) print;


@end
