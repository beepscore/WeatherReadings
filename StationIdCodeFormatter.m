//
//  StationIdCodeFormatter.m
//  WeatherReadings
//
//  Created by Steve Baker on 11/17/09.
//  Copyright 2009 Beepscore LLC. All rights reserved.
//

#import "StationIdCodeFormatter.h"
#import "BSGlobalValues.h"


// private method
@interface StationIdCodeFormatter ()
- (NSString *)formatAsStationIdCode:(NSString *)unformattedString;
@end

@implementation StationIdCodeFormatter

#pragma mark Formatter methods
// Ref Hillegass pg 328-334
// The view control sends this message to formatter
// Formatter converts string to an object
- (BOOL) getObjectValue:(id *)anObject
              forString:(NSString *)aString
       errorDescription:(NSString **)errorPtr {
    
    NSString *tempString = [self formatAsStationIdCode:aString];
    if (tempString) {
        *anObject = tempString;
        return YES;
    } else {
        if (errorPtr != NULL) {
            *errorPtr = 
            [NSString stringWithFormat:@"'%@' is not a string", aString];
        }
        return NO;   
    }    
}

// The view control sends this message to formatter
// Formatter converts object to a string
- (NSString *)stringForObjectValue:(id)anObject {
    
    if (nil == anObject) {
        DLog(@"Object is nil.  Please provide a non-nil object.");
        return nil;
    }
    
    // Convert to string if necessary
    if (![anObject isKindOfClass:[NSString class]]) {
        return [self formatAsStationIdCode:[anObject description]];
    } else {
        return [self formatAsStationIdCode:anObject];
    }
}


- (NSString *)formatAsStationIdCode:(NSString *)unformattedString {
        
    // Is the string zero length?
    if (0 == [unformattedString length]) {
        DLog(@"String length is zero.  Please enter a string.");
        return nil;
    }
    
    NSString *formattedString = [[[NSMutableString alloc] initWithString:@""] autorelease];
    
    // Remove all non-alpha characters
    // Ref http://stackoverflow.com/questions/1129521/remove-all-but-numbers-from-nsstring
    for (int i=0; i<[unformattedString length]; i++) {
        if (isalpha([unformattedString characterAtIndex:i])) {
            NSString *tempString = [NSString stringWithFormat:@"%c",
                                    [unformattedString characterAtIndex:i]];
            formattedString = [formattedString stringByAppendingString:tempString];
        }
    }    
    
    // Cut string to maximum length 4
    if ([formattedString length] > 4 ) {
        formattedString = [formattedString substringToIndex:4];
    }
    
    // Convert characters to uppercase
    formattedString = [formattedString uppercaseString];
    
    return formattedString;
}

@end
