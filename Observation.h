//
//  Observation.h
//  WeatherReadings
//
//  Created by Steve Baker on 11/11/09.
//  Copyright 2009 Beepscore LLC. All rights reserved.
//

#import <CoreData/CoreData.h>
@class Station;

@interface Observation :  NSManagedObject  
{
}

@property (nonatomic, retain) NSDate * observationTime;
@property (nonatomic, retain) NSNumber * temperature;
@property (nonatomic, retain) Station * station;

@end