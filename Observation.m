// 
//  Observation.m
//  WeatherReadings
//
//  Created by Steve Baker on 11/11/09.
//  Copyright 2009 Beepscore LLC. All rights reserved.
//

#import "Observation.h"
#import "Station.h"
#import "BSGlobalValues.h"

@implementation Observation 

@dynamic observationTime;
@dynamic temperature;
@dynamic station;


// From Marc Gottshall
// To initialize an NSManagedObject, use this method. 
- (void) awakeFromInsert {
    
    DLog(@"Setting default observationTime = current time");    
    self.observationTime = [NSDate date];
}


@end
