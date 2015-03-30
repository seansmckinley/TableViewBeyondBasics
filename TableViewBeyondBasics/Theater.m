//
//  Movie.m
//  TableViewBasics
//
//  Created by AAK on 2/24/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "Theater.h"

enum { VIEW_HEIGHT = 90 };

@interface Theater()

@property (nonatomic) NSMutableDictionary *theaterAttrs;

@end

@implementation Theater

-(id) initWithDictionary: (NSDictionary *) dictionary
{
    if( (self = [super init]) == nil )
        return nil;
    self.theaterAttrs = [NSMutableDictionary dictionaryWithDictionary: dictionary];
    return self;
}

-(void) addValue: (NSString *) attrVal forAttribute: (NSString *) attrName;
{
    [self.theaterAttrs setObject: attrVal forKey: attrName];
}

-(NSString *) getValueForAttribute: (NSString *) attr
{
    return [self.theaterAttrs valueForKey: attr ];
}

-(NSString *) theaterName
{
    return [self.theaterAttrs valueForKey: @"theaterName"];
}

-(CGSize) sizeOfListEntryView
{
    CGRect bounds = [[UIScreen mainScreen] applicationFrame];
    return CGSizeMake( bounds.size.width, VIEW_HEIGHT);
}


-(NSAttributedString *) compose: (NSString *) str withBoldPrefix: (NSString *) prefix
{
    const CGFloat fontSize = 13;
    UIFont *boldFont = [UIFont boldSystemFontOfSize:fontSize];
    UIFont *regularFont = [UIFont systemFontOfSize:fontSize];
    UIFont *italicFont = [UIFont italicSystemFontOfSize:fontSize];
    UIColor *foregroundColor = [UIColor blackColor];
    
    // Create the attributes
    NSMutableDictionary *attrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  regularFont, NSFontAttributeName,
                                  foregroundColor, NSForegroundColorAttributeName, nil];
    
    NSDictionary *boldAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                               boldFont, NSFontAttributeName, nil];
    
    NSMutableAttributedString *attrString = nil;
    if( [prefix isEqualToString: @""] ) {
        [attrs setObject:italicFont forKey:NSFontAttributeName];
        attrString = [[NSMutableAttributedString alloc] initWithString:str attributes:attrs];
    } else {
        NSString *text = [NSString stringWithFormat:@"%@: %@", prefix, str];
        attrString = [[NSMutableAttributedString alloc] initWithString:text attributes:attrs];
        NSRange range = NSMakeRange(0, prefix.length);
        [attrString setAttributes:boldAttrs range:range];
    }
    return attrString;
}

-(NSAttributedString *) descriptionForListEntry
{
    NSMutableAttributedString *theaterName = [[self theaterNameForListEntry] mutableCopy];
    NSMutableAttributedString *address = [[self addressForListEntry] mutableCopy];
    NSMutableAttributedString *cityName = [[self cityNameForListEntry] mutableCopy];
    NSMutableAttributedString *state= [[self stateForListEntry] mutableCopy];
    NSMutableAttributedString *zipCode = [[self zipCodeForListEntry] mutableCopy];
    
    [theaterName replaceCharactersInRange: NSMakeRange(theaterName.length, 0) withString: @"\n"];
    [address replaceCharactersInRange: NSMakeRange(address.length, 0) withString:@"\n"];
    [cityName replaceCharactersInRange: NSMakeRange(cityName.length, 0) withString:@"\n"];
    [state replaceCharactersInRange: NSMakeRange(state.length, 0) withString:@"\n"];

    [theaterName appendAttributedString:address];
    [theaterName appendAttributedString:cityName];
    [theaterName appendAttributedString:state];
    [theaterName appendAttributedString:zipCode];

    return theaterName;
}

-(NSAttributedString *) theaterNameForListEntry
{
    NSString *title = [self theaterName];
    
    return [self compose:title withBoldPrefix:@""];
}

-(NSAttributedString *) addressForListEntry
{
    NSString *address = [self getValueForAttribute: @"address"];
    return [self compose:address withBoldPrefix:@"Address"];
}

-(NSAttributedString *) cityNameForListEntry
{
    NSString *cityName= [self getValueForAttribute: @"cityName"];
    return [self compose:cityName withBoldPrefix:@"City"];
}

-(NSAttributedString *) stateForListEntry
{
    NSString *title = [self getValueForAttribute:@"state"];
    
    return [self compose:title withBoldPrefix:@"State"];
}

-(NSAttributedString *) zipCodeForListEntry
{
    NSString *title = [self getValueForAttribute:@"zipCode"];
    
    return [self compose:title withBoldPrefix:@"Zip"];
}

-(void) print
{
    NSEnumerator *mEnum = [self.theaterAttrs keyEnumerator];
    NSString *attrName;
    while( attrName = (NSString *) [mEnum nextObject] ) {
        NSLog( @"Attribute Name:  %@", attrName );
        NSLog( @"Atrribute Value: %@", [self.theaterAttrs objectForKey: attrName] );
    }
}


@end
