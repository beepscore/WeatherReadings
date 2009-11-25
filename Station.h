//
//  Station.h
//  WeatherReadings
//
//  Created by Steve Baker on 11/11/09.
//  Copyright 2009 Beepscore LLC. All rights reserved.
//

#import <CoreData/CoreData.h>
@class Observation;

@interface Station :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * idCode;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSSet* observations;

@end


@interface Station (CoreDataGeneratedAccessors)
- (void)addObservationsObject:(Observation *)value;
- (void)removeObservationsObject:(Observation *)value;

// TODO: Hal has these, but for plural- Observations
//- (void)addObservation:(NSSet *)value;
//- (void)removeObservation:(NSSet *)value;

- (IBAction)updateCurrentConditions:(id)sender;
- (void)populateStationAttributes;


- (NSString *)URLStringForWeatherUndergroundConditions;
- (NSURL *)URLForWeatherUndergroundConditions;
- (NSString *)URLStringForWeatherUndergroundLocation;
- (NSURL *)URLForWeatherUndergroundLocation;

@end

