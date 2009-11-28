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

// in IB, progress indicators bind to these flags
@property (assign) BOOL isImportingStation;
@property (assign) BOOL isImportingObservation;

- (void)populateStationAttributes;

- (NSString *)URLStringForWeatherUndergroundLocation;
- (NSURL *)URLForWeatherUndergroundLocation;
- (NSString *)URLStringForWeatherUndergroundConditions;
- (NSURL *)URLForWeatherUndergroundConditions;

- (IBAction)updateCurrentConditions:(id)sender;

@end

@interface Station (CoreDataGeneratedAccessors)
- (void)addObservationsObject:(Observation *)value;
- (void)removeObservationsObject:(Observation *)value;
@end

