//
//  Movie.h
//  TableViewBasics
//
//  Created by AAK on 2/24/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

-(void) addValue: (NSString *) attrVal forAttribute: (NSString *) attrName;
-(NSString *) getValueForAttribute: (NSString *) attr;
-(void) print;

-(NSString *) title;
-(UIImage *)  imageForListEntry;
-(NSAttributedString *) titleForListEntry;
-(NSString *) imageNameForDetailedView;
-(NSString *) htmlDescriptionForDetailedView;
-(NSAttributedString *) descriptionForListEntry;
-(id) initWithDictionary: (NSDictionary *) dictionary;



@end
