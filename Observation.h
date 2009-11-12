//
//  Observation.h
//  WeatherReadings
//
//  Created by Steve Baker on 11/11/09.
//  Copyright 2009 Beepscore LLC. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Location;

@interface Observation :  NSManagedObject  
{
}

@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSNumber * temperature;
@property (nonatomic, retain) Location * location;

@end



