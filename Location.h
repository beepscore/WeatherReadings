//
//  Location.h
//  WeatherReadings
//
//  Created by Steve Baker on 11/11/09.
//  Copyright 2009 Beepscore LLC. All rights reserved.
//

#import <CoreData/CoreData.h>
@class Observation;

@interface Location :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * lat;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * lon;
@property (nonatomic, retain) NSString * idCode;
@property (nonatomic, retain) NSSet* observations;

@end


@interface Location (CoreDataGeneratedAccessors)
- (void)addObservationsObject:(Observation *)value;
- (void)removeObservationsObject:(Observation *)value;

//- (void)addObservation:(NSSet *)value;
//- (void)removeObservation:(NSSet *)value;

@end

